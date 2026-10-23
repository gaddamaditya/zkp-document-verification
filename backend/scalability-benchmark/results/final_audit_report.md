# Independent Audit and Validation Report: ZKP-DOCVerify Scalability Benchmark (v2)

**Evaluation Date:** October 22, 2026  
**Auditor:** Independent Technical Auditor  
**Scope:** Circom 2.2.3 compilation, Groth16 trusted setup, in-memory witness generation, proof generation, proof verification, warm-up exclusion, and data integrity audit for Table 4 in the ICDCN 2027 paper submission.  
**Hardware & OS:** Windows 11 x64, AMD64, Node.js v22.19.0, SnarkJS 0.7.6, Circom 2.2.3, BN128 curve.

---

## 1. Executive Summary & Audit Check Outcomes

| Audit Item | Status | Verification Detail |
|---|:---:|---|
| **Warm-Up Exclusion** | **PASS** | 2 warm-up iterations executed per circuit size. Both completed successfully and were cryptographically verified. Both were strictly excluded from the 10 recorded repetitions. |
| **Ten Measured Repetitions** | **PASS** | Exactly 10 measured repetitions recorded per size ($6 \times 10 = 60$ raw observation rows in `raw_timings.csv`). Zero missing or dropped measurements. |
| **In-Memory Witness Passing** | **PASS** | `{ type: "mem" }` witness buffer implemented. Eliminates intermediate `.wtns` file creation and deletion from disk during timed witness generation and proving loops. |
| **High-Resolution Monotonic Timing** | **PASS** | `process.hrtime.bigint()` isolated around each target operation (witness calculation, proving, and verification measured separately). |
| **Separation of Setup Costs** | **PASS** | One-time compilation (`Compilation_ms`) and trusted setup (`Setup_ms`) reported in distinct columns, decoupled from recurring proof metrics. |
| **Constraint Count Verification** | **PASS** | Compiler output verified via `snarkjs r1cs info` and `snarkjs r1cs print`: $4 \times N$ constraints across all attribute counts ($N \in \{1, 5, 10, 20, 50, 100\}$). |
| **R1CS & Proof File Measurement** | **PASS** | Measured from physical files on disk via `fs.statSync` (KiB = bytes / 1024). Proof size measured from compact serialized JSON buffers (719–725 bytes). |
| **Cryptographic Verification** | **PASS** | 100% of generated proofs ($60/60$) verified successfully using `snarkjs.groth16.verify`. |
| **Negative Constraint Enforcement** | **PASS** | Mismatched inputs ($pub_0 \neq priv_0$) rejected at witness generation stage via Circom assertion failure (`Assert Failed. Error in template ScaleBench_N line ...`). |
| **Archive of Previous Run** | **PASS** | Initial benchmark results safely archived under `backend/scalability-benchmark/results_archive_initial_run/`. |
| **Old Manuscript Table 4 Support** | **FAIL** | Zero artifacts in the repository support the manuscript's $3N$ constraint counts or its reported timings (which are off by $5\times$ to $25\times$). Recommendation: **Retract old values.** |

---

## 2. Final Results Table (Verified Measurements Only)

*Measured under Node.js v22.19.0, Circom 2.2.3, SnarkJS 0.7.6 on BN128 / Groth16. Each configuration evaluated with 2 discarded warm-up runs followed by 10 timed repetitions. All timings reported as $\text{mean} \pm \text{sample standard deviation}$ ($s_{n-1}$, $n=10, n-1=9$):*

