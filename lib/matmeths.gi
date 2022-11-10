############################################################################
##
##  matmeths.gi                  IRREDSOL                   Burkhard Höfling
##
##  Copyright © 2003–2016 Burkhard Höfling
##


############################################################################
##
#M  Degree(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod(Degree, "for matrix group", true, [IsMatrixGroup], 0,
    DegreeOfMatrixGroup);
    
        
############################################################################
##
#M  DegreeOfMatrixGroup(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod(DegreeOfMatrixGroup, "for matrix group with dimension", true, 
    [IsMatrixGroup and HasDimension], 0,
    Dimension);


############################################################################
##
#M  IsIrreducible(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod(IsIrreducible, "for matrix group", true, [IsMatrixGroup], 0,
    function(G)
        return IsIrreducibleMatrixGroup(G, FieldOfMatrixGroup(G));
    end);
    
    
############################################################################
##
#M  IsIrreducible(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(IsIrreducible, "for matrix group and field", IsMatGroupOverFieldFam, 
    [IsMatrixGroup, IsField], 0,
    function(G, F)
        return IsIrreducibleMatrixGroup(G, F);
    end);
    
    
############################################################################
##
#M  IsIrreducibleMatrixGroup(<G>)
##
##  
InstallOtherMethod(IsIrreducibleMatrixGroup, "for matrix group", true, [IsMatrixGroup], 0,
    function(G)
        return IsIrreducibleMatrixGroup(G, FieldOfMatrixGroup(G));
    end);


############################################################################
##
#M  IsIrreducibleMatrixGroup(<G>, <F>)
##  
InstallMethod(IsIrreducibleMatrixGroupOp, "for matrix group and finite field - use MeatAxe",
    IsMatGroupOverFieldFam, [IsFFEMatrixGroup, IsField and IsFinite], 0,    
    function(G, F)

        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        if DegreeOfMatrixGroup(G) = 1 then
            return true;
        elif IsTrivial(G) then
            return false;
        elif IsSubset(F, FieldOfMatrixGroup(G)) then
            return MTX.IsIrreducible (GModuleByMats (GeneratorsOfGroup(G), F));
        else
            Error("G must be a matrix group over F");
        fi;
    end);
    

############################################################################
##
#M  IsIrreducibleMatrixGroup(<G>, <F>)
##  
InstallMethod(IsIrreducibleMatrixGroupOp, "for matrix group and finite field - test attr IsIrreducibleMatrixGroup",
    IsMatGroupOverFieldFam, [IsFFEMatrixGroup and HasIsIrreducibleMatrixGroup, 
        IsField and IsFinite], 0,    
    function(G, F)

        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        if IsIrreducibleMatrixGroup(G) then
            if F = FieldOfMatrixGroup(G) then
                return true;
            fi;
        elif IsSubset(F, FieldOfMatrixGroup(G)) then
            return false;
        fi;
        TryNextMethod();
    end);


############################################################################
##
#M  IsIrreducibleMatrixGroup(<G>, <F>)
##  
InstallMethod(IsIrreducibleMatrixGroupOp, "for matrix group and finite field - for absolutely irreducible matrix group",
    IsMatGroupOverFieldFam, [IsFFEMatrixGroup and IsAbsolutelyIrreducibleMatrixGroup, 
        IsField and IsFinite], RankFilter(HasIsIrreducibleMatrixGroup),    
    function(G, F)

        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        return true;
    end);


############################################################################
##
#M  IsAbsolutelyIrreducible(<G>)
##  
InstallMethod(IsAbsolutelyIrreducible, "for matrix group", true, [IsMatrixGroup], 0,
    function(G)
        return IsAbsolutelyIrreducibleMatrixGroup(G);
    end);


############################################################################
##
#M  IsAbsolutelyIrreducibleMatrixGroup(<G>)
##  
##  we use `InstallOtherMethod' because otherwise there will be a warning
##  generated by KeyDependentOperation
##
InstallOtherMethod(IsAbsolutelyIrreducibleMatrixGroup, "for mat group over finite field", true,
    [IsFFEMatrixGroup], 0,
    
    function(G)
    
    local M;

    if DegreeOfMatrixGroup(G) = 1 then
        return true;
    elif IsTrivial(G) then
        return false;
    else
        M := GModuleByMats (GeneratorsOfGroup(G), DefaultFieldOfMatrixGroup(G));
        return MTX.IsIrreducible (M) and MTX.IsAbsolutelyIrreducible (M);
    fi;
end);


