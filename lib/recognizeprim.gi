############################################################################
##
##  recognizeprim.gi              IRREDSOL                  Burkhard Höfling
##
##  Copyright © 2003–2016 Burkhard Höfling
##


###########################################################################
##
#F  IdPrimitiveSolubleGroup(<grp>)
##
##  see IRREDSOL documentation
##  
InstallMethod(IdPrimitiveSolubleGroup, "for soluble group",
     true, [IsSolvableGroup and IsFinite], 0,
     G -> IdIrreducibleSolubleMatrixGroup(IrreducibleMatrixGroupPrimitiveSolubleGroup(G)));


RedispatchOnCondition(IdPrimitiveSolubleGroup, true, [IsGroup],
     [IsFinite and IsSolvableGroup], 0);


###########################################################################
##
#F  IdPrimitiveSolubleGroupNC(<grp>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction(IdPrimitiveSolubleGroupNC,
     function(G)
          local id;
          id := IdIrreducibleSolubleMatrixGroup(IrreducibleMatrixGroupPrimitiveSolubleGroupNC(G));
          SetIdPrimitiveSolubleGroup(G, id);
          return id;
     end);
     

############################################################################
##
#F  RecognitionPrimitiveSolubleGroup(<G>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction(RecognitionPrimitiveSolubleGroup,
    function(G, wantiso)
    
        local N, F, p, pcgsN, C, pcgsC, one, i, mat, mats, CC, H, hom, infomat, info, rep, ext, imgs, g, r;
        
        N := FittingSubgroup(G);
        
        pcgsN := Pcgs(N);
        p := Set(RelativeOrders(pcgsN));
        if Length(p) <> 1 then
            Error("G must be primitive");
        fi;
        
        p := p[1];
        
        if not IsAbelian(N) or ForAny(pcgsN, g -> g^p <> One(G)) then
            Error("G must be primitive");
        fi;
        
        # now we know that N is elementary abelian of exponent p
        
        F := GF(p); 
        one := One(F);
        
        mats := [];
        
        C := ComplementClassesRepresentatives(G, N);
        if Length(C) <> 1 then
          Error("G must be primitive");
        fi;
        
        C := C[1];
        
        # N is complemented
        
        pcgsC := Pcgs(C);
        for g in pcgsC do
            mat := [];
            for i in [1..Length(pcgsN)] do
                mat[i] := ExponentsOfPcElement(pcgsN, pcgsN[i]^g)*one;
            od;
            Add(mats, ImmutableMatrix(F, mat));
        od;
        
        if not MTX.IsIrreducible(GModuleByMats(mats, F)) then
            Error("G must be primitive");
        fi;
        
        H := Group(mats);
        
        # the recognition part works best if the source of the representation isomorphism is a pc group
                
        if IsPcGroup(C) then
            CC := C;
        else
            CC := PcGroupWithPcgs(Pcgs(C));
        fi;
        
        SetSize(H, Size(C));
        hom := GroupGeneralMappingByImagesNC(CC, H, Pcgs(CC), mats);
        SetIsGroupHomomorphism(hom, true);
        SetIsBijective(hom, true);
        SetRepresentationIsomorphism(H, hom);

        infomat := RecognitionIrreducibleSolubleMatrixGroup(H, wantiso, wantiso, wantiso);

        info := rec(id := infomat.id);
        if not wantiso then
            return info;
        fi;

        rep := RepresentationIsomorphism(infomat.group);
        
        ext := PcGroupExtensionByMatrixAction(Pcgs(Source(rep)), rep);
        
        imgs := [];
        for g in Pcgs(CC) do
            Add(imgs, ImageElm(ext.embed, ImageElm(infomat.iso, g)));
        od;
        for r in infomat.mat do
            g := PcElementByExponents(ext.pcgsV, List(r, IntFFE));
            Add(imgs, g);
        od;
        
        info.group := ext.E;
        info.iso := GroupHomomorphismByImages(G, ext.E,
            Concatenation(pcgsC, pcgsN), imgs);
        if info.iso = fail or not IsBijective(info.iso) then
            Error("wrong group homomorphism");
        fi;
        return info;
    end);
             

############################################################################
##
#E
##

    