| Attributes ($N$) | Constraints (R1CS) | Wires | Inputs (Pub / Priv) | Witness Time (ms)<br>$\text{mean} \pm s$ | Proof Time (ms)<br>$\text{mean} \pm s$ | Verify Time (ms)<br>$\text{mean} \pm s$ | R1CS Size (KiB) | Proof Size (Bytes) | Compilation (ms) | Setup (ms) |
|---:|---:|---:|:---:|:---:|:---:|:---:|---:|---:|---:|---:|
| **1** | 4 | 6 | 1 / 1 | $18.90 \pm 3.69$ | $109.43 \pm 15.79$ | $29.28 \pm 22.16$ | 0.59 | 725 | 125.6 | 1148.7 |
| **5** | 20 | 30 | 5 / 5 | $17.85 \pm 3.15$ | $72.94 \pm 8.36$ | $24.88 \pm 3.75$ | 2.65 | 721 | 176.3 | 135.8 |
| **10** | 40 | 60 | 10 / 10 | $19.57 \pm 8.46$ | $61.59 \pm 8.67$ | $22.19 \pm 5.76$ | 5.23 | 721 | 133.0 | 196.1 |
| **20** | 80 | 120 | 20 / 20 | $14.22 \pm 4.55$ | $50.01 \pm 12.74$ | $13.75 \pm 5.02$ | 10.39 | 721 | 153.4 | 209.4 |
| **50** | 200 | 300 | 50 / 50 | $13.45 \pm 1.46$ | $49.85 \pm 9.05$ | $10.14 \pm 1.26$ | 25.86 | 723 | 212.6 | 301.5 |
| **100** | 400 | 600 | 100 / 100 | $25.86 \pm 10.15$ | $62.57 \pm 16.37$ | $10.49 \pm 1.44$ | 51.64 | 719 | 270.8 | 470.2 |

*Note on units: $1\text{ KiB} = 1024\text{ bytes}$. Proof size is measured from compact serialized JSON.*

---

## 3. Evidence for Compiler-Reported Constraint Counts

Constraint counts are determined strictly by compiler output from `snarkjs r1cs info` and `snarkjs r1cs print`:

```text
ScaleBench_1:   # of Constraints: 4,   # of Wires: 6,   # Private: 1,   # Public: 1
ScaleBench_5:   # of Constraints: 20,  # of Wires: 30,  # Private: 5,   # Public: 5
ScaleBench_10:  # of Constraints: 40,  # of Wires: 60,  # Private: 10,  # Public: 10
ScaleBench_20:  # of Constraints: 80,  # of Wires: 120, # Private: 20,  # Public: 20
ScaleBench_50:  # of Constraints: 200, # of Wires: 300, # Private: 50,  # Public: 50
ScaleBench_100: # of Constraints: 400, # of Wires: 600, # Private: 100, # Public: 100
```