############################################################################
##
#M  IsPrimitive(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod(IsPrimitive, "for matrix group", true, [IsMatrixGroup], 0,
    function(G)
        return IsPrimitiveMatrixGroup(G,  FieldOfMatrixGroup(G));
    end);
    
    
############################################################################
##
#M  IsPrimitiveMatrixGroup(<G>)
##
##  we need an OtherMethod to avoid the warning generated by
##  KeyDependentOperation
##  
InstallOtherMethod(IsPrimitiveMatrixGroup, "for matrix group", true, [IsMatrixGroup], 0,
    function(G)
        return IsPrimitiveMatrixGroup(G, FieldOfMatrixGroup(G));
    end);


############################################################################
##
#M  IsPrimitive(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(IsPrimitive, "for matrix group over field", 
    IsMatGroupOverFieldFam, [IsMatrixGroup, IsField], 0,
    function(G, F)

        return IsPrimitiveMatrixGroup(G, F);
    end);
    

############################################################################
##
#M  IsPrimitiveMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(IsPrimitiveMatrixGroupOp, "for matrix group over finite field, construct IsomorphismPcGroup", 
    IsMatGroupOverFieldFam,
    [IsFFEMatrixGroup and IsSolvableGroup, IsField and IsFinite], 0,

    function(G, F)    
        local iso, inv;
        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        iso := IsomorphismPcGroup(G);
        inv := InverseGeneralMapping (iso);
        SetIsBijective (inv, true);
        SetIsGroupHomomorphism (inv, true);
        return SmallBlockDimensionOfRepresentation (ImagesSource (iso), inv, F, DegreeOfMatrixGroup(G)) = DegreeOfMatrixGroup(G);        
    end);


############################################################################
##
#M  IsPrimitiveMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(IsPrimitiveMatrixGroupOp, "for matrix group over finite field, use RepresentationIsomorphism", 
    IsMatGroupOverFieldFam,
    [IsFFEMatrixGroup and HasRepresentationIsomorphism, IsField and IsFinite], 
    RankFilter (IsHandledByNiceMonomorphism) + 1, # rank higher than the nice mono. method

    function(G, F)    
        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        return SmallBlockDimensionOfRepresentation (
            Source (RepresentationIsomorphism (G)), RepresentationIsomorphism (G), F, DegreeOfMatrixGroup(G)) = DegreeOfMatrixGroup(G);        
    end);


############################################################################
##
#M  IsPrimitiveMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(IsPrimitiveMatrixGroupOp, "for matrix group over finite field, use nice monomorphism", 
    IsMatGroupOverFieldFam,
    [IsFFEMatrixGroup and IsHandledByNiceMonomorphism, IsField and IsFinite], 
    0,

    function(G, F)    
        local iso, inv;
        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        iso := NiceMonomorphism (G);
        inv := GroupHomomorphismByFunction(NiceObject (G), G, 
            h -> PreImagesRepresentative(iso, h),
            g -> ImageElm(iso, g));
        SetIsBijective (inv, true);
        return SmallBlockDimensionOfRepresentation (NiceObject (G), inv, F, DegreeOfMatrixGroup(G)) = DegreeOfMatrixGroup(G);        
    end);


############################################################################
##
#M  IsPrimitiveMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(IsPrimitiveMatrixGroupOp, "for matrix group over finite field, try if IsPrimitive is set", 
    IsMatGroupOverFieldFam,
    [IsFFEMatrixGroup and HasIsPrimitive, IsField and IsFinite], 
    RankFilter (IsHandledByNiceMonomorphism) + 3, # rank higher than the nice mono. method

    function(G, F)    
        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        if IsPrimitive(G) then
            if FieldOfMatrixGroup(G) = F then
                return true;
            fi;
        else
            return false;
        fi;
        TryNextMethod();            
    end);


