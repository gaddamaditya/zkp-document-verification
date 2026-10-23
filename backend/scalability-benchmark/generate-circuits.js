/**
 * generate-circuits.js
 * 
 * Generates parameterized Circom 2 circuits for the scalability benchmark.
 * 
 * Design rationale:
 *   Each "attribute" consists of a private input and a public input.
 *   We use circomlib's IsEqual() component to verify that each private input
 *   matches the corresponding public input. IsEqual generates real R1CS
 *   constraints (via IsZero internally), unlike direct `a === b` assertions
 *   which are zero-cost wire identities in Circom 2.
 * 
 *   Additionally, all IsEqual outputs are ANDed together to produce a single
 *   public output signal (allMatch), ensuring all attributes must match.
 * 
 *   This is a synthetic benchmark isolating circuit-size effects.
 *   It does NOT use Poseidon commitments or represent the full document
 *   verification protocol.
 * 
 * Circuit sizes: 1, 5, 10, 20, 50, 100 attributes
 */

const fs = require('fs');
const path = require('path');

const SIZES = [1, 5, 10, 20, 50, 100];
const CIRCUITS_DIR = path.join(__dirname, 'circuits');

function generateCircuit(numAttributes) {
  const name = `ScaleBench_${numAttributes}`;

  let circom = `pragma circom 2.1.6;

include "../node_modules/circomlib/circuits/comparators.circom";

// Synthetic scalability benchmark circuit with ${numAttributes} attribute(s).
// Each attribute: private input matched against public input via IsEqual.
// This is NOT the full document-verification protocol.

template ${name}() {

    // Private inputs (one per attribute)
`;

  for (let i = 0; i < numAttributes; i++) {
    circom += `    signal input priv_${i};\n`;
  }

  circom += `\n    // Public inputs (one per attribute)\n`;
  for (let i = 0; i < numAttributes; i++) {
    circom += `    signal input pub_${i};\n`;
  }

  circom += `\n    // Output: 1 if all attributes match, 0 otherwise\n`;
  circom += `    signal output allMatch;\n\n`;

  circom += `    // IsEqual components\n`;
  for (let i = 0; i < numAttributes; i++) {
    circom += `    component eq_${i} = IsEqual();\n`;
    circom += `    eq_${i}.in[0] <== priv_${i};\n`;
    circom += `    eq_${i}.in[1] <== pub_${i};\n\n`;
  }

  // AND all equality outputs together using intermediate signals
  if (numAttributes === 1) {
    circom += `    allMatch <== eq_0.out;\n`;
    circom += `    allMatch === 1;\n`;
  } else {
    circom += `    // Chain AND: all equality results must be 1\n`;
    circom += `    signal intermediate[${numAttributes - 1}];\n`;
    circom += `    intermediate[0] <== eq_0.out * eq_1.out;\n`;
    for (let i = 2; i < numAttributes; i++) {
      circom += `    intermediate[${i - 1}] <== intermediate[${i - 2}] * eq_${i}.out;\n`;
    }
    circom += `    allMatch <== intermediate[${numAttributes - 2}];\n`;
    circom += `    allMatch === 1;\n`;
  }

  circom += `}\n\n`;

  // Build the public input list
  const publicInputs = [];
  for (let i = 0; i < numAttributes; i++) {
    publicInputs.push(`pub_${i}`);
  }

  circom += `component main {public [${publicInputs.join(', ')}]} = ${name}();\n`;

  return { name, circom };
}

function generateInput(numAttributes, valid = true) {
  const input = {};
  for (let i = 0; i < numAttributes; i++) {
    const value = i + 1; // Simple non-zero values
    input[`priv_${i}`] = value;
    input[`pub_${i}`] = valid ? value : (i === 0 ? value + 1 : value);
    // For invalid: mismatch only the first attribute
  }
  return input;
}

// Main
if (!fs.existsSync(CIRCUITS_DIR)) {
  fs.mkdirSync(CIRCUITS_DIR, { recursive: true });
}

console.log('=== Generating Scalability Benchmark Circuits ===\n');

for (const size of SIZES) {
  const { name, circom } = generateCircuit(size);
  const circuitPath = path.join(CIRCUITS_DIR, `${name}.circom`);
  fs.writeFileSync(circuitPath, circom);

  // Write valid input
  const validInput = generateInput(size, true);
  const inputDir = path.join(__dirname, 'inputs');
  if (!fs.existsSync(inputDir)) {
    fs.mkdirSync(inputDir, { recursive: true });
  }
  fs.writeFileSync(
    path.join(inputDir, `input_${size}_valid.json`),
    JSON.stringify(validInput, null, 2)
  );

  // Write invalid input
  const invalidInput = generateInput(size, false);
  fs.writeFileSync(
    path.join(inputDir, `input_${size}_invalid.json`),
    JSON.stringify(invalidInput, null, 2)
  );

  console.log(`  ✓ ${name}.circom  (${size} attributes)`);
  console.log(`    Valid input:   inputs/input_${size}_valid.json`);
  console.log(`    Invalid input: inputs/input_${size}_invalid.json`);
}

console.log(`\n✓ Generated ${SIZES.length} circuits in ${CIRCUITS_DIR}`);
console.log(`✓ Generated ${SIZES.length * 2} input files in inputs/`);
