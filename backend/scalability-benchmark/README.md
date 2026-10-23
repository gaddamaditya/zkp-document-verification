# Scalability Benchmark — ZKP-DOCVerify

Isolated synthetic benchmark for verifying Table 4 of the research paper
*"Selective-Disclosure Document Verification Using OCR and zk-SNARKs"*
(ICDCN 2027 — SecDLT Workshop).

## What This Benchmark Does

This benchmark generates **parameterized Circom 2 circuits** with 1, 5, 10, 20, 50, and 100
equality-verified attributes. Each attribute consists of a private input and a public input, with
equality enforced via circomlib's `IsEqual` component (which generates real R1CS constraints).

**This is a synthetic benchmark** that isolates circuit-size scaling effects.
It does **not** use Poseidon commitments or represent the full document-verification protocol.

## Circuit Design

Each generated circuit (`ScaleBench_N`) contains:
- `N` private inputs (`priv_0` through `priv_{N-1}`)
- `N` public inputs (`pub_0` through `pub_{N-1}`)
- `N` IsEqual components verifying `priv_i == pub_i`
- AND chain producing single `allMatch` output (constrained to equal 1)

### Why IsEqual Instead of Direct Equality?

In Circom 2, direct equality assertions (`a === b`) are enforced as **wire identities** at compile
time and generate **0 R1CS constraints**. Using `IsEqual` from circomlib generates real R1CS
constraints (2 per attribute from the internal `IsZero` component), making timing measurements
meaningful.

## Prerequisites

- **Node.js** (v16+)
- **npm**
- Circom 2 binary is included in `tools/circom.exe`
- Powers of Tau file is reused from the main project (`../zk-document-verification/pot12_final.ptau`)

## Toolchain Versions

| Component  | Version |
|------------|---------|
| Circom     | 2.2.3   |
| SnarkJS    | 0.7.6   |
| Circomlib  | ^2.0.5  |
| Proving System | Groth16 |
| Curve      | BN128   |

## How to Reproduce

```bash
# 1. Navigate to the benchmark directory
cd backend/scalability-benchmark

# 2. Install dependencies (if not already done)
npm install

# 3. Generate circuit files and inputs
node generate-circuits.js

# 4. Run the full benchmark (compile, setup, measure)
node run-benchmark.js

# Or run both steps at once:
npm run full
```

## Output Files

After running, the `results/` directory contains:

| File | Description |
|------|-------------|
| `results_summary.csv` | Mean ± stddev for all measurements |
| `raw_timings.csv` | Individual timing for every repetition |
| `comparison_with_manuscript.csv` | Side-by-side comparison with Table 4 |
| `environment.json` | Machine and toolchain metadata |
| `full_results.json` | Complete structured results |

## Measurements Collected

For each circuit size (10 repetitions):

1. **R1CS constraint count** — from SnarkJS r1cs info
2. **R1CS file size** — in KB
3. **Witness generation time** — in ms (mean ± stddev)
4. **Proof generation time** — in ms (mean ± stddev)
5. **Verification time** — in ms (mean ± stddev)
6. **Proof size** — in bytes (JSON-serialized Groth16 proof)

Compilation and trusted setup are measured separately and excluded from per-repetition timings.

## Correctness Checks

- Valid inputs produce proofs that **verify successfully**
- Invalid inputs (mismatched first attribute) are **rejected** at witness generation
  (the `allMatch === 1` constraint fails)

## Directory Structure

```
scalability-benchmark/
├── package.json
├── generate-circuits.js     ← Generates .circom files and input JSON
├── run-benchmark.js         ← Compiles, sets up, benchmarks, outputs CSV
├── README.md                ← This file
├── tools/
│   └── circom.exe           ← Circom 2.2.3 (Windows amd64)
├── circuits/                ← Generated .circom files (created by generate-circuits.js)
├── inputs/                  ← Input JSON files (valid + invalid per size)
├── build/                   ← Compiled R1CS, WASM, zkeys (created by run-benchmark.js)
└── results/                 ← CSV and JSON output (created by run-benchmark.js)
```
