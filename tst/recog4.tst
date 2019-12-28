gap> START_TEST("recog4");
gap> IRREDSOL_Read("tst/randomirred.g");
gap> inds := [ 1..6 ];;
gap> for i in inds do
>    TestRandomIrreducibleSolvableMatrixGroup (4, 3, 4, i, 3);
> od;
gap> STOP_TEST("recog4", 5980000);
