clc; clear;

popcorn =[
    5.5000    4.5000    3.5000
    5.5000    4.5000    4.0000
    6.0000    4.0000    3.0000
    6.5000    5.0000    4.0000
    7.0000    5.5000    5.0000
    7.0000    5.0000    4.5000];

[pValue, fEst, cValue, meanRanks] = funcApplyFriedmanTest(popcorn, 0.95);
[mtest] = funcApplyNemenyiTest(size(popcorn,2), size(popcorn,1), meanRanks, 0.95);