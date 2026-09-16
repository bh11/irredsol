gap> START_TEST("preimages");

#
# The elements whose preimages IRREDSOL computes are always known to lie in
# the image, so the checked PreImages operations of GAP >= 4.17 must not be
# used: their membership tests can cost far more than the preimage itself.
#
gap> checked := 0;;
gap> if IsBound(PreImagesRepresentativeNC)
>        and PreImagesRepresentativeNC <> PreImagesRepresentative then
>      InstallMethod(PreImagesRepresentative, "count uses (IRREDSOL test)",
>          FamRangeEqFamElm, [IsGeneralMapping, IsObject], 1000,
>          function(map, elm) checked := checked + 1; TryNextMethod(); end);
> fi;

# nice monomorphism methods for MinimalBlockDimension and IsPrimitive
gap> G := Group(GeneratorsOfGroup(IrreducibleSolvableMatrixGroup(9, 2, 1, 12)));;
gap> SetIsHandledByNiceMonomorphism(G, true);
gap> MinimalBlockDimensionOfMatrixGroup(G, GF(2));
9
gap> G := Group(GeneratorsOfGroup(IrreducibleSolvableMatrixGroup(9, 2, 1, 12)));;
gap> SetIsHandledByNiceMonomorphism(G, true);
gap> IsPrimitiveMatrixGroup(G, GF(2));
true

# RepresentationIsomorphism, and recognition including conjugating matrix
gap> G := Group([[[Z(7), 0*Z(7)], [0*Z(7), Z(7)]], [[Z(7)^0, Z(7)^0], [Z(7)^5, Z(7)^3]],
>                [[Z(7)^4, 0*Z(7)], [Z(7)^4, Z(7)^2]]]);;
gap> rep := RepresentationIsomorphism(G);;
gap> ForAll(GeneratorsOfGroup(Source(rep)), x -> ImageElm(rep, x) in G);
true
gap> info := RecognitionIrreducibleSolvableMatrixGroup(G, true, true, true);;
gap> info.id;
[ 2, 7, 1, 20 ]

#
gap> checked;
0
gap> STOP_TEST("preimages");
