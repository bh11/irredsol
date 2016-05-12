############################################################################
##
##  access.gd                    IRREDSOL                  Burkhard Höfling
##
##  Copyright © 2003–2016 Burkhard Höfling
##


############################################################################
##
#F  IndicesAbsolutelyIrreducibleSolubleMatrixGroups(<n>, <q>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction("IndicesAbsolutelyIrreducibleSolubleMatrixGroups");
DECLARE_IRREDSOL_SYNONYMS("IndicesAbsolutelyIrreducibleSolubleMatrixGroups");


############################################################################
##
#F  AbsolutelyIrreducibleSolubleMatrixGroup(<n>, <q>, <k>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction("AbsolutelyIrreducibleSolubleMatrixGroup");
DECLARE_IRREDSOL_SYNONYMS("AbsolutelyIrreducibleSolubleMatrixGroup");


############################################################################
##
#F  RecognitionAbsolutelyIrreducibleSolubleMatrixGroup(G, wantmat, wantgroup)
##
##  see the IRREDSOL manual
##
DeclareGlobalFunction("RecognitionAbsolutelyIrreducibleSolubleMatrixGroup");
DECLARE_IRREDSOL_SYNONYMS("RecognitionAbsolutelyIrreducibleSolubleMatrixGroup");


############################################################################
##
#F  RecognitionAbsolutelyIrreducibleSolubleMatrixGroupNC(G, wantmat, wantgroup)
##
##  see the IRREDSOL manual
##
DeclareGlobalFunction("RecognitionAbsolutelyIrreducibleSolubleMatrixGroupNC");
DECLARE_IRREDSOL_SYNONYMS("RecognitionAbsolutelyIrreducibleSolubleMatrixGroupNC");


############################################################################
##
#A  IdAbsolutelyIrreducibleSolubleMatrixGroup(<G>)
##
##  see the IRREDSOL manual
##  
DeclareGlobalFunction("IdAbsolutelyIrreducibleSolubleMatrixGroup");
DECLARE_IRREDSOL_SYNONYMS("IdAbsolutelyIrreducibleSolubleMatrixGroup");

############################################################################
##
#F  PrimitivePermutationGroupIrreducibleMatrixGroup(<G>)
#F  PrimitivePermutationGroupIrreducibleMatrixGroupNC(<G>)
##
##  see IRREDSOL documentation
##  
DECLAE_IRREDSOL_OBSOLETE("PrimitivePermutationGroupIrreducibleMatrixGroup",
    "PrimitivePermGroupIrreducibleMatrixGroup");
DECLAE_IRREDSOL_OBSOLETE("PrimitivePermutationGroupIrreducibleMatrixGroupNC",
    "PrimitivePermGroupIrreducibleMatrixGroupNC");
    
############################################################################
##
#F  PrimitiveSolublePermutationGroup(<n>,<q>,<d>,<k>)
##
##  see IRREDSOL documentation
##  
DECLAE_IRREDSOL_OBSOLETE("PrimitiveSolublePermutationGroup",
    "PrimitiveSolublePermGroup");

###########################################################################
##
#F  IteratorPrimitiveSolublePermutationGroups(<arg>)
##
##  see IRREDSOL documentation
##  
DECLAE_IRREDSOL_OBSOLETE("IteratorPrimitiveSolublePermutationGroups",
    "IteratorPrimitiveSolublePermGroups");

###########################################################################
##
#F  AllPrimitiveSolublePermutationGroups(<arg>)
##
##  see IRREDSOL documentation
##  
DECLAE_IRREDSOL_OBSOLETE("AllPrimitiveSolublePermutationGroups",
    "AllPrimitiveSolublePermGroups");


###########################################################################
##
#F  OnePrimitiveSolublePermutationGroup(<arg>)
##
##  see IRREDSOL documentation
##  
DECLAE_IRREDSOL_OBSOLETE("OnePrimitiveSolublePermutationGroup", 
    "OnePrimitiveSolublePermGroup");



############################################################################
##
#E
##
