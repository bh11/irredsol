############################################################################
##
##  matmeths.gd                  IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#P  IsIrreducibleMatrixGroup(<G>)
#P  IsIrreducibleMatrixGroup(<G>, <F>)
#O  IsIrreducible(<G>, <F>)
##
##  see IRREDSOL documentation
##  
DeclareProperty ("IsIrreducibleMatrixGroup", IsMatrixGroup);
KeyDependentOperation ("IsIrreducibleMatrixGroup", IsMatrixGroup, IsField, ReturnTrue);
DeclareOperation ("IsIrreducible", [IsMatrixGroup, IsField]);

############################################################################
##
#P  IsAbsolutelyIrreducible(<G>)
#P  IsAbsolutelyIrreducibleMatrixGroup(<G>, <F>)
##
##  see IRREDSOL documentation
##  
DeclareProperty ("IsAbsolutelyIrreducible", IsMatrixGroup);
DeclareProperty ("IsAbsolutelyIrreducibleMatrixGroup", IsMatrixGroup);

############################################################################
##
#P  IsPrimitiveMatrixGroup(<G>)
#P  IsPrimitiveMatrixGroup(<G>, <F>)
#P  IsPrimitiveM(<G>)
#O  IsPrimitiveM(<G>, <F>)
##
##  see IRREDSOL documentation
##  
DeclareProperty ("IsPrimitiveMatrixGroup", IsMatrixGroup);
KeyDependentOperation ("IsPrimitiveMatrixGroup", IsMatrixGroup, IsField, ReturnTrue);
DeclareProperty ("IsPrimitive", IsMatrixGroup); # already a property elsewhere in the library
DeclareOperation ("IsPrimitive", [IsMatrixGroup, IsField]);


############################################################################
##
#A  MinimalBlockDimensionOfMatrixGroup(<G>)
#A  MinimalBlockDimensionOfMatrixGroup(<G>, <F>)
#O  MinimalBlockDimension(<G>, <F>)
##
##  see IRREDSOL documentation
##  
DeclareAttribute ("MinimalBlockDimensionOfMatrixGroup", IsMatrixGroup);
KeyDependentOperation ("MinimalBlockDimensionOfMatrixGroup", IsMatrixGroup, IsField, ReturnTrue);
DeclareOperation ("MinimalBlockDimension", [IsMatrixGroup, IsField]);


############################################################################
##
#A  CharacteristicOfField(<G>)
##
##  see IRREDSOL documentation
##  
DeclareAttribute ("CharacteristicOfField", IsMatrixGroup);


############################################################################
##
#A  RepresentationHomomorphism(<G>)
##
##  see IRREDSOL documentation
##  
DeclareAttribute ("RepresentationHomomorphism", IsMatrixGroup);


############################################################################
##
#P  IsMaximalAbsolutelyIrreducibleSolvableMatrixGroup(<G>)
##
##  see IRREDSOL documentation
##  
DeclareProperty ("IsMaximalAbsolutelyIrreducibleSolvableMatrixGroup", IsMatrixGroup);


############################################################################
##
#F  SmallBlockDimensionOfRepresentation(G, hom, F, limit)
##
##  G is a group, F a field, hom a homomorphism G -> GL(n, F), limit an integer
##  The function returns an integer k such that Im hom has a block system 
##  of block dimension k, where k < limit, or k >= limit and G has no
##  block system of block dimesnion < limit
##  
DeclareGlobalFunction ("SmallBlockDimensionOfRepresentation");


############################################################################
##
#F  ImprimitivitySystemsForRepresentation(G, rep, F)
##  
##  G is a group, F a finite field, rep: G -> GL(n, F)
##  The function computes a list of all imprimitivity systems of Im rep as a 
##  subgroup of GL(n, F). 
##
##  Each imprimitivity system is represented by a record with the following entries:
##  bases: a list of lists of vectors, each list of vectors being a basis of a block in the imprimitivity system
##  stab1: the stabilizer in G of the first block (i. e., the block with basis bases[1])
##  min:   true if the block system is a minimal block system
##
## 	Note that ImprimitivitySystemsForRepresentation is not particularly efficient for groups with
##	many imprimitivity systems, because conjugate subgroups may occur in recursive calls to
##  this function. This happens if such a subgroup belongs to several conjugacy class representatives
## 	of maximal subgrous
##
DeclareGlobalFunction ("ImprimitivitySystemsForRepresentation");


############################################################################
##
#A  ImprimitivitySystems(<G>)
#A  ImprimitivitySystems(<G>, <F>)
##
##  see IRREDSOL documentation
##  
DeclareAttribute ("ImprimitivitySystems", IsMatrixGroup);
KeyDependentOperation ("ImprimitivitySystems", IsMatrixGroup, IsField, ReturnTrue);

############################################################################
##
#F  IsRewritableOverSubfieldNC(module, q)
##  
##  tests whether the irreducible MeatAxe module module can be written over GF(q)
##  This uses ani dea from
##  S. P. Glasby, R. B. Howlett, Writing representations over mnimal fields,
##  Comm. Alg. 25 (1997), 1703..1711
##
##  Note that this does not require module to be absolutely irreducible
##
DeclareGlobalFunction ("IsRewritableOverSubfieldNC");


############################################################################
##
#A  TraceField(<G>)
##
##  see IRREDSOL documentation
##  
DeclareAttribute ("TraceField", IsMatrixGroup);


############################################################################
##
#A  ConjugatingMatTraceField(<G>)
##
##  returns a matrix x such that the matrix entries of G^x lie in the
##  trace field of G.
##  
DeclareAttribute ("ConjugatingMatTraceField", IsMatrixGroup);


############################################################################
##
#E
##
