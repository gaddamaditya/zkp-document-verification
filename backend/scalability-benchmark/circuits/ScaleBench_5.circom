pragma circom 2.1.6;

include "../node_modules/circomlib/circuits/comparators.circom";

// Synthetic scalability benchmark circuit with 5 attribute(s).
// Each attribute: private input matched against public input via IsEqual.
// This is NOT the full document-verification protocol.

template ScaleBench_5() {

    // Private inputs (one per attribute)
    signal input priv_0;
    signal input priv_1;
    signal input priv_2;
    signal input priv_3;
    signal input priv_4;

    // Public inputs (one per attribute)
    signal input pub_0;
    signal input pub_1;
    signal input pub_2;
    signal input pub_3;
    signal input pub_4;

    // Output: 1 if all attributes match, 0 otherwise
    signal output allMatch;

    // IsEqual components
    component eq_0 = IsEqual();
    eq_0.in[0] <== priv_0;
    eq_0.in[1] <== pub_0;

    component eq_1 = IsEqual();
    eq_1.in[0] <== priv_1;
    eq_1.in[1] <== pub_1;

    component eq_2 = IsEqual();
    eq_2.in[0] <== priv_2;
    eq_2.in[1] <== pub_2;

    component eq_3 = IsEqual();
    eq_3.in[0] <== priv_3;
    eq_3.in[1] <== pub_3;

    component eq_4 = IsEqual();
    eq_4.in[0] <== priv_4;
    eq_4.in[1] <== pub_4;

    // Chain AND: all equality results must be 1
    signal intermediate[4];
    intermediate[0] <== eq_0.out * eq_1.out;
    intermediate[1] <== intermediate[0] * eq_2.out;
    intermediate[2] <== intermediate[1] * eq_3.out;
    intermediate[3] <== intermediate[2] * eq_4.out;
    allMatch <== intermediate[3];
    allMatch === 1;
}

component main {public [pub_0, pub_1, pub_2, pub_3, pub_4]} = ScaleBench_5();
