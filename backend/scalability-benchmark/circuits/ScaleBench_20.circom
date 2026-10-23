pragma circom 2.1.6;

include "../node_modules/circomlib/circuits/comparators.circom";

// Synthetic scalability benchmark circuit with 20 attribute(s).
// Each attribute: private input matched against public input via IsEqual.
// This is NOT the full document-verification protocol.

template ScaleBench_20() {

    // Private inputs (one per attribute)
    signal input priv_0;
    signal input priv_1;
    signal input priv_2;
    signal input priv_3;
    signal input priv_4;
    signal input priv_5;
    signal input priv_6;
    signal input priv_7;
    signal input priv_8;
    signal input priv_9;
    signal input priv_10;
    signal input priv_11;
    signal input priv_12;
    signal input priv_13;
    signal input priv_14;
    signal input priv_15;
    signal input priv_16;
    signal input priv_17;
    signal input priv_18;
    signal input priv_19;

    // Public inputs (one per attribute)
    signal input pub_0;
    signal input pub_1;
    signal input pub_2;
    signal input pub_3;
    signal input pub_4;
    signal input pub_5;
    signal input pub_6;
    signal input pub_7;
    signal input pub_8;
    signal input pub_9;
    signal input pub_10;
    signal input pub_11;
    signal input pub_12;
    signal input pub_13;
    signal input pub_14;
    signal input pub_15;
    signal input pub_16;
    signal input pub_17;
    signal input pub_18;
    signal input pub_19;

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

    component eq_5 = IsEqual();
    eq_5.in[0] <== priv_5;
    eq_5.in[1] <== pub_5;

    component eq_6 = IsEqual();
    eq_6.in[0] <== priv_6;
    eq_6.in[1] <== pub_6;

    component eq_7 = IsEqual();
    eq_7.in[0] <== priv_7;
    eq_7.in[1] <== pub_7;

    component eq_8 = IsEqual();
    eq_8.in[0] <== priv_8;
    eq_8.in[1] <== pub_8;

    component eq_9 = IsEqual();
    eq_9.in[0] <== priv_9;
    eq_9.in[1] <== pub_9;

    component eq_10 = IsEqual();
    eq_10.in[0] <== priv_10;
    eq_10.in[1] <== pub_10;

    component eq_11 = IsEqual();
    eq_11.in[0] <== priv_11;
    eq_11.in[1] <== pub_11;

    component eq_12 = IsEqual();
    eq_12.in[0] <== priv_12;
    eq_12.in[1] <== pub_12;

    component eq_13 = IsEqual();
    eq_13.in[0] <== priv_13;
    eq_13.in[1] <== pub_13;

    component eq_14 = IsEqual();
    eq_14.in[0] <== priv_14;
    eq_14.in[1] <== pub_14;

    component eq_15 = IsEqual();
    eq_15.in[0] <== priv_15;
    eq_15.in[1] <== pub_15;

    component eq_16 = IsEqual();
    eq_16.in[0] <== priv_16;
    eq_16.in[1] <== pub_16;

    component eq_17 = IsEqual();
    eq_17.in[0] <== priv_17;
    eq_17.in[1] <== pub_17;

    component eq_18 = IsEqual();
    eq_18.in[0] <== priv_18;
    eq_18.in[1] <== pub_18;

    component eq_19 = IsEqual();
    eq_19.in[0] <== priv_19;
    eq_19.in[1] <== pub_19;

    // Chain AND: all equality results must be 1
    signal intermediate[19];
    intermediate[0] <== eq_0.out * eq_1.out;
    intermediate[1] <== intermediate[0] * eq_2.out;
    intermediate[2] <== intermediate[1] * eq_3.out;
    intermediate[3] <== intermediate[2] * eq_4.out;
    intermediate[4] <== intermediate[3] * eq_5.out;
    intermediate[5] <== intermediate[4] * eq_6.out;
    intermediate[6] <== intermediate[5] * eq_7.out;
    intermediate[7] <== intermediate[6] * eq_8.out;
    intermediate[8] <== intermediate[7] * eq_9.out;
    intermediate[9] <== intermediate[8] * eq_10.out;
    intermediate[10] <== intermediate[9] * eq_11.out;
    intermediate[11] <== intermediate[10] * eq_12.out;
    intermediate[12] <== intermediate[11] * eq_13.out;
    intermediate[13] <== intermediate[12] * eq_14.out;
    intermediate[14] <== intermediate[13] * eq_15.out;
    intermediate[15] <== intermediate[14] * eq_16.out;
    intermediate[16] <== intermediate[15] * eq_17.out;
    intermediate[17] <== intermediate[16] * eq_18.out;
    intermediate[18] <== intermediate[17] * eq_19.out;
    allMatch <== intermediate[18];
    allMatch === 1;
}

component main {public [pub_0, pub_1, pub_2, pub_3, pub_4, pub_5, pub_6, pub_7, pub_8, pub_9, pub_10, pub_11, pub_12, pub_13, pub_14, pub_15, pub_16, pub_17, pub_18, pub_19]} = ScaleBench_20();