############################################################################
##
#F  SmallBlockDimensionOfRepresentation(G, hom, F, limit)
##
##  hom must be a homomorphism G -> GL(n, F), where G is a group and F a finite 
##  field such that Image(hom, G) is irreducible over F. limit is an integer
##  The function returns an integer k such that Im hom has a block system 
##  of block dimension k, where k < limit, or k >= limit and G has no
##  block system of block dimension < limit
##  
InstallGlobalFunction(SmallBlockDimensionOfRepresentation, function(G, hom, F, limit)

    # computes a block dimension smaller than limit, if it exists,
    # or the smallest block dimension otherwise
    local max, min, dim, M, m, cf, i;
            
    max := AttributeValueNotSet(MaximalSubgroupClassReps, G);
    min := DegreeOfMatrixGroup(Range (hom));
    for M in max do
        if not IsTrivial(M) then
            m := GModuleByMats (List(GeneratorsOfGroup(M), x -> ImageElm(hom, x)), F);
            if not MTX.IsIrreducible (m) then
                cf := First (MTX.CompositionFactors(m),
                    cf -> MTX.Dimension (cf) * IndexNC(G, M) = DegreeOfMatrixGroup(Range (hom)) 
                            and Length(MTX.Homomorphisms (cf, m)) > 0);
                if cf <> fail then
                    dim := SmallBlockDimensionOfRepresentation (M, 
                        GroupHomomorphismByImagesNC(M, GL(MTX.Dimension (cf), Size(F)),
                        GeneratorsOfGroup(M), MTX.Generators (cf)),
                        F, limit);
                    if dim < min then
                        min := dim;
                        if min < limit then
                            return min;
                        fi;
                    fi;
                fi;
            fi;
        fi;
    od;
    return min;
end);


############################################################################
##
#M  MinimalBlockDimension(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod(MinimalBlockDimension, "for matrix group", true, [IsMatrixGroup], 0,
    function(G)
        return MinimalBlockDimensionOfMatrixGroup(G);
    end);
    

############################################################################
##
#M  MinimalBlockDimension(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(MinimalBlockDimension, "for matrix group and field", 
    IsMatGroupOverFieldFam, [IsMatrixGroup, IsField], 0,
    function(G, F)

        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        return MinimalBlockDimensionOfMatrixGroup(G, F);
    end);


############################################################################
##
#M  MinimalBlockDimensionOfMatrixGroup(<G>)
##
##  see IRREDSOL documentation
##  
InstallOtherMethod(MinimalBlockDimensionOfMatrixGroup, "for matrix group", true, 
    [IsMatrixGroup], 0,
    function(G)
        return MinimalBlockDimensionOfMatrixGroup(G, FieldOfMatrixGroup(G));
    end);
    
    
############################################################################
##
#M  MinimalBlockDimensionOfMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(MinimalBlockDimensionOfMatrixGroupOp, "for matrix group over finite field", 
    IsMatGroupOverFieldFam,
    [IsFFEMatrixGroup and IsSolvableGroup, IsField and IsFinite], 0,

    function(G, F)    
        local iso, inv;
        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        
        if not IsIrreducibleMatrixGroup(G, F) then
            TryNextMethod();
        fi;
        
        iso := IsomorphismPcGroup(G);
        inv := InverseGeneralMapping (iso);
        SetIsBijective (inv, true);
        SetIsGroupHomomorphism (inv, true);
        return SmallBlockDimensionOfRepresentation (ImagesSource (iso), inv, F, 2);        
    end);


############################################################################
##
#M  MinimalBlockDimensionOfMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(MinimalBlockDimensionOfMatrixGroupOp, 
    "for matrix group over finite field with representation homomorphism", 
    IsMatGroupOverFieldFam,
    [IsFFEMatrixGroup and HasRepresentationIsomorphism, IsField and IsFinite], 
        RankFilter (IsHandledByNiceMonomorphism) + 1, # rank higher than the nice mono. method

    function(G, F)    
        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        if not IsIrreducibleMatrixGroup(G, F) then
            TryNextMethod();
        fi;
        return SmallBlockDimensionOfRepresentation (
            Source (RepresentationIsomorphism (G)), RepresentationIsomorphism (G), F, 2) ;        
    end);


