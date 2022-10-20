############################################################################
##
##  recognize.gd                 IRREDSOL                  Burkhard Höfling
##
##  Copyright © 2003–2016 Burkhard Höfling
##


############################################################################
##
#F  IsAvailableIdIrreducibleSolubleMatrixGroup(<G>)
##
##  see the IRREDSOL manual
##  
DECLARE_IRREDSOL_FUNCTION("IsAvailableIdIrreducibleSolubleMatrixGroup");


############################################################################
##
#F  IsAvailableIdAbsolutelyIrreducibleSolubleMatrixGroup(<G>)
##
##  see the IRREDSOL manual
##  
DECLARE_IRREDSOL_FUNCTION("IsAvailableIdAbsolutelyIrreducibleSolubleMatrixGroup");


############################################################################
##
#F  FingerprintDerivedSeries(<n>)
##
DeclareAttribute("FingerprintDerivedSeries", IsGroup);


############################################################################
##
#A  FingerprintMatrixGroup(<G>)
##
##  construct some data which is invariant under conjugation by an element
##  of the containing GL
##  
DeclareAttribute("FingerprintMatrixGroup", IsMatrixGroup);
DECLARE_IRREDSOL_SYNONYMS_ATTR("FingerprintMatrixGroup");


############################################################################
##
#F  ConjugatingMatIrreducibleRepOrFail(repG, repH, q, linonly, maxcost, limit)
##
DeclareGlobalFunction("ConjugatingMatIrreducibleRepOrFail");


############################################################################
##
#F  ConjugatingMatIrreducibleOrFail(G, H, F)
##
DeclareGlobalFunction("ConjugatingMatIrreducibleOrFail");


############################################################################
##
#F  ConjugatingMatImprimitiveOrFail(G, H, d, F)
##
##  G and H must be irreducible matrix groups over the finite field F
##  H must be block monomial with block dimension d
##
##  computes a matrix x such that G^x = H or returns fail if no such x exists
##
##  The function works best if d is small. Irreducibility is only required 
##  if ConjugatingMatIrreducibleOrFail is used
##
DeclareGlobalFunction("ConjugatingMatImprimitiveOrFail");


############################################################################
##
#F  RecognitionAISMatrixGroup(G, inds, wantmat, wantgroup)
##
##  version of RecognitionIrreducibleSolubleMatrixGroupNC which 
##  only works for absolutely irreducible groups G. This version
##  allows to prescribe a set of absolutely irreducible subgroups
##  to which G is compared. This set is described as a subset <inds> of 
##  IndicesAbsolutelyIrreducibleSolubleMatrixGroups(n, q), where n is the
##  degree of G and q is the order of the trace field of G. if inds is fail,
##  all groups in the IRREDSOL library are considered.
##
##  WARNING: The result may be wrong if G is not among the groups
##  described by <inds>.
##
DeclareGlobalFunction("RecognitionAISMatrixGroup");


############################################################################
##
#F  RecognitionIrreducibleSolubleMatrixGroup(G, wantmat, wantgroup)
##
##  Let G be an irreducible soluble matrix group over a finite field. 
##  This function identifies a conjugate H of G group in the library. 
##
##  It returns a record which has the following entries:
##  id:                contains the id of H (and thus of G), 
##                     cf. IdIrreducibleSolubleMatrixGroup
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
DECLARE_IRREDSOL_FUNCTION("RecognitionIrreducibleSolubleMatrixGroup");


############################################################################
##
#F  RecognitionIrreducibleSolubleMatrixGroupNC(G, wantmat, wantgroup)
##
##  version of RecognitionIrreducibleSolubleMatrixGroup which does not check
##  its arguments and returns fail if G is not within the scope of the 
##  IRREDSOL library
##
DECLARE_IRREDSOL_FUNCTION("RecognitionIrreducibleSolubleMatrixGroupNC");


############################################################################
##
#A  IdIrreducibleSolubleMatrixGroup(<G>)
##
##  see the IRREDSOL manual
##  
DeclareAttribute("IdIrreducibleSolubleMatrixGroup", IsMatrixGroup);
DECLARE_IRREDSOL_SYNONYMS_ATTR("IdIrreducibleSolubleMatrixGroup");


############################################################################
##
#F  IdIrreducibleSolubleMatrixGroupIndexMS(<n>, <p>, <k>)
##
##  see the IRREDSOL manual
##  
DECLARE_IRREDSOL_FUNCTION("IdIrreducibleSolubleMatrixGroupIndexMS");


############################################################################
##
#F  IndexMSIdIrreducibleSolubleMatrixGroup(<n>, <q>, <d>, <k>)
##
##  see the IRREDSOL manual
##  
DECLARE_IRREDSOL_FUNCTION("IndexMSIdIrreducibleSolubleMatrixGroup");


############################################################################
##
#E
##
