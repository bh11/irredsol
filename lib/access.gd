############################################################################
##
##  access.gd                    IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##

############################################################################
##
#V  GUARDIAN_MAT_PCGS
#V  GUARDIAN_ORDER
#V  GUARDIAN_PC_PRESENTATION
#V  GUARDIAN_MIN_BLOCKDIM
#V  GUARDIAN_FLAGS
#V  GUARDIAN_MAX_FLAG
##
##  positions of data entries in library data
##
BindGlobal ("GUARDIAN_MAT_PCGS", 1);
BindGlobal ("GUARDIAN_ORDER", 2);
BindGlobal ("GUARDIAN_PC_PRESENTATION", 3);
BindGlobal ("GUARDIAN_MIN_BLOCKDIM", 4);
BindGlobal ("GUARDIAN_FLAGS", 5);
BindGlobal ("GUARDIAN_MAX_FLAG", 0);

############################################################################
##
#V  ABS_IRRED_GUARDIAN_NUMBER
#V  ABS_IRRED_CANONICAL_PCGS
##
##  positions of data entries in library data
##
BindGlobal ("ABS_IRRED_GUARDIAN_NUMBER", 1);
BindGlobal ("ABS_IRRED_CANONICAL_PCGS", 2);


############################################################################
##
#F  IndicesAbsolutelyIrreducibleSolvableMatrixGroups(<n>, <q>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction ("IndicesAbsolutelyIrreducibleSolvableMatrixGroups");


############################################################################
##
#F  AbsolutelyIrreducibleSolvableMatrixGroup(<n>, <q>, <k>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction ("AbsolutelyIrreducibleSolvableMatrixGroup");


############################################################################
##
#F  CanonicalIndexIrreducibleSolvableMatrixGroup(<n>, <q>, <d>, <k>)
##
##  computes a valid id for the group obtained by
##  rewriting AbsolutelyIrreducibleSolvableMatrixGroup (n/d, q^d, k)
##  as a matrix group over F_p^n. The result is meaningless if
##  AbsolutelyIrreducibleSolvableMatrixGroup (n/d, q^d, k) does not exist
##  
##
DeclareGlobalFunction ("CanonicalIndexIrreducibleSolvableMatrixGroup"); 


############################################################################
##
#F  IndicesIrreducibleSolvableMatrixGroups(<n>, <q>, <d>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction ("IndicesIrreducibleSolvableMatrixGroups");


############################################################################
##
#F  IrreducibleSolvableMatrixGroup(<n>, <q>, <d>, <k>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction ("IrreducibleSolvableMatrixGroup");

############################################################################
##
#F  IndicesMaximalAbsolutelyIrreducibleSolvableMatrixGroups(<n>, <q>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction ("IndicesMaximalAbsolutelyIrreducibleSolvableMatrixGroups");
	

############################################################################
##
#E
##
