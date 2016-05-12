############################################################################
##
##  util.gd                      IRREDSOL                  Burkhard Höfling
##
##  Copyright © 2003–2016 Burkhard Höfling
##


############################################################################
##
#I  InfoIrredsol
##
##  info class for the library
##  
DeclareInfoClass("InfoIrredsol");


############################################################################
##
#F  TestFlag(<n>)
##
##  tests if a bit is set in t
##  
DeclareGlobalFunction("TestFlag");


############################################################################
##
#F  CodeCharacteristicPolynomial(<mat>, <q>)
##
##  given a matrix mat over GF(q), this computes a number which uniquely
##  identifies the characteristic polynomial of mat.
##  
DeclareGlobalFunction("CodeCharacteristicPolynomial");


############################################################################
##
#F  FFMatrixByNumber(n, d, q)
##
##  computes a d x d matrix over GF(q) represented by the integer n
##  
DeclareGlobalFunction("FFMatrixByNumber");


############################################################################
##
#F  CanonicalPcgsByNumber(<pcgs>, <n>)
##
##  computes the canonical pcgs wrt. pcgs represented by the integer n
##  
DeclareGlobalFunction("CanonicalPcgsByNumber");


############################################################################
##
#F  OrderGroupByCanonicalPcgsByNumber(<pcgs>, <n>)
##
##  computes Order(Group(CanonicalPcgsByNumber(<pcgs>, <n>))) without 
##  actually constructing the canonical pcgs or the group
##  
DeclareGlobalFunction("OrderGroupByCanonicalPcgsByNumber");


############################################################################
##
#F  ExponentsCanonicalPcgsByNumber(<pcgs>, <n>)
##
##  computes the list of exponent vectors (relative to exp) of the
##  elements of CanonicalPcgsByNumber(<pcgs>, <n>)) without actually
##  constructing the canonical pcgs itself
##  
DeclareGlobalFunction("ExponentsCanonicalPcgsByNumber");


############################################################################
##
#F  IsMatGroupOverFieldFam(famG, famF)
##
##  tests whether famG is the collections family of matrices over the field
##  whose family is famF
##  
DeclareGlobalFunction("IsMatGroupOverFieldFam");


############################################################################
##
#F  IsPPowerInt(q)
##
##  tests whether q is a prime power, caching new prime powers
##  
DeclareGlobalFunction("IsPPowerInt");


############################################################################
##
#E
##
