############################################################################
##
##  recognizeprim.gi              IRREDSOL                  Burkhard Höfling
##
##  Copyright © Burkhard Höfling (burkhard@hoefling.name)
##


############################################################################
##
#F  RecognitionPrimitiveSolubleGroup(<G>)
##
DECLARE_IRREDSOL_FUNCTION("RecognitionPrimitiveSolubleGroup");
    

###########################################################################
##
#A  IdPrimitiveSolubleGroup(<grp>)
#F  IdPrimitiveSolubleGroupNC(<grp>)
##
##  see IRREDSOL documentation
##  
DeclareAttribute("IdPrimitiveSolubleGroup", IsGroup);
DECLARE_IRREDSOL_SYNONYMS_ATTR("IdPrimitiveSolubleGroup");
DECLARE_IRREDSOL_FUNCTION("IdPrimitiveSolubleGroupNC");


############################################################################
##
#E
##
