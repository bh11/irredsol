gap> START_TEST("recog2");
gap> IRREDSOL_Read("tst/randomirred.g");
gap> inds := [ 6081, 6082, 6083, 6084, 6085, 6086, 6087, 6088 ];;
gap> for i in inds do
>    TestRandomIrreducibleSolvableMatrixGroup (8, 3, 1, i, 3);
> od;
gap> STOP_TEST("recog2", 98490000);
