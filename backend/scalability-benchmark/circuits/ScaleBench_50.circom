pragma circom 2.1.6;

include "../node_modules/circomlib/circuits/comparators.circom";

// Synthetic scalability benchmark circuit with 50 attribute(s).
// Each attribute: private input matched against public input via IsEqual.
// This is NOT the full document-verification protocol.

template ScaleBench_50() {

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
    signal input priv_20;
    signal input priv_21;
    signal input priv_22;
    signal input priv_23;
    signal input priv_24;
    signal input priv_25;
    signal input priv_26;
    signal input priv_27;
    signal input priv_28;
    signal input priv_29;
    signal input priv_30;
    signal input priv_31;
    signal input priv_32;
    signal input priv_33;
    signal input priv_34;
    signal input priv_35;
    signal input priv_36;
    signal input priv_37;
    signal input priv_38;
    signal input priv_39;
    signal input priv_40;
    signal input priv_41;
    signal input priv_42;
    signal input priv_43;
    signal input priv_44;
    signal input priv_45;
    signal input priv_46;
    signal input priv_47;
    signal input priv_48;
    signal input priv_49;

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
    signal input pub_20;
    signal input pub_21;
    signal input pub_22;
    signal input pub_23;
    signal input pub_24;
    signal input pub_25;
    signal input pub_26;
    signal input pub_27;
    signal input pub_28;
    signal input pub_29;
    signal input pub_30;
    signal input pub_31;
    signal input pub_32;
    signal input pub_33;
    signal input pub_34;
    signal input pub_35;
    signal input pub_36;
    signal input pub_37;
    signal input pub_38;
    signal input pub_39;
    signal input pub_40;
    signal input pub_41;
    signal input pub_42;
    signal input pub_43;
    signal input pub_44;
    signal input pub_45;
    signal input pub_46;
    signal input pub_47;
    signal input pub_48;
    signal input pub_49;

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

    component eq_20 = IsEqual();
    eq_20.in[0] <== priv_20;
    eq_20.in[1] <== pub_20;

    component eq_21 = IsEqual();
    eq_21.in[0] <== priv_21;
    eq_21.in[1] <== pub_21;

    component eq_22 = IsEqual();
    eq_22.in[0] <== priv_22;
    eq_22.in[1] <== pub_22;

    component eq_23 = IsEqual();
    eq_23.in[0] <== priv_23;
    eq_23.in[1] <== pub_23;

    component eq_24 = IsEqual();
    eq_24.in[0] <== priv_24;
    eq_24.in[1] <== pub_24;

    component eq_25 = IsEqual();
    eq_25.in[0] <== priv_25;
    eq_25.in[1] <== pub_25;

    component eq_26 = IsEqual();
    eq_26.in[0] <== priv_26;
    eq_26.in[1] <== pub_26;

    component eq_27 = IsEqual();
    eq_27.in[0] <== priv_27;
    eq_27.in[1] <== pub_27;

    component eq_28 = IsEqual();
    eq_28.in[0] <== priv_28;
    eq_28.in[1] <== pub_28;

    component eq_29 = IsEqual();
    eq_29.in[0] <== priv_29;
    eq_29.in[1] <== pub_29;

    component eq_30 = IsEqual();
    eq_30.in[0] <== priv_30;
    eq_30.in[1] <== pub_30;

    component eq_31 = IsEqual();
    eq_31.in[0] <== priv_31;
    eq_31.in[1] <== pub_31;

    component eq_32 = IsEqual();
    eq_32.in[0] <== priv_32;
    eq_32.in[1] <== pub_32;

    component eq_33 = IsEqual();
    eq_33.in[0] <== priv_33;
    eq_33.in[1] <== pub_33;

    component eq_34 = IsEqual();
    eq_34.in[0] <== priv_34;
    eq_34.in[1] <== pub_34;

    component eq_35 = IsEqual();
    eq_35.in[0] <== priv_35;
    eq_35.in[1] <== pub_35;

    component eq_36 = IsEqual();
    eq_36.in[0] <== priv_36;
    eq_36.in[1] <== pub_36;

    component eq_37 = IsEqual();
    eq_37.in[0] <== priv_37;
    eq_37.in[1] <== pub_37;

    component eq_38 = IsEqual();
    eq_38.in[0] <== priv_38;
    eq_38.in[1] <== pub_38;

    component eq_39 = IsEqual();
    eq_39.in[0] <== priv_39;
    eq_39.in[1] <== pub_39;

    component eq_40 = IsEqual();
    eq_40.in[0] <== priv_40;
    eq_40.in[1] <== pub_40;

    component eq_41 = IsEqual();
    eq_41.in[0] <== priv_41;
    eq_41.in[1] <== pub_41;

    component eq_42 = IsEqual();
    eq_42.in[0] <== priv_42;
    eq_42.in[1] <== pub_42;

    component eq_43 = IsEqual();
    eq_43.in[0] <== priv_43;
    eq_43.in[1] <== pub_43;

    component eq_44 = IsEqual();
    eq_44.in[0] <== priv_44;
    eq_44.in[1] <== pub_44;

    component eq_45 = IsEqual();
    eq_45.in[0] <== priv_45;
    eq_45.in[1] <== pub_45;

    component eq_46 = IsEqual();
    eq_46.in[0] <== priv_46;
    eq_46.in[1] <== pub_46;

    component eq_47 = IsEqual();
    eq_47.in[0] <== priv_47;
    eq_47.in[1] <== pub_47;

    component eq_48 = IsEqual();
    eq_48.in[0] <== priv_48;
    eq_48.in[1] <== pub_48;

    component eq_49 = IsEqual();
    eq_49.in[0] <== priv_49;
    eq_49.in[1] <== pub_49;

    // Chain AND: all equality results must be 1
    signal intermediate[49];
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
    intermediate[19] <== intermediate[18] * eq_20.out;
    intermediate[20] <== intermediate[19] * eq_21.out;
    intermediate[21] <== intermediate[20] * eq_22.out;
    intermediate[22] <== intermediate[21] * eq_23.out;
    intermediate[23] <== intermediate[22] * eq_24.out;
    intermediate[24] <== intermediate[23] * eq_25.out;
    intermediate[25] <== intermediate[24] * eq_26.out;
    intermediate[26] <== intermediate[25] * eq_27.out;
    intermediate[27] <== intermediate[26] * eq_28.out;
    intermediate[28] <== intermediate[27] * eq_29.out;
    intermediate[29] <== intermediate[28] * eq_30.out;
    intermediate[30] <== intermediate[29] * eq_31.out;
    intermediate[31] <== intermediate[30] * eq_32.out;
    intermediate[32] <== intermediate[31] * eq_33.out;
    intermediate[33] <== intermediate[32] * eq_34.out;
    intermediate[34] <== intermediate[33] * eq_35.out;
    intermediate[35] <== intermediate[34] * eq_36.out;
    intermediate[36] <== intermediate[35] * eq_37.out;
    intermediate[37] <== intermediate[36] * eq_38.out;
    intermediate[38] <== intermediate[37] * eq_39.out;
    intermediate[39] <== intermediate[38] * eq_40.out;
    intermediate[40] <== intermediate[39] * eq_41.out;
    intermediate[41] <== intermediate[40] * eq_42.out;
    intermediate[42] <== intermediate[41] * eq_43.out;
    intermediate[43] <== intermediate[42] * eq_44.out;
    intermediate[44] <== intermediate[43] * eq_45.out;
    intermediate[45] <== intermediate[44] * eq_46.out;
    intermediate[46] <== intermediate[45] * eq_47.out;
    intermediate[47] <== intermediate[46] * eq_48.out;
    intermediate[48] <== intermediate[47] * eq_49.out;
    allMatch <== intermediate[48];
    allMatch === 1;
}

component main {public [pub_0, pub_1, pub_2, pub_3, pub_4, pub_5, pub_6, pub_7, pub_8, pub_9, pub_10, pub_11, pub_12, pub_13, pub_14, pub_15, pub_16, pub_17, pub_18, pub_19, pub_20, pub_21, pub_22, pub_23, pub_24, pub_25, pub_26, pub_27, pub_28, pub_29, pub_30, pub_31, pub_32, pub_33, pub_34, pub_35, pub_36, pub_37, pub_38, pub_39, pub_40, pub_41, pub_42, pub_43, pub_44, pub_45, pub_46, pub_47, pub_48, pub_49]} = ScaleBench_50();