### Algebraic Origin of the $4N$ Constraints
Each attribute $i \in \{0, \dots, N-1\}$ contributes 4 R1CS equations:
1. **Affine wiring constraint:** $pub_i - priv_i - isz.in = 0$ (from Circom's `==>` connection to the $IsZero$ subcomponent).
2. **Inversion constraint:** $isz.in \times isz.inv - (1 - isz.out) = 0$ (from circomlib `IsZero`).
3. **Orthogonality constraint:** $isz.in \times isz.out = 0$ (from circomlib `IsZero`).
4. **AND-Chain multiplication:** For $N > 1$, intermediate multiplications $intermediate[k-1] \times eq_k.out - intermediate[k] = 0$ ($N-1$ constraints) plus the terminal assertion $allMatch === 1$ (1 constraint) equal exactly $N$ constraints. For $N=1$, the single assertion $allMatch === 1$ provides 1 constraint.

Total constraints: $N + N + N + N = 4N$.

---

## 4. Repetition Audit & Timing Analysis

### Warm-up Impact
In the initial un-warmed benchmark, Repetition 1 of $N=1$ took **108.77 ms** due to cold V8 WASM module instantiation. With the 2 warm-up iterations active:
- Warm-up 1 and Warm-up 2 absorbed all JIT compilation and module-loading latency.
- Repetition 1 of $N=1$ registered at **17.44 ms**, with the 10 repetitions stabilizing at $18.90 \pm 3.69\text{ ms}$.
- Warm-up iterations were logged and confirmed valid, but excluded from all summary calculations.

### Timing Spikes & Inclusions
No data points were discarded from the 10 measured repetitions:
- **$N=1$, Repetition 1 Verify:** Registered at **91.59 ms** (subsequent reps averaged $\sim 22.3\text{ ms}$). This single spike causes the $N=1$ verification standard deviation to read $\pm 22.16\text{ ms}$.
- **$N=10$, Repetition 10 Witness:** Registered at **42.83 ms** (other reps: 14.3–21.5 ms), causing witness standard deviation to read $\pm 8.46\text{ ms}$.
- **$N=100$, Repetition 5 Prove:** Spiked to **102.76 ms** (other reps: 45.2–73.9 ms), leading to prove standard deviation of $\pm 16.37\text{ ms}$.

All spikes remain included in the reported sample standard deviations to preserve scientific transparency regarding garbage-collection and OS thread-scheduling variance.

---

## 5. Comparison with Manuscript Table 4

| Metric | Manuscript Table 4 Value | New Verified Value | Discrepancy & Root Cause |
|---|---|---|---|
| **Constraints** | $3, 15, 30, 60, 150, 300$ ($3N$) | $4, 20, 40, 80, 200, 400$ ($4N$) | **+33.3% Discrepancy.** The manuscript assumed a theoretical $3N$ estimate without compiling the actual circomlib equality gadget. |
| **R1CS File Size** | $0.52, 2.10, 4.10, 8.00, 20.0, 40.0$ KB | $0.59, 2.65, 5.23, 10.39, 25.86, 51.64$ KiB | **+13% to +29% Discrepancy.** R1CS binary serialization overhead scales with 4 constraints and 6 wires per attribute. |
| **Proof Time** | $369 - 495$ ms | $49.85 - 109.43$ ms | **$4\times$ to $7\times$ faster.** Manuscript numbers likely reflected external CLI invocation overhead rather than API execution. |
| **Verification Time** | $315 - 455$ ms | $10.14 - 29.28$ ms | **$15\times$ to $30\times$ faster.** Groth16 pairing verification in SnarkJS is highly optimized and takes $< 30$ ms. |
| **Witness Time** | $36 - 59$ ms | $13.45 - 25.86$ ms | **$1.5\times$ to $3\times$ faster.** In-memory WASM execution avoids file system serialization. |

---

## 6. Recommendations for Paper Text & Revisions

1. **Replace Table 4 Completely:** Replace all columns of Table 4 with the verified table in Section 2.
2. **Clarify Synthetic Scope in Section 4.1 / 4.5:**
   - Explicitly define the benchmark as an *isolated circuit-level microbenchmark evaluating zk-SNARK constraint scaling using boolean equality gadgets*.
   - Clearly state that Table 4 does **not** evaluate OCR attribute extraction (which typically requires hundreds of milliseconds to seconds) or Poseidon document commitments.
3. **Qualify "Constant-Time Verification" Claims in Section 4.7:**
   - Revise claims of "mathematically constant-time verification" to: *"Over the evaluated range ($1 \le N \le 100$), Groth16 proof verification remains nearly constant ($\approx 10 - 29\text{ ms}$) within experimental variance, because the primary cryptographic cost is dominated by three fixed-size elliptic-curve pairings."*
4. **Report Measurement Methodology in Section 4.5:**
   - State that measurements report $\text{mean} \pm \text{sample standard deviation}$ across 10 repetitions, conducted after 2 untimed warm-up passes to eliminate JIT compilation artifacts.

---

## 7. Exact Commands to Reproduce Results from Scratch

```powershell
# 1. Open terminal at benchmark root
cd "c:\Users\gadda\Downloads\Summer Reserach Internship\ZKP-DOCVerify\backend\scalability-benchmark"

# 2. Generate parameterized circuits and input vectors
node generate-circuits.js

# 3. Execute compilation, trusted setup, warm-ups, and 10 measured repetitions
node run-benchmark.js

# 4. Confirm compiler constraint counts
npx snarkjs r1cs info "build\ScaleBench_1\ScaleBench_1.r1cs"
npx snarkjs r1cs info "build\ScaleBench_100\ScaleBench_100.r1cs"
```
