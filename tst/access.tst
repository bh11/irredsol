gap> START_TEST("access");
gap> LoadPackage ("irredsol", "", false);
true
gap> SetInfoLevel (InfoIrredsol, 0);
gap> UnloadAbsolutelyIrreducibleSolvableGroupData ();
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3));;
gap> SortedList (List (all, Size));
[ 4, 8, 8, 8, 16, 24, 48 ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3), IsAbsolutelyIrreducibleMatrixGroup, true);;
gap> SortedList (List (all, Size)) ;
[ 8, 8, 16, 24, 48 ]
gap> List (all, IsAbsolutelyIrreducible);
[ true, true, true, true, true ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3), IsAbsolutelyIrreducibleMatrixGroup, false);;
gap> SortedList (List (all, Size)) ;
[ 4, 8 ]
gap> List (all, IsAbsolutelyIrreducible);
[ false, false ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3), IsMaximalAbsolutelyIrreducibleSolvableMatrixGroup, true);;
gap> List (all, Size);
[ 48 ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3), IsMaximalAbsolutelyIrreducibleSolvableMatrixGroup, false);;
gap> SortedList (List (all, Size)) ;
[ 4, 8, 8, 8, 16, 24 ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3), IsAbsolutelyIrreducibleMatrixGroup, true, IsPrimitive, true);;
gap> SortedList (List (all, Size)) ;
[ 8, 16, 24, 48 ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3), IsAbsolutelyIrreducibleMatrixGroup, true, IsPrimitive, false);;
gap> SortedList (List (all, Size)) ;
[ 8 ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3), IsPrimitive, true);;
gap> SortedList (List (all, Size)) ;
[ 8, 8, 16, 24, 48 ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3), IsPrimitive, false);;
gap> SortedList (List (all, Size)) ;
[ 4, 8 ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3), MinimalBlockDimension, [1]);;
gap> SortedList (List (all, Size)) ;
[ 4, 8 ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3), MinimalBlockDimension, [2]);;
gap> SortedList (List (all, Size)) ;
[ 8, 8, 16, 24, 48 ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 2, Field, GF(3), MinimalBlockDimension, [2], IsAbsolutelyIrreducibleMatrixGroup, true);;
gap> SortedList (List (all, Size)) ;
[ 8, 16, 24, 48 ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 4, Field , GF(3), IsPrimitiveMatrixGroup, true);;
gap> Collected (List (all, Size)) ;
[ [ 5, 1 ], [ 10, 2 ], [ 20, 4 ], [ 40, 5 ], [ 80, 5 ], [ 96, 4 ], 
  [ 160, 4 ], [ 192, 6 ], [ 288, 1 ], [ 320, 2 ], [ 384, 1 ], [ 576, 3 ], 
  [ 640, 1 ], [ 1152, 3 ], [ 2304, 1 ] ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 4, Field , GF(3), IsPrimitiveMatrixGroup, false);;
gap> Collected (List (all, Size)) ;
[ [ 16, 5 ], [ 32, 12 ], [ 48, 2 ], [ 64, 12 ], [ 96, 5 ], [ 128, 10 ], 
  [ 192, 4 ], [ 256, 6 ], [ 384, 3 ], [ 512, 1 ], [ 768, 1 ], [ 1152, 1 ], 
  [ 2304, 2 ], [ 4608, 1 ] ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 4, Field , GF(3), MinimalBlockDimension, 2);;
gap> Collected (List (all, Size)) ;
[ [ 16, 2 ], [ 32, 7 ], [ 48, 2 ], [ 64, 8 ], [ 96, 4 ], [ 128, 9 ], 
  [ 192, 1 ], [ 256, 6 ], [ 384, 2 ], [ 512, 1 ], [ 768, 1 ], [ 1152, 1 ], 
  [ 2304, 2 ], [ 4608, 1 ] ]
gap> all := AllIrreducibleSolvableMatrixGroups (Degree, 4, Field , GF(3), MinimalBlockDimension, 1);;
gap> Collected (List (all, Size)) ;
[ [ 16, 3 ], [ 32, 5 ], [ 64, 4 ], [ 96, 1 ], [ 128, 1 ], [ 192, 3 ], 
  [ 384, 1 ] ]
gap> STOP_TEST("access", 2200000);
