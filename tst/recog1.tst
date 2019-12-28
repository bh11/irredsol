gap> START_TEST("recog1");
gap> IRREDSOL_Read("tst/randomirred.g");
gap> inds := [ 1168, 1224, 1229, 1231, 1237, 1242, 1247, 1249, 1513, 1515, 1517, 1519,  1533 ];;
gap> for i in inds do
>    TestRandomIrreducibleSolvableMatrixGroup (8, 3, 2, i, 3);
> od;
gap> STOP_TEST("recog1", 363680000);
