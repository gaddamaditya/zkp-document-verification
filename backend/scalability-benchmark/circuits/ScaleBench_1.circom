pragma circom 2.1.6;

include "../node_modules/circomlib/circuits/comparators.circom";

// Synthetic scalability benchmark circuit with 1 attribute(s).
// Each attribute: private input matched against public input via IsEqual.
// This is NOT the full document-verification protocol.

template ScaleBench_1() {

    // Private inputs (one per attribute)
    signal input priv_0;

    // Public inputs (one per attribute)
    signal input pub_0;

    // Output: 1 if all attributes match, 0 otherwise
    signal output allMatch;

    // IsEqual components
    component eq_0 = IsEqual();
    eq_0.in[0] <== priv_0;
    eq_0.in[1] <== pub_0;

    allMatch <== eq_0.out;
    allMatch === 1;
}

component main {public [pub_0]} = ScaleBench_1();
