gap> START_TEST("recog3");
gap> IRREDSOL_Read("tst/randomirred.g");
gap> inds := [ 1513, 1514, 1515 ];;
gap> for i in inds do
>    TestRandomIrreducibleSolvableMatrixGroup (6, 5, 1, i, 4);
> od;
gap> STOP_TEST("recog3", 60980000);
