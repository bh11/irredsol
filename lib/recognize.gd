############################################################################
##
##  recognize.gd                 IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#F  IdIrreducibleSolvableMatrixGroupAvailable(<G>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction ("IdIrreducibleSolvableMatrixGroupAvailable");


############################################################################
##
#F  IdAbsolutelyIrreducibleSolvableMatrixGroupAvailable(<G>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction ("IdAbsolutelyIrreducibleSolvableMatrixGroupAvailable");


############################################################################
##
#A  FingerprintMatrixGroup(<G>)
##
##  see the IRREDSOL manual
##  
DeclareAttribute ("FingerprintMatrixGroup", IsMatrixGroup);


############################################################################
##
#F  ConjugatingMatIrreducibleOrFail(G, H, F)
##
##  G and H must be irreducible matrix groups over the finite field F
##
##  computes a matrix x such that G^x = H or returns fail if no such x exists
##
DeclareGlobalFunction ("ConjugatingMatIrreducibleOrFail");


############################################################################
##
#F  ConjugatingMatImprimitiveOrFail(G, H, d, F)
##
##  G and H must be irreducible matrix groups over the finite field F
##  H must be block monomial with block dimension d
##
##  computes a matrix x such that G^x = H or returns fail if no such x exists
##
##  The function works best if d is small. Irreducibility is only requried 
##  if ConjugatingMatIrreducibleOrFail is used
##
DeclareGlobalFunction ("ConjugatingMatImprimitiveOrFail");


############################################################################
##
#F  RecognitionAbsolutelyIrreducibleSolvableMatrixGroup(G, wantmat, wantgroup)
##
##  Let G be an absolutely irreducible solvable matrix group over a finite field. 
##  This function identifies a conjugate H of G group in the library. 
##
##  It returns a record which has the following entries:
##  id:                contains the id of H (and thus of G), 
##                     cf. IdAbsolutelyIrreducibleSolvableMatrixGroup
##  mat: (optional)    a matrix x such that G^x = H
##  group: (optional)  the group H
##
##  The entries mat and group are only present if the booleans wantmat and/or
##  wantgroup are true, respectively.
##
##  Note that in most cases, the function will be much slower if wantmat
##  is set to true.  
##
DeclareGlobalFunction ("RecognitionAbsolutelyIrreducibleSolvableMatrixGroup");


############################################################################
##
#F  RecognitionAbsolutelyIrreducibleSolvableMatrixGroupNC(G, wantmat, wantgroup)
##
##  version of RecognitionAbsolutelyIrreducibleSolvableMatrixGroup which 
##  does not check its arguments and returns fail if G is not within 
##  the scope of the IRREDSOL library
##
DeclareGlobalFunction ("RecognitionAbsolutelyIrreducibleSolvableMatrixGroupNC");


############################################################################
##
#F  RecognitionIrreducibleSolvableMatrixGroup(G, wantmat, wantgroup)
##
##  Let G be an irreducible solvable matrix group over a finite field. 
##  This function identifies a conjugate H of G group in the library. 
##
##  It returns a record which has the following entries:
##  id:                contains the id of H (and thus of G), 
##                     cf. IdIrreducibleSolvableMatrixGroup
##  mat: (optional)    a matrix x such that G^x = H
##  group: (optional)  the group H
##
##  The entries mat and group are only present if the booleans wantmat and/or
##  wantgroup are true, respectively.
##
##  Currently, wantmat may only be true if G is absolutely irreducible.
##
##  Note that in most cases, the function will be much slower if wantmat
##  is set to true.  
##
DeclareGlobalFunction ("RecognitionIrreducibleSolvableMatrixGroup");


############################################################################
##
#F  RecognitionIrreducibleSolvableMatrixGroupNC(G, wantmat, wantgroup)
##
##  version of RecognitionIrreducibleSolvableMatrixGroup which does not check
##  its arguments and returns fail if G is not within the scope of the 
##  IRREDSOL library
##
DeclareGlobalFunction ("RecognitionIrreducibleSolvableMatrixGroupNC");


############################################################################
##
#A  IdIrreducibleSolvableMatrixGroup(<G>)
##
##  see the IRREDSOL manual
##  
DeclareAttribute ("IdIrreducibleSolvableMatrixGroup", IsMatrixGroup);


############################################################################
##
#A  IdAbsolutelyIrreducibleSolvableMatrixGroup(<G>)
##
##  see the IRREDSOL manual
##  
DeclareAttribute ("IdAbsolutelyIrreducibleSolvableMatrixGroup", IsMatrixGroup);


############################################################################
##
#V  MS_GROUP_INDEX
##
##  translation table for Mark Short's irredsol library
##
DeclareGlobalVariable ("MS_GROUP_INDEX");


############################################################################
##
#F  IdIrreducibleSolvableMatrixGroupIndexMS(<n>, <p>, <k>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction ("IdIrreducibleSolvableMatrixGroupIndexMS");


############################################################################
##
#F  IndexMSIdIrreducibleSolvableMatrixGroup(<n>, <q>, <d>, <k>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction ("IndexMSIdIrreducibleSolvableMatrixGroup");


############################################################################
##
#E
##
