pragma circom 2.1.6;

include "../node_modules/circomlib/circuits/comparators.circom";

// Synthetic scalability benchmark circuit with 100 attribute(s).
// Each attribute: private input matched against public input via IsEqual.
// This is NOT the full document-verification protocol.

template ScaleBench_100() {

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
    signal input priv_50;
    signal input priv_51;
    signal input priv_52;
    signal input priv_53;
    signal input priv_54;
    signal input priv_55;
    signal input priv_56;
    signal input priv_57;
    signal input priv_58;
    signal input priv_59;
    signal input priv_60;
    signal input priv_61;
    signal input priv_62;
    signal input priv_63;
    signal input priv_64;
    signal input priv_65;
    signal input priv_66;
    signal input priv_67;
    signal input priv_68;
    signal input priv_69;
    signal input priv_70;
    signal input priv_71;
    signal input priv_72;
    signal input priv_73;
    signal input priv_74;
    signal input priv_75;
    signal input priv_76;
    signal input priv_77;
    signal input priv_78;
    signal input priv_79;
    signal input priv_80;
    signal input priv_81;
    signal input priv_82;
    signal input priv_83;
    signal input priv_84;
    signal input priv_85;
    signal input priv_86;
    signal input priv_87;
    signal input priv_88;
    signal input priv_89;
    signal input priv_90;
    signal input priv_91;
    signal input priv_92;
    signal input priv_93;
    signal input priv_94;
    signal input priv_95;
    signal input priv_96;
    signal input priv_97;
    signal input priv_98;
    signal input priv_99;

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
    signal input pub_50;
    signal input pub_51;
    signal input pub_52;
    signal input pub_53;
    signal input pub_54;
    signal input pub_55;
    signal input pub_56;
    signal input pub_57;
    signal input pub_58;
    signal input pub_59;
    signal input pub_60;
    signal input pub_61;
    signal input pub_62;
    signal input pub_63;
    signal input pub_64;
    signal input pub_65;
    signal input pub_66;
    signal input pub_67;
    signal input pub_68;
    signal input pub_69;
    signal input pub_70;
    signal input pub_71;
    signal input pub_72;
    signal input pub_73;
    signal input pub_74;
    signal input pub_75;
    signal input pub_76;
    signal input pub_77;
    signal input pub_78;
    signal input pub_79;
    signal input pub_80;
    signal input pub_81;
    signal input pub_82;
    signal input pub_83;
    signal input pub_84;
    signal input pub_85;
    signal input pub_86;
    signal input pub_87;
    signal input pub_88;
    signal input pub_89;
    signal input pub_90;
    signal input pub_91;
    signal input pub_92;
    signal input pub_93;
    signal input pub_94;
    signal input pub_95;
    signal input pub_96;
    signal input pub_97;
    signal input pub_98;
    signal input pub_99;

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

    component eq_50 = IsEqual();
    eq_50.in[0] <== priv_50;
    eq_50.in[1] <== pub_50;

    component eq_51 = IsEqual();
    eq_51.in[0] <== priv_51;
    eq_51.in[1] <== pub_51;

    component eq_52 = IsEqual();
    eq_52.in[0] <== priv_52;
    eq_52.in[1] <== pub_52;

    component eq_53 = IsEqual();
    eq_53.in[0] <== priv_53;
    eq_53.in[1] <== pub_53;

    component eq_54 = IsEqual();
    eq_54.in[0] <== priv_54;
    eq_54.in[1] <== pub_54;

    component eq_55 = IsEqual();
    eq_55.in[0] <== priv_55;
    eq_55.in[1] <== pub_55;

    component eq_56 = IsEqual();
    eq_56.in[0] <== priv_56;
    eq_56.in[1] <== pub_56;

    component eq_57 = IsEqual();
    eq_57.in[0] <== priv_57;
    eq_57.in[1] <== pub_57;

    component eq_58 = IsEqual();
    eq_58.in[0] <== priv_58;
    eq_58.in[1] <== pub_58;

    component eq_59 = IsEqual();
    eq_59.in[0] <== priv_59;
    eq_59.in[1] <== pub_59;

    component eq_60 = IsEqual();
    eq_60.in[0] <== priv_60;
    eq_60.in[1] <== pub_60;

    component eq_61 = IsEqual();
    eq_61.in[0] <== priv_61;
    eq_61.in[1] <== pub_61;

    component eq_62 = IsEqual();
    eq_62.in[0] <== priv_62;
    eq_62.in[1] <== pub_62;

    component eq_63 = IsEqual();
    eq_63.in[0] <== priv_63;
    eq_63.in[1] <== pub_63;

    component eq_64 = IsEqual();
    eq_64.in[0] <== priv_64;
    eq_64.in[1] <== pub_64;

    component eq_65 = IsEqual();
    eq_65.in[0] <== priv_65;
    eq_65.in[1] <== pub_65;

    component eq_66 = IsEqual();
    eq_66.in[0] <== priv_66;
    eq_66.in[1] <== pub_66;

    component eq_67 = IsEqual();
    eq_67.in[0] <== priv_67;
    eq_67.in[1] <== pub_67;

    component eq_68 = IsEqual();
    eq_68.in[0] <== priv_68;
    eq_68.in[1] <== pub_68;

    component eq_69 = IsEqual();
    eq_69.in[0] <== priv_69;
    eq_69.in[1] <== pub_69;

    component eq_70 = IsEqual();
    eq_70.in[0] <== priv_70;
    eq_70.in[1] <== pub_70;

    component eq_71 = IsEqual();
    eq_71.in[0] <== priv_71;
    eq_71.in[1] <== pub_71;

    component eq_72 = IsEqual();
    eq_72.in[0] <== priv_72;
    eq_72.in[1] <== pub_72;

    component eq_73 = IsEqual();
    eq_73.in[0] <== priv_73;
    eq_73.in[1] <== pub_73;

    component eq_74 = IsEqual();
    eq_74.in[0] <== priv_74;
    eq_74.in[1] <== pub_74;

    component eq_75 = IsEqual();
    eq_75.in[0] <== priv_75;
    eq_75.in[1] <== pub_75;

    component eq_76 = IsEqual();
    eq_76.in[0] <== priv_76;
    eq_76.in[1] <== pub_76;

    component eq_77 = IsEqual();
    eq_77.in[0] <== priv_77;
    eq_77.in[1] <== pub_77;

    component eq_78 = IsEqual();
    eq_78.in[0] <== priv_78;
    eq_78.in[1] <== pub_78;

    component eq_79 = IsEqual();
    eq_79.in[0] <== priv_79;
    eq_79.in[1] <== pub_79;

    component eq_80 = IsEqual();
    eq_80.in[0] <== priv_80;
    eq_80.in[1] <== pub_80;

    component eq_81 = IsEqual();
    eq_81.in[0] <== priv_81;
    eq_81.in[1] <== pub_81;

    component eq_82 = IsEqual();
    eq_82.in[0] <== priv_82;
    eq_82.in[1] <== pub_82;

    component eq_83 = IsEqual();
    eq_83.in[0] <== priv_83;
    eq_83.in[1] <== pub_83;

    component eq_84 = IsEqual();
    eq_84.in[0] <== priv_84;
    eq_84.in[1] <== pub_84;

    component eq_85 = IsEqual();
    eq_85.in[0] <== priv_85;
    eq_85.in[1] <== pub_85;

    component eq_86 = IsEqual();
    eq_86.in[0] <== priv_86;
    eq_86.in[1] <== pub_86;

    component eq_87 = IsEqual();
    eq_87.in[0] <== priv_87;
    eq_87.in[1] <== pub_87;

    component eq_88 = IsEqual();
    eq_88.in[0] <== priv_88;
    eq_88.in[1] <== pub_88;

    component eq_89 = IsEqual();
    eq_89.in[0] <== priv_89;
    eq_89.in[1] <== pub_89;

    component eq_90 = IsEqual();
    eq_90.in[0] <== priv_90;
    eq_90.in[1] <== pub_90;

    component eq_91 = IsEqual();
    eq_91.in[0] <== priv_91;
    eq_91.in[1] <== pub_91;

    component eq_92 = IsEqual();
    eq_92.in[0] <== priv_92;
    eq_92.in[1] <== pub_92;

    component eq_93 = IsEqual();
    eq_93.in[0] <== priv_93;
    eq_93.in[1] <== pub_93;

    component eq_94 = IsEqual();
    eq_94.in[0] <== priv_94;
    eq_94.in[1] <== pub_94;

    component eq_95 = IsEqual();
    eq_95.in[0] <== priv_95;
    eq_95.in[1] <== pub_95;

    component eq_96 = IsEqual();
    eq_96.in[0] <== priv_96;
    eq_96.in[1] <== pub_96;

    component eq_97 = IsEqual();
    eq_97.in[0] <== priv_97;
    eq_97.in[1] <== pub_97;

    component eq_98 = IsEqual();
    eq_98.in[0] <== priv_98;
    eq_98.in[1] <== pub_98;

    component eq_99 = IsEqual();
    eq_99.in[0] <== priv_99;
    eq_99.in[1] <== pub_99;

    // Chain AND: all equality results must be 1
    signal intermediate[99];
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
    intermediate[49] <== intermediate[48] * eq_50.out;
    intermediate[50] <== intermediate[49] * eq_51.out;
    intermediate[51] <== intermediate[50] * eq_52.out;
    intermediate[52] <== intermediate[51] * eq_53.out;
    intermediate[53] <== intermediate[52] * eq_54.out;
    intermediate[54] <== intermediate[53] * eq_55.out;
    intermediate[55] <== intermediate[54] * eq_56.out;
    intermediate[56] <== intermediate[55] * eq_57.out;
    intermediate[57] <== intermediate[56] * eq_58.out;
    intermediate[58] <== intermediate[57] * eq_59.out;
    intermediate[59] <== intermediate[58] * eq_60.out;
    intermediate[60] <== intermediate[59] * eq_61.out;
    intermediate[61] <== intermediate[60] * eq_62.out;
    intermediate[62] <== intermediate[61] * eq_63.out;
    intermediate[63] <== intermediate[62] * eq_64.out;
    intermediate[64] <== intermediate[63] * eq_65.out;
    intermediate[65] <== intermediate[64] * eq_66.out;
    intermediate[66] <== intermediate[65] * eq_67.out;
    intermediate[67] <== intermediate[66] * eq_68.out;
    intermediate[68] <== intermediate[67] * eq_69.out;
    intermediate[69] <== intermediate[68] * eq_70.out;
    intermediate[70] <== intermediate[69] * eq_71.out;
    intermediate[71] <== intermediate[70] * eq_72.out;
    intermediate[72] <== intermediate[71] * eq_73.out;
    intermediate[73] <== intermediate[72] * eq_74.out;
    intermediate[74] <== intermediate[73] * eq_75.out;
    intermediate[75] <== intermediate[74] * eq_76.out;
    intermediate[76] <== intermediate[75] * eq_77.out;
    intermediate[77] <== intermediate[76] * eq_78.out;
    intermediate[78] <== intermediate[77] * eq_79.out;
    intermediate[79] <== intermediate[78] * eq_80.out;
    intermediate[80] <== intermediate[79] * eq_81.out;
    intermediate[81] <== intermediate[80] * eq_82.out;
    intermediate[82] <== intermediate[81] * eq_83.out;
    intermediate[83] <== intermediate[82] * eq_84.out;
    intermediate[84] <== intermediate[83] * eq_85.out;
    intermediate[85] <== intermediate[84] * eq_86.out;
    intermediate[86] <== intermediate[85] * eq_87.out;
    intermediate[87] <== intermediate[86] * eq_88.out;
    intermediate[88] <== intermediate[87] * eq_89.out;
    intermediate[89] <== intermediate[88] * eq_90.out;
    intermediate[90] <== intermediate[89] * eq_91.out;
    intermediate[91] <== intermediate[90] * eq_92.out;
    intermediate[92] <== intermediate[91] * eq_93.out;
    intermediate[93] <== intermediate[92] * eq_94.out;
    intermediate[94] <== intermediate[93] * eq_95.out;
    intermediate[95] <== intermediate[94] * eq_96.out;
    intermediate[96] <== intermediate[95] * eq_97.out;
    intermediate[97] <== intermediate[96] * eq_98.out;
    intermediate[98] <== intermediate[97] * eq_99.out;
    allMatch <== intermediate[98];
    allMatch === 1;
}

