############################################################################
##
##  util.gd                      IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#I  InfoIrredsol
##
##  info class for the library
##  
DeclareInfoClass ("InfoIrredsol");


############################################################################
##
#I  TestFlag(<n>)
##
##  tests if a bit is set in t
##  
DeclareGlobalFunction ("TestFlag");


############################################################################
##
#F  NumberOfFFPolynomial(<p>, <q>)
##
##  computes a number characterising the polynomial p.
##  The polynomial p wmust be over GF(q)
##  
DeclareGlobalFunction ("NumberOfFFPolynomial");


############################################################################
##
#F  FFMatrixByNumber(n, d, q)
##
##  computes a d x d matrix over GF(q) represented by the integer n
##  
DeclareGlobalFunction ("FFMatrixByNumber");


############################################################################
##
#F  CanonicalPcgsByNumber(<p>, <q>)
##
##  computes a number characterising the matrix m.
##  The matrix m wmust be over GF(q)
##  
DeclareGlobalFunction ("CanonicalPcgsByNumber");


############################################################################
##
#F  OrderGroupByCanonicalPcgsByNumber(<pcgs>, <n>)
##
##  computes Order (Group (CanonicalPcgsByNumber(<pcgs>, <n>))) without 
##  actually constructing the canonical pcgs or the group
##  
DeclareGlobalFunction ("OrderGroupByCanonicalPcgsByNumber");


############################################################################
##
#F  ExponentsCanonicalPcgsByNumber(<pcgs>, <n>)
##
##  computes the list of exponent vectors (relative to exp) of the 
##  elements of CanonicalPcgsByNumber(<pcgs>, <n>)) without actually
##  constructing the canonical pcgs itself
##  
DeclareGlobalFunction ("ExponentsCanonicalPcgsByNumber");


############################################################################
##
#V  GENS_EXT_AFF
##
##  This variable caches the return values of GeneratorsOfExtendedAffineGroup
##  (see below)
##  
DeclareGlobalVariable ("GENS_EXT_AFF");


############################################################################
##
#F  GeneratorsOfExtendedAffineGroup(q, n)
##
##  Let q be a prime power and n an integer. This function returns a 
##  record with entries genmul and gengal.
##
##  Both are n x n matrices over GF(q). genmul is the action of
##  a generator of the multiplicative group of GF(q^n), regarded as a vector 
##  space over GF(q). gengal is a matrix describing the action of a generator
##  of the Galois group of GF(q^n)/GF(q) on that vector space.
##  
DeclareGlobalFunction ("GeneratorsOfExtendedAffineGroup");


############################################################################
##
#F  AsMatrixListOverSubield(list, n, q)
##
##  list must be a list of square matrices of the same size d over GF(q^n),
##  where q is a prime power and n a positive integer.
##
##  This function rewrites each matrix in list as a matrix acting on
##  GF(q^n)^d, regarded as a GF(q)-vector space.
##  
DeclareGlobalFunction ("AsMatrixListOverSubield");


############################################################################
##
#O  IsSubfield(<E>, <F>)
##
##  checks whether F is a subfield of E
##  
DeclareOperation ("IsSubfield", [IsField, IsField]);


############################################################################
##
#F  IsMatGroupOverFieldFam(famG, famF)
##
##  tests whether famG is the collections family of matrices over the field
##  whose family is famF
##  
DeclareGlobalFunction ("IsMatGroupOverFieldFam");


############################################################################
##
#E
##
