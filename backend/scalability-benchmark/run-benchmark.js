/**
 * run-benchmark.js
 * 
 * Compiles circuits, performs trusted setup, and benchmarks:
 *   - R1CS constraint count
 *   - Wires, Public Inputs, Private Inputs
 *   - R1CS file size (KiB)
 *   - Witness generation time (ms) - in-memory
 *   - Groth16 proof generation time (ms) - in-memory witness
 *   - Verification time (ms) - in-memory verification key
 *   - Proof size (bytes)
 *   - One-time compilation & trusted setup times (ms)
 * 
 * Uses Groth16 proving system on BN128 curve with pot12_final.ptau.
 * Executes 2 warm-up iterations (excluded from statistics) followed by
 * 10 measured repetitions per circuit size.
 * 
 * This is a synthetic equality-verification benchmark isolating zk-SNARK
 * constraint scaling. It does NOT represent the full document-verification pipeline.
 */

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const snarkjs = require('snarkjs');

// ============================================
// Configuration
// ============================================

const SIZES = [1, 5, 10, 20, 50, 100];
const WARMUP_REPETITIONS = 2;
const MEASURED_REPETITIONS = 10;
const CIRCOM_BIN = path.join(__dirname, 'tools', 'circom.exe');
const PTAU_FILE = path.join(__dirname, '..', 'zk-document-verification', 'pot12_final.ptau');
const CIRCUITS_DIR = path.join(__dirname, 'circuits');
const BUILD_DIR = path.join(__dirname, 'build');
const INPUTS_DIR = path.join(__dirname, 'inputs');
const RESULTS_DIR = path.join(__dirname, 'results');

// ============================================
// Utility functions
// ============================================

function ensureDir(dir) {
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
}

async function timeMsAsync(fn) {
  const start = process.hrtime.bigint();
  const result = await fn();
  const end = process.hrtime.bigint();
  return { result, ms: Number(end - start) / 1e6 };
}

function mean(arr) {
  if (arr.length === 0) return 0;
  return arr.reduce((a, b) => a + b, 0) / arr.length;
}

function sampleStddev(arr) {
  if (arr.length <= 1) return 0;
  const m = mean(arr);
  return Math.sqrt(arr.reduce((s, v) => s + (v - m) ** 2, 0) / (arr.length - 1));
}

function fileSizeKiB(filepath) {
  const stats = fs.statSync(filepath);
  return stats.size / 1024;
}

function fileSizeBytes(filepath) {
  const stats = fs.statSync(filepath);
  return stats.size;
}

// ============================================
// Main benchmark
// ============================================