component main {public [pub_0, pub_1, pub_2, pub_3, pub_4, pub_5, pub_6, pub_7, pub_8, pub_9, pub_10, pub_11, pub_12, pub_13, pub_14, pub_15, pub_16, pub_17, pub_18, pub_19, pub_20, pub_21, pub_22, pub_23, pub_24, pub_25, pub_26, pub_27, pub_28, pub_29, pub_30, pub_31, pub_32, pub_33, pub_34, pub_35, pub_36, pub_37, pub_38, pub_39, pub_40, pub_41, pub_42, pub_43, pub_44, pub_45, pub_46, pub_47, pub_48, pub_49, pub_50, pub_51, pub_52, pub_53, pub_54, pub_55, pub_56, pub_57, pub_58, pub_59, pub_60, pub_61, pub_62, pub_63, pub_64, pub_65, pub_66, pub_67, pub_68, pub_69, pub_70, pub_71, pub_72, pub_73, pub_74, pub_75, pub_76, pub_77, pub_78, pub_79, pub_80, pub_81, pub_82, pub_83, pub_84, pub_85, pub_86, pub_87, pub_88, pub_89, pub_90, pub_91, pub_92, pub_93, pub_94, pub_95, pub_96, pub_97, pub_98, pub_99]} = ScaleBench_100();
