############################################################################
##
##  primitive.gd                 IRREDSOL                  Burkhard Höfling
##
##  Copyright © 2003–2016 Burkhard Höfling
##


############################################################################
##
#F  PcGroupExtensionByMatrixAction(<pcgs>, <hom>)
##
##  Let <G> be a finite soluble group with pcgs <pcgs>, and let <hom> be a 
##  group hom. $<hom>\colon G \to GL(n, p)$, where $p$ is a prime. Let  $E$ 
##  denote the split
##  extension of $G$ by $V = \F_p$, where <G> acts on <V> via <hom>.
##  This function returns a record with the following components.
##     ext:   the group $E$
##     V:     the subgroup $V$ of $E$
##     C:     a complement of $V$ in $E$ isomorphic with $G$
##     embed: a group homomorphism $G \to E$ with image $C$
##     proj:  a group homomorphism $E \to G$ with kernel $V$
##     pcgsV: a pcgs of V whose elements correspond to the natural basis elements
##              of the vector space V
##     pcgsC: a pcgs of C whose elements correspond to the images of pcgs under
##              hom
##  
DECLARE_IRREDSOL_FUNCTION("PcGroupExtensionByMatrixAction");


############################################################################
##
#F  IrreducibleMatrixGroupPrimitiveSolubleGroup(<G>)
#F  IrreducibleMatrixGroupPrimitiveSolubleGroupNC(<G>)
##
##  see IRREDSOL documentation
##  
DECLARE_IRREDSOL_FUNCTION("IrreducibleMatrixGroupPrimitiveSolubleGroup");
DECLARE_IRREDSOL_FUNCTION("IrreducibleMatrixGroupPrimitiveSolubleGroupNC");


############################################################################
##
#F  PrimitivePcGroupIrreducibleMatrixGroup(<G>)
#F  PrimitivePcGroupIrreducibleMatrixGroupNC(<G>)
##
##  see IRREDSOL documentation
##  
DECLARE_IRREDSOL_FUNCTION("PrimitivePcGroupIrreducibleMatrixGroup");
DECLARE_IRREDSOL_FUNCTION("PrimitivePcGroupIrreducibleMatrixGroupNC");


############################################################################
##
#F  PrimitivePcGroup(<n>,<q>,<d>,<k>)
##
##  see IRREDSOL documentation
##  
DeclareGlobalFunction("PrimitivePcGroup");


############################################################################
##
#F  PrimitivePermGroupIrreducibleMatrixGroup(<G>)
#F  PrimitivePermGroupIrreducibleMatrixGroupNC(<G>)
##
##  see IRREDSOL documentation
##  
DECLARE_IRREDSOL_FUNCTION("PrimitivePermGroupIrreducibleMatrixGroup");
DECLARE_IRREDSOL_FUNCTION("PrimitivePermGroupIrreducibleMatrixGroupNC");


############################################################################
##
#F  PrimitiveSolublePermGroup(<n>,<q>,<d>,<k>)
##
##  see IRREDSOL documentation
##  
DECLARE_IRREDSOL_FUNCTION("PrimitiveSolublePermGroup");


############################################################################
##
#F  DoIteratorPrimitiveSolubleGroups(<convert_func>, <arg_list>)
##
##  generic constructor function for an iterator of all primitive soluble groups
##  which can construct permutation groups or pc groups (or other types of groups),
##  depending on convert_func
##  
DECLARE_IRREDSOL_FUNCTION("DoIteratorPrimitiveSolubleGroups");


###########################################################################
##
#F  IteratorPrimitivePcGroups(<arg>)
##
##  see IRREDSOL documentation
##  
DECLARE_IRREDSOL_FUNCTION("IteratorPrimitivePcGroups");


###########################################################################
##
#F  AllPrimitivePcGroups(<arg>)
##
##  see IRREDSOL documentation
##  
DECLARE_IRREDSOL_FUNCTION("AllPrimitivePcGroups");


###########################################################################
##
#F  OnePrimitivePcGroup(<arg>)
##
##  see IRREDSOL documentation
##  
DECLARE_IRREDSOL_FUNCTION("OnePrimitivePcGroup");


###########################################################################
##
#F  IteratorPrimitiveSolublePermGroups(<arg>)
##
##  see IRREDSOL documentation
##  
DECLARE_IRREDSOL_FUNCTION("IteratorPrimitiveSolublePermGroups");


###########################################################################
##
#F  AllPrimitiveSolublePermGroups(<arg>)
##
##  see IRREDSOL documentation
##  
DECLARE_IRREDSOL_FUNCTION("AllPrimitiveSolublePermGroups");


###########################################################################
##
#F  OnePrimitiveSolublePermGroup(<arg>)
##
##  see IRREDSOL documentation
##  
DECLARE_IRREDSOL_FUNCTION("OnePrimitiveSolublePermGroup");



############################################################################
##
#E
##