############################################################################
##
#M  MinimalBlockDimensionOfMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(MinimalBlockDimensionOfMatrixGroupOp, "for matrix group over finite field, use NiceMonomorphism", 
    IsMatGroupOverFieldFam,
    [IsFFEMatrixGroup and IsHandledByNiceMonomorphism, IsField and IsFinite], 
    0,

    function(G, F)    
        local iso, inv;
        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        if not IsIrreducibleMatrixGroup(G, F) then
            TryNextMethod();
        fi;
        iso := NiceMonomorphism (G);
        inv := GroupHomomorphismByFunction(NiceObject (G), G, 
            h -> PreImagesRepresentative(iso, h),
            g -> ImageElm(iso, g));
        SetIsBijective (inv, true);
        return SmallBlockDimensionOfRepresentation (NiceObject (G), inv, F, 2);        
    end);
    
    
############################################################################
##
#M  MinimalBlockDimensionOfMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(MinimalBlockDimensionOfMatrixGroupOp, 
    "for matrix group over finite field which has MinimalBlockDimension", 
    IsMatGroupOverFieldFam,
    [IsFFEMatrixGroup and HasMinimalBlockDimension, IsField and IsFinite], 
        RankFilter (IsHandledByNiceMonomorphism) + 1, # rank higher than the nice mono. method

    function(G, F)    
        if not IsSubset(F, FieldOfMatrixGroup(G)) then
            Error("G must be a matrix group over F");
        fi;
        if F = FieldOfMatrixGroup(G) then
            return MinimalBlockDimension (G);
        elif MinimalBlockDimension (G) = 1 then
            return 1;
        fi;
        TryNextMethod();
    end);


############################################################################
##
#M  CharacteristicOfField(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod(CharacteristicOfField, "for matrix group", true, [IsMatrixGroup], 0,
    M -> Characteristic (DefaultFieldOfMatrixGroup(M)));


############################################################################
##
#M  Characteristic(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod(Characteristic, "for matrix group", true, [IsMatrixGroup], 0,
    CharacteristicOfField);


############################################################################
##
#M  RepresentationIsomorphism(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod(RepresentationIsomorphism, "for mat group handled by nice mono.", true,
    [IsMatrixGroup and IsHandledByNiceMonomorphism], 0,
    function(G)

        local nice, H;
        
        nice := NiceMonomorphism (G);
        H := NiceObject(G);
        
        if IsSolvableGroup(H) then
            nice := IsomorphismPcGroup(G);
            H := Range (nice);
        fi;
        
        return GroupHomomorphismByFunction(H, G, 
            x -> PreImagesRepresentative(nice, x),
            x -> ImageElm(nice, x));
    end);
    

############################################################################
##
#M  RepresentationIsomorphism(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod(RepresentationIsomorphism, "soluble group: inverse of IsomorphismPcGroup", true,
    [IsMatrixGroup], 0,
    function(G)

        local nice;
        
        nice := IsomorphismPcGroup(G);
        return GroupHomomorphismByFunction(Range(nice), G, 
            x -> PreImagesRepresentative(nice, x),
            x -> ImageElm(nice, x));
    end);
    