async function main() {
  console.log('================================================================');
  console.log(' ZKP-DOCVerify Scalability Benchmark (v2 - Fixed with Warm-ups)');
  console.log(' Synthetic equality-verification circuits (IsEqual-based)');
  console.log(' In-memory witness generation & Groth16 proving');
  console.log('================================================================\n');

  // Record environment
  const envInfo = {
    date: new Date().toISOString(),
    platform: process.platform,
    arch: process.arch,
    nodeVersion: process.version,
    circomVersion: '2.2.3',
    snarkjsVersion: '0.7.6',
    provingSystem: 'Groth16',
    curve: 'BN128',
    ptauFile: 'pot12_final.ptau (2^12 = 4096 max constraints)',
    warmupRepetitions: WARMUP_REPETITIONS,
    measuredRepetitions: MEASURED_REPETITIONS,
    witnessStorage: 'in-memory (Buffer / { type: "mem" }, no intermediate disk write)',
    timingMethod: 'process.hrtime.bigint() (monotonic high-resolution, converted to ms)',
    standardDeviationFormula: 'sample standard deviation (denominator n - 1 = 9)',
    fileSizeUnit: 'KiB (1024 bytes per KiB)'
  };

  console.log('Environment:');
  Object.entries(envInfo).forEach(([k, v]) => console.log(`  ${k}: ${v}`));
  console.log('');

  // Verify prerequisites
  if (!fs.existsSync(CIRCOM_BIN)) {
    console.error(`ERROR: Circom binary not found at ${CIRCOM_BIN}`);
    process.exit(1);
  }
  if (!fs.existsSync(PTAU_FILE)) {
    console.error(`ERROR: PTAU file not found at ${PTAU_FILE}`);
    process.exit(1);
  }

  ensureDir(BUILD_DIR);
  ensureDir(RESULTS_DIR);

  const allResults = [];
  const rawTimings = [];
  const failedRuns = [];

  for (const size of SIZES) {
    const circuitName = `ScaleBench_${size}`;
    const circuitFile = path.join(CIRCUITS_DIR, `${circuitName}.circom`);
    const buildSubDir = path.join(BUILD_DIR, circuitName);
    ensureDir(buildSubDir);

    console.log(`\n${'='.repeat(60)}`);
    console.log(` Circuit: ${circuitName} (${size} attributes)`);
    console.log(`${'='.repeat(60)}`);

    // ---- Step 1: Compile circuit ----
    console.log('\n  [1/6] Compiling circuit with Circom 2.2.3...');
    const r1csFile = path.join(buildSubDir, `${circuitName}.r1cs`);
    const wasmDir = path.join(buildSubDir, `${circuitName}_js`);
    const wasmFile = path.join(wasmDir, `${circuitName}.wasm`);

    let compilationTimeMs;
    try {
      const compileCmd = `"${CIRCOM_BIN}" "${circuitFile}" --r1cs --wasm --sym -o "${buildSubDir}" -l "${path.join(__dirname, 'node_modules')}"`;
      const compStart = process.hrtime.bigint();
      execSync(compileCmd, { stdio: 'pipe', timeout: 120000 });
      const compEnd = process.hrtime.bigint();
      compilationTimeMs = Number(compEnd - compStart) / 1e6;
      console.log(`        ✓ Compiled in ${compilationTimeMs.toFixed(1)} ms`);
    } catch (err) {
      console.error(`        ✗ Compilation FAILED: ${err.message}`);
      if (err.stderr) console.error(`          ${err.stderr.toString().trim()}`);
      failedRuns.push({ size, stage: 'compilation', error: err.message });
      continue;
    }

    // ---- Step 2: Read compiler R1CS info ----
    console.log('  [2/6] Reading R1CS info from compiler output...');
    let r1csInfo;
    try {
      const r1csInfoCmd = `npx snarkjs r1cs info "${r1csFile}" 2>&1`;
      const infoOutput = execSync(r1csInfoCmd, { 
        cwd: __dirname, 
        stdio: 'pipe', 
        timeout: 30000 
      }).toString();
      
      const constraintMatch = infoOutput.match(/# of Constraints:\s*(\d+)/);
      const wireMatch = infoOutput.match(/# of Wires:\s*(\d+)/);
      const privMatch = infoOutput.match(/# of Private Inputs:\s*(\d+)/);
      const pubMatch = infoOutput.match(/# of Public Inputs:\s*(\d+)/);

      r1csInfo = {
        constraints: constraintMatch ? parseInt(constraintMatch[1]) : -1,
        wires: wireMatch ? parseInt(wireMatch[1]) : -1,
        privateInputs: privMatch ? parseInt(privMatch[1]) : -1,
        publicInputs: pubMatch ? parseInt(pubMatch[1]) : -1,
        fileSizeKiB: fileSizeKiB(r1csFile),
        fileSizeBytes: fileSizeBytes(r1csFile),
      };
      console.log(`        Constraints:    ${r1csInfo.constraints}`);
      console.log(`        Wires:          ${r1csInfo.wires}`);
      console.log(`        Private inputs: ${r1csInfo.privateInputs}`);
      console.log(`        Public inputs:  ${r1csInfo.publicInputs}`);
      console.log(`        R1CS file size: ${r1csInfo.fileSizeKiB.toFixed(2)} KiB (${r1csInfo.fileSizeBytes} bytes)`);
    } catch (err) {
      console.error(`        ✗ R1CS info FAILED: ${err.message}`);
      failedRuns.push({ size, stage: 'r1cs_info', error: err.message });
      continue;
    }

    // ---- Step 3: Groth16 Trusted Setup ----
    console.log('  [3/6] Running Groth16 trusted setup (Phase 2)...');
    const zkey0File = path.join(buildSubDir, `${circuitName}_0000.zkey`);
    const zkeyFinalFile = path.join(buildSubDir, `${circuitName}_final.zkey`);
    const vkeyFile = path.join(buildSubDir, `verification_key.json`);

    let setupTimeMs;
    let vkeyObj;
    try {
      const setupStart = process.hrtime.bigint();

      await snarkjs.zKey.newZKey(r1csFile, PTAU_FILE, zkey0File);
      await snarkjs.zKey.contribute(zkey0File, zkeyFinalFile, 'benchmark_contributor', 'benchmark_entropy_12345');
      vkeyObj = await snarkjs.zKey.exportVerificationKey(zkeyFinalFile);
      fs.writeFileSync(vkeyFile, JSON.stringify(vkeyObj, null, 2));

      // Clean up intermediate zkey0 to save disk space
      try { fs.unlinkSync(zkey0File); } catch (e) { /* ignore */ }

      const setupEnd = process.hrtime.bigint();
      setupTimeMs = Number(setupEnd - setupStart) / 1e6;
      console.log(`        ✓ Setup completed in ${setupTimeMs.toFixed(1)} ms`);
    } catch (err) {
      console.error(`        ✗ Setup FAILED: ${err.message}`);
      failedRuns.push({ size, stage: 'setup', error: err.message });
      continue;
    }

    // ---- Step 4: Test negative inputs (Invalid rejection) ----
    console.log('  [4/6] Testing invalid witness / constraint rejection...');
    const invalidInputFile = path.join(INPUTS_DIR, `input_${size}_invalid.json`);
    let invalidRejected = false;

    try {
      const invalidInput = JSON.parse(fs.readFileSync(invalidInputFile, 'utf8'));
      const invalidWtns = { type: 'mem' };
      try {
        await snarkjs.wtns.calculate(invalidInput, wasmFile, invalidWtns);
        // If witness generation unexpectedly passed, test proof verification
        try {
          const { proof, publicSignals } = await snarkjs.groth16.prove(zkeyFinalFile, invalidWtns);
          const valid = await snarkjs.groth16.verify(vkeyObj, publicSignals, proof);
          if (!valid) {
            invalidRejected = true;
            console.log('        ✓ Invalid claim correctly rejected during proof verification');
          } else {
            console.error('        ⚠ SECURITY WARNING: Invalid claim verified!');
          }
        } catch (proofErr) {
          invalidRejected = true;
          console.log('        ✓ Invalid claim correctly rejected during proving');
        }
      } catch (witnessErr) {
        invalidRejected = true;
        console.log('        ✓ Invalid input correctly rejected at witness generation (constraint assertion)');
        console.log(`          Detail: ${witnessErr.message.split('\n')[0].substring(0, 80)}`);
      }
    } catch (err) {
      console.error(`        ⚠ Could not execute invalid input test: ${err.message}`);
    }

    // ---- Step 5: Warm-up Runs (Excluded from statistics) ----
    console.log(`  [5/6] Executing ${WARMUP_REPETITIONS} warm-up iterations (excluded from statistics)...`);
    const validInputFile = path.join(INPUTS_DIR, `input_${size}_valid.json`);
    const validInput = JSON.parse(fs.readFileSync(validInputFile, 'utf8'));
    let warmupsSuccessful = true;

    for (let w = 1; w <= WARMUP_REPETITIONS; w++) {
      try {
        const warmupWtns = { type: 'mem' };
        await snarkjs.wtns.calculate(validInput, wasmFile, warmupWtns);
        const { proof, publicSignals } = await snarkjs.groth16.prove(zkeyFinalFile, warmupWtns);
        const valid = await snarkjs.groth16.verify(vkeyObj, publicSignals, proof);
        if (!valid) {
          warmupsSuccessful = false;
          console.error(`        ✗ Warm-up ${w} verification failed!`);
          failedRuns.push({ size, stage: `warmup_${w}`, error: 'Verification failed' });
        } else {
          console.log(`        ✓ Warm-up ${w}/${WARMUP_REPETITIONS} completed & verified`);
        }
      } catch (err) {
        warmupsSuccessful = false;
        console.error(`        ✗ Warm-up ${w} failed: ${err.message}`);
        failedRuns.push({ size, stage: `warmup_${w}`, error: err.message });
      }
    }

    // ---- Step 6: Measured Repetitions ----
    console.log(`  [6/6] Executing ${MEASURED_REPETITIONS} timed repetitions (in-memory)...`);
    const witnessTimes = [];
    const proveTimes = [];
    const verifyTimes = [];
    let proofSizeBytes = 0;
    let allProofsVerified = true;

    for (let rep = 1; rep <= MEASURED_REPETITIONS; rep++) {
      try {
        // 1. Witness generation (in-memory, no disk I/O)
        const wtns = { type: 'mem' };
        const witnessResult = await timeMsAsync(async () => {
          await snarkjs.wtns.calculate(validInput, wasmFile, wtns);
        });
        witnessTimes.push(witnessResult.ms);

        // 2. Groth16 proof generation (in-memory witness, zkey cached by OS)
        const proveResult = await timeMsAsync(async () => {
          return await snarkjs.groth16.prove(zkeyFinalFile, wtns);
        });
        proveTimes.push(proveResult.ms);

        const { proof, publicSignals } = proveResult.result;

        // Measure proof size on rep 1
        if (rep === 1) {
          proofSizeBytes = Buffer.byteLength(JSON.stringify(proof), 'utf8');
          fs.writeFileSync(path.join(buildSubDir, 'proof.json'), JSON.stringify(proof, null, 2));
          fs.writeFileSync(path.join(buildSubDir, 'public.json'), JSON.stringify(publicSignals, null, 2));
        }

        // 3. Proof verification (in-memory, pre-parsed vkeyObj)
        const verifyResult = await timeMsAsync(async () => {
          return await snarkjs.groth16.verify(vkeyObj, publicSignals, proof);
        });
        verifyTimes.push(verifyResult.ms);

        if (!verifyResult.result) {
          allProofsVerified = false;
          console.error(`        ✗ Proof verification failed on repetition ${rep}`);
          failedRuns.push({ size, stage: `rep_${rep}_verify`, error: 'Verification returned false' });
        }
      } catch (err) {
        console.error(`        ✗ Repetition ${rep} failed: ${err.message}`);
        failedRuns.push({ size, stage: `rep_${rep}`, error: err.message });
      }
    }

    // Compute summary metrics (sample standard deviation: n - 1 = 9)
    const result = {
      attributes: size,
      constraints: r1csInfo.constraints,
      wires: r1csInfo.wires,
      publicInputs: r1csInfo.publicInputs,
      privateInputs: r1csInfo.privateInputs,
      witnessTimeMean: parseFloat(mean(witnessTimes).toFixed(2)),
      witnessTimeStddev: parseFloat(sampleStddev(witnessTimes).toFixed(2)),
      proveTimeMean: parseFloat(mean(proveTimes).toFixed(2)),
      proveTimeStddev: parseFloat(sampleStddev(proveTimes).toFixed(2)),
      verifyTimeMean: parseFloat(mean(verifyTimes).toFixed(2)),
      verifyTimeStddev: parseFloat(sampleStddev(verifyTimes).toFixed(2)),
      r1csSizeKiB: parseFloat(r1csInfo.fileSizeKiB.toFixed(2)),
      r1csSizeBytes: r1csInfo.fileSizeBytes,
      proofSizeBytes,
      compilationTimeMs: parseFloat(compilationTimeMs.toFixed(1)),
      setupTimeMs: parseFloat(setupTimeMs.toFixed(1)),
      warmupReps: WARMUP_REPETITIONS,
      measuredReps: witnessTimes.length,
      allProofsVerified,
      invalidRejected,
      warmupsSuccessful,
    };

    allResults.push(result);
    rawTimings.push({
      attributes: size,
      witnessTimes,
      proveTimes,
      verifyTimes,
    });

    console.log(`\n  Results for ${circuitName}:`);
    console.log(`    Constraints:       ${result.constraints}`);
    console.log(`    Wires:             ${result.wires}`);
    console.log(`    Public/Private:    ${result.publicInputs} / ${result.privateInputs}`);
    console.log(`    R1CS file size:    ${result.r1csSizeKiB} KiB (${result.r1csSizeBytes} bytes)`);
    console.log(`    Proof size:        ${result.proofSizeBytes} bytes`);
    console.log(`    Witness (mean±sd): ${result.witnessTimeMean} ± ${result.witnessTimeStddev} ms`);
    console.log(`    Prove (mean±sd):   ${result.proveTimeMean} ± ${result.proveTimeStddev} ms`);
    console.log(`    Verify (mean±sd):  ${result.verifyTimeMean} ± ${result.verifyTimeStddev} ms`);
    console.log(`    All verified:      ${result.allProofsVerified ? '✓' : '✗'}`);
    console.log(`    Invalid rejected:  ${result.invalidRejected ? '✓' : '✗'}`);
  }

  // ============================================
  // Write Output Files
  // ============================================

  console.log('\n================================================================');
  console.log(' Generating Result Files');
  console.log('================================================================\n');

  // 1. Raw timings CSV (contains all 10 individual measured repetitions)
  const rawHeader = 'Attributes,Repetition,Witness_ms,Prove_ms,Verify_ms';
  const rawRows = [];
  for (const rt of rawTimings) {
    for (let i = 0; i < rt.witnessTimes.length; i++) {
      rawRows.push([
        rt.attributes,
        i + 1,
        rt.witnessTimes[i].toFixed(2),
        rt.proveTimes[i].toFixed(2),
        rt.verifyTimes[i].toFixed(2),
      ].join(','));
    }
  }
  fs.writeFileSync(
    path.join(RESULTS_DIR, 'raw_timings.csv'),
    [rawHeader, ...rawRows].join('\n')
  );
  console.log(`  ✓ Written ${path.join(RESULTS_DIR, 'raw_timings.csv')} (${rawRows.length} rows)`);

  // 2. Results Summary CSV
  const summaryHeader = [
    'Attributes', 'Constraints', 'Wires', 'Public_Inputs', 'Private_Inputs',
    'Witness_Mean_ms', 'Witness_Stddev_ms',
    'Prove_Mean_ms', 'Prove_Stddev_ms',
    'Verify_Mean_ms', 'Verify_Stddev_ms',
    'R1CS_Size_KiB', 'Proof_Size_Bytes',
    'Compilation_ms', 'Setup_ms',
    'Warmup_Reps', 'Measured_Reps', 'All_Verified', 'Invalid_Rejected'
  ].join(',');

  const summaryRows = allResults.map(r => [
    r.attributes, r.constraints, r.wires, r.publicInputs, r.privateInputs,
    r.witnessTimeMean, r.witnessTimeStddev,
    r.proveTimeMean, r.proveTimeStddev,
    r.verifyTimeMean, r.verifyTimeStddev,
    r.r1csSizeKiB, r.proofSizeBytes,
    r.compilationTimeMs, r.setupTimeMs,
    r.warmupReps, r.measuredReps, r.allProofsVerified, r.invalidRejected
  ].join(','));

  fs.writeFileSync(
    path.join(RESULTS_DIR, 'results_summary.csv'),
    [summaryHeader, ...summaryRows].join('\n')
  );
  console.log(`  ✓ Written ${path.join(RESULTS_DIR, 'results_summary.csv')}`);

  // 3. Environment JSON
  fs.writeFileSync(
    path.join(RESULTS_DIR, 'environment.json'),
    JSON.stringify(envInfo, null, 2)
  );
  console.log(`  ✓ Written ${path.join(RESULTS_DIR, 'environment.json')}`);

  // 4. Full Results JSON
  fs.writeFileSync(
    path.join(RESULTS_DIR, 'full_results.json'),
    JSON.stringify({ 
      environment: envInfo, 
      results: allResults, 
      rawObservations: rawTimings,
      failedRuns 
    }, null, 2)
  );
  console.log(`  ✓ Written ${path.join(RESULTS_DIR, 'full_results.json')}`);

  // 5. Comparison with Manuscript Table 4
  const manuscriptTable4 = [
    { attributes: 1,   constraints: 3,   witness: 36, prove: 495, verify: 335, r1csKB: 0.52 },
    { attributes: 5,   constraints: 15,  witness: 36, prove: 369, verify: 455, r1csKB: 2.10 },
    { attributes: 10,  constraints: 30,  witness: 59, prove: 384, verify: 315, r1csKB: 4.10 },
    { attributes: 20,  constraints: 60,  witness: 54, prove: 379, verify: 323, r1csKB: 8.00 },
    { attributes: 50,  constraints: 150, witness: 47, prove: 416, verify: 350, r1csKB: 20.0 },
    { attributes: 100, constraints: 300, witness: 47, prove: 486, verify: 325, r1csKB: 40.0 },
  ];

  const compHeader = 'Attributes,Constraints_Manuscript,Constraints_Measured,Constraints_Match,R1CS_KiB_Manuscript,R1CS_KiB_Measured,Witness_Manuscript_ms,Witness_Measured_ms,Prove_Manuscript_ms,Prove_Measured_ms,Verify_Manuscript_ms,Verify_Measured_ms';
  const compRows = manuscriptTable4.map(ms => {
    const m = allResults.find(r => r.attributes === ms.attributes);
    if (!m) return '';
    return [
      ms.attributes,
      ms.constraints, m.constraints, ms.constraints === m.constraints,
      ms.r1csKB, m.r1csSizeKiB,
      ms.witness, m.witnessTimeMean,
      ms.prove, m.proveTimeMean,
      ms.verify, m.verifyTimeMean,
    ].join(',');
  }).filter(r => r);

  fs.writeFileSync(
    path.join(RESULTS_DIR, 'comparison_with_manuscript.csv'),
    [compHeader, ...compRows].join('\n')
  );
  console.log(`  ✓ Written ${path.join(RESULTS_DIR, 'comparison_with_manuscript.csv')}`);

  console.log('\n================================================================');
  console.log(' EXECUTION SUMMARY');
  console.log('================================================================');
  console.log(`  Circuits tested:       ${allResults.length} / ${SIZES.length}`);
  console.log(`  Warm-up runs per size: ${WARMUP_REPETITIONS} (excluded from stats)`);
  console.log(`  Measured runs per size:${MEASURED_REPETITIONS}`);
  console.log(`  All proofs verified:   ${allResults.every(r => r.allProofsVerified) ? 'YES' : 'NO'}`);
  console.log(`  All invalid rejected:  ${allResults.every(r => r.invalidRejected) ? 'YES' : 'NO'}`);
  console.log(`  Failed runs:           ${failedRuns.length}`);
  console.log('\n✓ Benchmark completed successfully.\n');
}

main().catch(err => {
  console.error('FATAL BENCHMARK ERROR:', err);
  process.exit(1);
});
