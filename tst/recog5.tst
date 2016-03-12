gap> START_TEST("recog5");
gap> IRREDSOL_Read("tst/randomirred.g");
gap> G1:=Group([ [ [ Z(7), 0*Z(7) ], [ 0*Z(7), Z(7) ] ], [ [ Z(7)^0, Z(7)^0 ], [ Z(7)^5, Z(7)^3 ] ], 
> [ [ Z(7)^4, 0*Z(7) ], [ Z(7)^4, Z(7)^2 ] ]]);;
gap> IdIrreducibleSolvableMatrixGroup(G1);
[ 2, 7, 1, 20 ]
gap> G2:=Group([ [ [ Z(7), Z(7)^5 ], [ Z(7), Z(7)^0 ] ],[ [ Z(7), Z(7)^3 ], [Z(7), Z(7)^4 ] ] ]);;
gap> IdIrreducibleSolvableMatrixGroup(G2);
[ 2, 7, 1, 21 ]
gap> STOP_TEST("recog5", 1640000);
GAP4stones: 0