############################################################################
##
#F  ImprimitivitySystemsForRepresentation(G, rep, F, limit)
##  
##  G is a group, F a finite field, rep: G -> GL(n, F)
##  
##  If G has no block system with block dimension <= limit, the function 
##  computes a list of all imprimitivity systems of Im rep as a 
##  subgroup of GL(n, F). Otherwise, the function computes systems of imprimitivity,
##  one of which will have block dimension <= limit.
##
##  Each imprimitivity system is represented by a record with the following entries:
##  bases: a list of lists of vectors, each list of vectors being a basis of a block 
##            in the imprimitivity system
##  stab1: the stabilizer in G of the first block (i. e., the block with basis bases[1])
##  min:    true if the block system is a minimal block system amongst the systems returned
##
InstallGlobalFunction(ImprimitivitySystemsForRepresentation, function(G, rep, F, limit)

    local systems, max, M, gens, m, c, cf, hom, subsys, sys, newsys, homBasis, homSpace, bas, bas2, newbasis, pos, orb;
    
    if DegreeOfMatrixGroup(Range (rep))< limit then
        return     [rec(bases := [IdentityMat (DegreeOfMatrixGroup(Range (rep)), F)], stab1 := G, min := true)];
    fi;
    systems := [];
    max := AttributeValueNotSet(MaximalSubgroupClassReps, G);
    for M in max do
        if not IsTrivial(M) then # inducing up from the trivial rep gives a reducible representation
            gens := List(GeneratorsOfGroup(M), x -> ImageElm(rep, x));
            m := GModuleByMats (gens, F);
            if not MTX.IsIrreducible (m) then
                for c in MTX.CollectedFactors(m) do
                    cf := c[1];
                    if MTX.Dimension (cf) * IndexNC(G, M) = Degree (Range (rep)) then
                        homBasis := MTX.Homomorphisms (cf, m);
                        if Length(homBasis) > 0 then # submodule isomorphic with cf
                            
                            # get imprimitivity systems for cf
                            
                            hom := GroupHomomorphismByImagesNC(M, GL(MTX.Dimension (cf), Size(F)), 
                                GeneratorsOfGroup(M), MTX.Generators (cf));    
                            subsys := ImprimitivitySystemsForRepresentation (M, hom, F, limit);
                            Add(subsys, rec(bases := [IdentityMat (MTX.Dimension (cf), F)], stab1 := M,
                                min := Length(subsys) = 0));
                            
                            # translate result back
                            
                            homSpace := VectorSpace(F, homBasis{[2..Length(homBasis)]}, 0*homBasis[1], "basis");
                            for bas2 in Enumerator(homSpace) do
                                bas := homBasis[1] + bas2;
                                  for sys in subsys do
                                    newbasis := List(sys.bases[1]*bas, ShallowCopy);
                                    TriangulizeMat (newbasis);
                                    if ForAll (systems, sys -> not newbasis in sys.bases) then
                                        orb := Orbit (ImagesSet(rep, G), newbasis, OnSubspacesByCanonicalBasis);
                                        Assert(1, Length(orb) * Length(newbasis) = Degree (Range (rep)));
                                        Assert(1, Length(orb) = IndexNC(G, sys.stab1));
                                        if orb[1] <> newbasis then
                                            pos := Position (orb, newbasis);
                                            orb{[1, pos]} := orb{[pos, 1]};
                                        fi;
                                        Add(systems, rec(bases := orb, stab1 := sys.stab1, min := sys.min)); 
                                    fi;
                                od;
                            od;
                        fi;
                    fi;
                od;
            fi;
        fi;
    od;
    
    # add trivial system
    
    Add(systems, rec(bases := [IdentityMat (Degree (Range (rep)), F)], stab1 := G, min := Length(systems) = 0));
    return systems;
end);


############################################################################
##
#A  ImprimitivitySystemsOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(ImprimitivitySystemsOp, "for matrix group handled by nice mono. and finite field", 
    IsMatGroupOverFieldFam,
    [IsFFEMatrixGroup and IsHandledByNiceMonomorphism, IsField and IsFinite], 0, 
    function(G, F)
        local rep;
        rep := RepresentationIsomorphism (G);
        return ImprimitivitySystemsForRepresentation (Source (rep), rep, F, 0);
    end);
    
    
############################################################################
##
#M  ImprimitivitySystemsOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(ImprimitivitySystemsOp, "for matrix group handled by nice mono. and finite field", 
    IsMatGroupOverFieldFam,
    [IsFFEMatrixGroup and IsHandledByNiceMonomorphism, IsField and IsFinite], 0, 
    function(G, F)
        local rep;
        rep := RepresentationIsomorphism (G);
        return ImprimitivitySystemsForRepresentation (Source (rep), rep, F, 0);
    end);
    
    
############################################################################
##
#M  ImprimitivitySystems(<G>)
##
##  see IRREDSOL documentation
##  
InstallOtherMethod(ImprimitivitySystems, "for matrix group: use FieldOfMatrixGroup", true,
    [IsFFEMatrixGroup], 0,
    function(G)
        return ImprimitivitySystems (G, FieldOfMatrixGroup(G));
    end);
    
    
############################################################################
##
#M  MinimalBlockDimensionOfMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod(MinimalBlockDimensionOfMatrixGroupOp, "for matrix group having imprimitivity systems",
    IsMatGroupOverFieldFam,
    [IsFFEMatrixGroup and HasComputedImprimitivitySystemss, IsField],
    0,
    function(G, F)
    
        local known, i, sys, d, l;
        
        known := ComputedImprimitivitySystemss (G);
        for i in [1,3..Length(known)-1] do
            if known[i] = F then
                d := DegreeOfMatrixGroup(G);
                for sys in known[i+1] do
                    l := Length(sys.bases[1]);
                    if l < d then
                        d := l;
                    fi;
                od;
                return d;
            fi;
        od;
        TryNextMethod();
    end);
    
    
    
