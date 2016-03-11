TestRandomIrreducibleSolvableMatrixGroup := function (n, q, d, k, e)

    local x, y, G, repG, H1, H, gens, M, rep, info;

    G := IrreducibleSolvableMatrixGroup (n, q, d, k);
    repG := RepresentationIsomorphism (G);

    H1 := Source (repG);

    H := TrivialSubgroup (H1);
    gens := [];
    while Size (H) < Size (H1) do
       x := Random (H1);
       if not x in H then
          H := ClosureSubgroupNC (H, x);
          Add (gens, x);
       fi;
    od;

    y := RandomInvertibleMat (n, GF(q^e));

    M := GroupWithGenerators (List (gens, x -> ImageElm (repG, x)^y));
    SetSize (M, Size (G));
    SetIsSolvableGroup (M, true);
    SetIdIrreducibleSolvableMatrixGroup (M, IdIrreducibleSolvableMatrixGroup (G));
    rep := GroupGeneralMappingByImagesNC (H1, M, gens, GeneratorsOfGroup (M));
    SetIsGroupHomomorphism (rep, true);
    SetIsSingleValued (rep, true);
    SetIsBijective (rep, true);
    SetRepresentationIsomorphism (M, rep);
    info := RecognitionIrreducibleSolvableMatrixGroup (M, true, true, true);
    if info.id <> [n, q, d, k] then;
        Error("wrong id ", info, ", expected ", [n, q, d, k]);
    fi;
    if ForAny (GeneratorsOfGroup (Source (rep)),
            g -> ImageElm (rep, g) ^info.mat
                <> ImageElm (RepresentationIsomorphism(info.group), ImageElm (info.iso, g))) then
        Error ("wrong conjugating matrix");
    fi;
end;