############################################################################
##
#M  TraceField(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod(TraceField, "for irreducible matrix group over finite field", true,
    [IsFFEMatrixGroup and IsFinite], 1,

    function(G)

    local ext, gens, q, q0, module, module2, gens2, c, i, p;
    
    q := Size(FieldOfMatrixGroup(G));
    Info(InfoIrredsol, 3, "TraceField: matrix group is over GF(",q,")");
    
    if IsTrivial(G) then
        Info(InfoIrredsol, 4, "TraceField: trivial group case");
        return FieldOfMatrixGroup(G);
    fi;
    
    # guess a field contained in the smallest field over which module can be realised
    
    
    q0 := Size( Field (List([1..LogInt(Size(G), 2) + 10], i -> TraceMat(PseudoRandom(G)))));
    
    
    if q = q0 then
        Info(InfoIrredsol, 3, "TraceField: trace field is GF(", q0, ")");
        return FieldOfMatrixGroup(G);
    fi;
    
    Info(InfoIrredsol, 3, "TraceField: trace field contains GF(",q0, ")");

    module := GModuleByMats (GeneratorsOfGroup(G), FieldOfMatrixGroup(G));
    
    if not MTX.IsIrreducible (module) then
        Info(InfoIrredsol, 3, "TraceField: trace field contains GF(",q0, ")");
        TryNextMethod();
    fi;
    
    for c in Collected (Factors(LogInt(q, q0))) do
        p := c[1];
        for i in [1..c[2]] do
        
            Info(InfoIrredsol, 1, "TraceField: trying if trace field is GF(",q0, ")");
            # compute Galois conjugate of module
            gens2 := List(MTX.Generators (module), g -> List(g, row -> List(row, a -> a^q0)));    
            module2 := GModuleByMats (gens2, MTX.Field (module));
                         
            # If module1 and module2 are conjugate, their traces are the same, and thus
            # invariant under the Galois automorphism. Therefore the traces must belong to GF(q0).
            # Thus by a theorem of Brauer, module1 (and module2) can be written over GF(q0).
            # Conversely, if module1^x is over GF(q0) for some matrix x, 
            # then module1^x = (module1^x)^q0 = (module1^q0)^(x^q0) = module2^(x^q0)
            # which shows that module1 and module2 are conjugate.

            # see also S. P. Glasby, R. B. Howlett, Writing representations over mnimal fields,
            # Comm. Alg. 25 (1997), 1703--1711
            
             if MTX.Isomorphism (module, module2) <> fail then
                Info(InfoIrredsol, 1, "TraceField: trace field is GF(",q0, ")");
                return GF(q0);
            fi;
    
            q0 := q0^p; # size of minimal superfield of GF(q0)
        od;
    od;
    
    Info(InfoIrredsol, 1, "TraceField: not rewritable over subfield: trace field is GF(",q0, ")");
    
    return GF(q0);
end);



############################################################################
##
#M  TraceField(<G>)
##
InstallMethod(TraceField, "generic method for finite matrix groups via conjugacy classes", true,
    [IsMatrixGroup and IsFinite], 0,
    function(G)
    
        local F, rep;
        
        F := FieldOfMatrixGroup(G);
        if IsPrimeField (F) then
            return F;
        elif F = Field (List(GeneratorsOfGroup(G), TraceMat)) then
            return F;
        else
            rep := RepresentationIsomorphism (G);
            return Field (List(ConjugacyClasses (Source (rep)), cl -> TraceMat(ImageElm(rep, Representative(cl)))));
        fi;
    end);
    

RedispatchOnCondition (TraceField, true, [IsMatrixGroup], [IsFinite], 0);


############################################################################
##
#M  SplittingField(<G>)
##
InstallMethod(SplittingField, "use MeatAxe", true,
    [IsFFEMatrixGroup], 0,
    function(G)
    
        local F, module;
        
        F := FieldOfMatrixGroup(G);
        module := GModuleByMats (GeneratorsOfGroup(G), F);
        if MTX.IsIrreducible (module) then
            return GF(Characteristic (F)^MTX.DegreeSplittingField (module));
        else
            Error("G must be irreducible over FieldOfMatrixGroup(G)");
        fi;
    end);
    

############################################################################
##
#M  ConjugatingMatTraceField(<G>)
##
##  returns a matrix x such that the matrix entries of G^x lie in the
##  trace field of G.
##  
##  The absolutely irreducible case is an impelemntation of an algorithm by
##  S. P. Glasby, R. B. Howlett, Writing representations over mnimal fields,
##  Comm. Alg. 25 (1997), 1703--1711
##
InstallMethod(ConjugatingMatTraceField, "for irreducible FFE matrix group",     
    true,
    [IsFFEMatrixGroup], 0,
    
    function(G)
    
        local ext, q, q1, t, C, CC, D, Y, A, i, j, mu, nu, 
            basis, moduleG, module, module2, module3, absirred;

        if Length(GeneratorsOfGroup(G)) = 0 or TraceField(G) = FieldOfMatrixGroup(G) then
            return One(G);
        fi;

        q := Size(TraceField (G));

        moduleG := GModuleByMats (GeneratorsOfGroup(G), FieldOfMatrixGroup(G));

        # reduce to the absolutely irreducible case
        
        if not MTX.IsIrreducible (moduleG) then
            TryNextMethod();
        fi;
        
        absirred := MTX.IsAbsolutelyIrreducible (moduleG);
        if absirred then
            module := moduleG;
            ext := FieldOfMatrixGroup(G);
        else
            ext := GF(CharacteristicOfField (G)^MTX.DegreeSplittingField (moduleG));
            module := GModuleByMats (GeneratorsOfGroup(G), ext);
            repeat
                basis := MTX.ProperSubmoduleBasis (module);
                module := MTX.InducedActionSubmodule (module, basis);
            until MTX.IsIrreducible (module);
            Assert(1, MTX.IsAbsolutelyIrreducible (module));
        fi;
        
        # moduleG can be rewritten over TraceField(G) but over no proper subfield
        # let GF(q1) be the trace field of module, then over GF(q1),
        # moduleG has block diagonal matrices which are conjugate via
        # a Galois automorphism of GF(q1) of order Deg(G)/Dim(module)
        # so GF(q1) has dimension Dim(moduleG)/Dim(module) over TraceField(G).
        
        # Thus, taking q1-th powers is a generator of Gal (MTX.Field(module)/GF(q1))
        
        q1 := q^(MTX.Dimension (moduleG)/MTX.Dimension(module));
        t := LogInt(Size(ext), q1);
    
        module2 := GModuleByMats (List(MTX.Generators (module), 
            A -> List(A, row -> List(row, x -> x^q1))), ext);
    
        C := MTX.Isomorphism (module, module2);
    
        if C = fail then
            Error("panic: cannot rewrite matrix group over trace field!");
        fi;
    
        CC := C;
        D := C;
        for i in [1..t-1] do
            CC := List(CC, row -> List(row, x -> x^q1));
            D := D*CC;
        od;
    
        mu := D[1][1];

        repeat
            nu := Random(ext);
        until Norm(ext, GF(q1), nu) = mu;
    
        C := nu^-1 * C;
    
        repeat 
            Y := RandomMat(MTX.Dimension(module), MTX.Dimension(module), ext);
            A := Y;
            for i in [2..t] do
                A := Y + C * List(A, row -> List(row, x -> x^q1));
            od;
        until Length(NullspaceMat(A)) = 0;
    
        Assert(1, ForAll(MTX.Generators(module), g -> IsSubset(GF(q1), Field(Flat(g^A)))));
        
        # now we have a solution for the absolutely irreducible case
        
        if absirred then
            MakeImmutable(A);
            ConvertToMatrixRep(A, ext);
            return A;
        fi;
        
        basis := CanonicalBasis(AsVectorSpace(GF(q), GF(q1)));
        
        module3 := GModuleByMats(List(MTX.Generators(module), x -> BlownUpMat(basis, x^A)), MTX.Field(moduleG));
        
        A := Immutable(MTX.Isomorphism(moduleG, module3));
        
        if A = fail then
            Error("could not find conjugating matrix");
        fi;
        Assert(1, ForAll(GeneratorsOfGroup(G), g -> IsSubset(GF(q), Field(Flat(g^A)))));
        ConvertToMatrixRep(A, FieldOfMatrixGroup(G));
        
        return A;
        
    end);
