############################################################################
##
##  matmaths.gi                  IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#M  Degree(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod (Degree, "for matrix group", true, [IsMatrixGroup], 0,
	DegreeOfMatrixGroup);
		

############################################################################
##
#M  IsIrreducible(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod (IsIrreducible, "for matrix group", true, [IsMatrixGroup], 0,
	function (G)
		return IsIrreducibleMatrixGroup (G, FieldOfMatrixGroup (G));
	end);
	
############################################################################
##
#M  IsIrreducible(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (IsIrreducible, "for matrix group and field", IsMatGroupOverFieldFam, [IsMatrixGroup, IsField], 0,
	function (G, F)
		return IsIrreducibleMatrixGroup (G, F);
	end);
	
############################################################################
##
#M  IsIrreducibleMatrixGroup(<G>)
##
##  see IRREDSOL documentation
##  
InstallOtherMethod (IsIrreducibleMatrixGroup, "for matrix group", true, [IsMatrixGroup], 0,
	function (G)
		return IsIrreducibleMatrixGroup (G, FieldOfMatrixGroup (G));
	end);


############################################################################
##
#M  IsIrreducibleMatrixGroup(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (IsIrreducibleMatrixGroupOp, "for matrix group and finite field - use MeatAxe",
	IsMatGroupOverFieldFam, [IsMatrixGroup and CategoryCollections (IsFFECollColl), IsField], 0,	
	function (G, F)

	if DegreeOfMatrixGroup (G) = 1 then
		return true;
	elif IsTrivial (G) then
		return false;
	else
		return MTX.IsIrreducible (GModuleByMats (GeneratorsOfGroup (G), F));
	fi;
end);


############################################################################
##
#M  IsAbsolutelyIrreducible(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod (IsAbsolutelyIrreducible, "for matrix group", true, [IsMatrixGroup], 0,
	function (G)
		return IsAbsolutelyIrreducibleMatrixGroup (G);
	end);


############################################################################
##
#M  IsAbsolutelyIrreducibleMatrixGroup(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (IsAbsolutelyIrreducibleMatrixGroup, "for mat group over finite field", true,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl)], 0,
	
	function (G)
	
	local M;

	if DegreeOfMatrixGroup (G) = 1 then
		return true;
	elif IsTrivial (G) then
		return false;
	else
		M := GModuleByMats (GeneratorsOfGroup (G), DefaultFieldOfMatrixGroup (G));
		return MTX.IsIrreducible (M) and MTX.IsAbsolutelyIrreducible (M);
	fi;
end);


############################################################################
##
#M  IsPrimitive(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod (IsPrimitive, "for matrix group", true, [IsMatrixGroup], 0,
	function (G)
		return IsPrimitiveMatrixGroup (G);
	end);
	
	
############################################################################
##
#M  IsPrimitiveMatrixGroup(<G>)
##
##  see IRREDSOL documentation
##  
InstallOtherMethod (IsPrimitiveMatrixGroup, "for matrix group", true, [IsMatrixGroup], 0,
	function (G)
		return IsPrimitiveMatrixGroup (G, FieldOfMatrixGroup (G));
	end);


############################################################################
##
#M  IsPrimitive(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (IsPrimitive, "for matrix group and field", true, [IsMatrixGroup, IsField], 0,
	IsMatGroupOverFieldFam, [IsMatrixGroup, IsField], 0,	
	function (G, F)

		return IsPrimitiveMatrixGroup (G, F);
	end);
	

############################################################################
##
#M  IsPrimitiveMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (IsPrimitiveMatrixGroupOp, "for matrix group over finite field", 
	IsMatGroupOverFieldFam,
	[IsMatrixGroup  and CategoryCollections (IsFFECollColl) and IsSolvableGroup, IsField and IsFinite], 0,

	function (G, F)	
		local iso, inv;
		iso := IsomorphismPcGroup (G);
		inv := InverseGeneralMapping (iso);
		SetIsBijective (inv, true);
		SetIsGroupHomomorphism (inv, true);
		return SmallBlockDimensionOfRepresentation (ImagesSource (iso), inv, F, DegreeOfMatrixGroup (G)) = DegreeOfMatrixGroup (G);		
	end);


############################################################################
##
#M  IsPrimitiveMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (IsPrimitiveMatrixGroupOp, "for matrix group over finite field", 
	IsMatGroupOverFieldFam,
	[IsFFEMatrixGroup and HasRepresentationIsomorphism, IsField and IsFinite], 0,

	function (G, F)	
		return SmallBlockDimensionOfRepresentation (
			Source (RepresentationIsomorphism (G)), RepresentationIsomorphism (G), F, DegreeOfMatrixGroup (G)) = DegreeOfMatrixGroup (G);		
	end);


############################################################################
##
#M  IsPrimitiveMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (IsPrimitiveMatrixGroupOp, "for matrix group over finite field", 
	IsMatGroupOverFieldFam,
	[IsFFEMatrixGroup and IsHandledByNiceMonomorphism, IsField and IsFinite], 
	0,

	function (G, F)	
		local iso, inv;
		iso := NiceMonomorphism (G);
		inv := GroupHomomorphismByFunction (NiceObject (G), G, 
			h -> PreImagesRepresentative (iso, h),
			g -> ImageElm (iso, g));
		SetIsBijective (inv, true);
		return SmallBlockDimensionOfRepresentation (NiceObject (G), inv, F, DegreeOfMatrixGroup (G)) = DegreeOfMatrixGroup (G);		
	end);


############################################################################
##
#F  SmallBlockDimensionOfRepresentation(G, hom, F, limit)
##
##  G is a group, F a field, hom a homomorphism G -> GL(n, F), limit an integer
##  The function returns an integer k such that Im hom has a block system 
##  of block dimension k, where k < limit, or k >= limit and G has no
##  block system of block dimesnion < limit
##  
InstallGlobalFunction (SmallBlockDimensionOfRepresentation, function (G, hom, F, limit)

	# computes a block dimension smaller than limit, if it exists,
	# or the smallest block dimension otherwise
	local max, min, dim, M, m, cf, i;
		
	if not IsIrreducibleMatrixGroup (Image (hom, G), F) then
		Error ("G must be irreducible over F");
		return false;
	fi;
	
	max := MaximalSubgroupClassReps (G);
	min := DegreeOfMatrixGroup (Range (hom));
	for M in max do
		if not IsTrivial (M) then
			m := GModuleByMats (List (GeneratorsOfGroup (M), x -> ImageElm (hom, x)), F);
			if not MTX.IsIrreducible (m) then
				cf := First (MTX.CompositionFactors (m),
					cf -> MTX.Dimension (cf) * Index (G, M) = DegreeOfMatrixGroup (Range (hom)) 
							and Length (MTX.Homomorphisms (cf, m)) > 0);
				if cf <> fail then
					dim := SmallBlockDimensionOfRepresentation (M, 
						GroupHomomorphismByImagesNC (M, GL(MTX.Dimension (cf), Size (F)),
						GeneratorsOfGroup (M), MTX.Generators (cf)),
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
InstallMethod (MinimalBlockDimension, "for matrix group", true, [IsMatrixGroup], 0,
	function (G)
		return MinimalBlockDimensionOfMatrixGroup (G);
	end);
	

############################################################################
##
#M  MinimalBlockDimension(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (MinimalBlockDimension, "for matrix group and field", 
	IsMatGroupOverFieldFam, [IsMatrixGroup, IsField], 0,
	function (G, F)

		return MinimalBlockDimensionOfMatrixGroup (G, F);
	end);


############################################################################
##
#M  MinimalBlockDimensionOfMatrixGroup(<G>)
##
##  see IRREDSOL documentation
##  
InstallOtherMethod (MinimalBlockDimensionOfMatrixGroup, "for matrix group", true, 
	[IsMatrixGroup], 0,
	function (G)
		return MinimalBlockDimensionOfMatrixGroup (G, FieldOfMatrixGroup (G));
	end);
	
	
############################################################################
##
#M  MinimalBlockDimensionOfMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (MinimalBlockDimensionOfMatrixGroupOp, "for matrix group over finite field", 
	IsMatGroupOverFieldFam,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl) and IsSolvableGroup, IsField and IsFinite], 0,

	function (G, F)	
		local iso, inv;
		iso := IsomorphismPcGroup (G);
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
InstallMethod (MinimalBlockDimensionOfMatrixGroupOp, "for matrix group over finite field", 
	IsMatGroupOverFieldFam,
	[IsFFEMatrixGroup and HasRepresentationIsomorphism, IsField and IsFinite], 0,

	function (G, F)	
		return SmallBlockDimensionOfRepresentation (
			Source (RepresentationIsomorphism (G)), RepresentationIsomorphism (G), F, 2) ;		
	end);


############################################################################
##
#M  MinimalBlockDimensionOfMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (MinimalBlockDimensionOfMatrixGroupOp, "for matrix group over finite field", 
	IsMatGroupOverFieldFam,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl) and IsHandledByNiceMonomorphism, IsField and IsFinite], 
	0,

	function (G, F)	
		local iso, inv;
		iso := NiceMonomorphism (G);
		inv := GroupHomomorphismByFunction (NiceObject (G), G, 
			h -> PreImagesRepresentative (iso, h),
			g -> ImageElm (iso, g));
		SetIsBijective (inv, true);
		return SmallBlockDimensionOfRepresentation (NiceObject (G), inv, F, 2);		
	end);
	
	
############################################################################
##
#M  CharacteristicOfField(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod (CharacteristicOfField, "for matrix group", true, [IsMatrixGroup], 0,
	M -> Characteristic (DefaultFieldOfMatrixGroup (M)));


############################################################################
##
#M  Characteristic(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod (Characteristic, "for matrix group", true, [IsMatrixGroup], 0,
	CharacteristicOfField);


############################################################################
##
#M  RepresentationIsomorphism(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod (RepresentationIsomorphism, "for mat group handled by nice mono.", true,
	[IsMatrixGroup and IsHandledByNiceMonomorphism], 0,
	function (G)

		local nice;
		
		nice := NiceMonomorphism (G);
		return GroupHomomorphismByFunction (NiceObject (G), G, 
			x -> PreImagesRepresentative (nice, x),
			x -> ImageElm (nice, x));
	end);
	

############################################################################
##
#F  ImprimitivitySystemsForRepresentation(G, rep, F)
##  
##  G is a group, F a finite field, rep: G -> GL(n, F)
##  The function computes a list of all imprimitivity systems of Im rep as a 
##  subgroup of GL(n, F). 
##
##  Each imprimitivity system is represented by a record with the following entries:
##  bases: a list of lists of vectors, each list of vectors being a basis of a block 
##         in the imprimitivity system
##  stab1: the stabilizer in G of the first block (i. e., the block with basis bases[1])
##  min:   true if the block system is a minimal block system
##
## 	Note that ImprimitivitySystemsForRepresentation is not particularly efficient for groups with
##	many imprimitivity systems, because conjugate subgroups may occur in recursive calls to
##  this function. This happens if such a subgroup belongs to several conjugacy class representatives
## 	of maximal subgrous
##
InstallGlobalFunction (ImprimitivitySystemsForRepresentation, function (G, rep, F)

	local systems, max, M, gens, m, c, cf, hom, subsys, sys, newsys, homBasis, homSpace, bas, newbasis, pos, orb;
	
	systems := [];
	max := AttributeValueNotSet (MaximalSubgroupClassReps, G);
	for M in max do
		if not IsTrivial (M) then # inducing up from the trivial rep gives a reducible representation
			gens := List (GeneratorsOfGroup (M), x -> ImageElm (rep, x));
			m := GModuleByMats (gens, F);
			if not MTX.IsIrreducible (m) then
				for c in MTX.CollectedFactors (m) do
					cf := c[1];
					if MTX.Dimension (cf) * Index (G, M) = Degree (Range (rep)) then
						homBasis := MTX.Homomorphisms (cf, m);
						if Length (homBasis) > 0 then # submodule isomorphic with cf
							
							# get imprimitivity systems for cf
							
							hom := GroupHomomorphismByImagesNC (M, GL(MTX.Dimension (cf), Size (F)), 
								GeneratorsOfGroup (M), MTX.Generators (cf));	
							subsys := ImprimitivitySystemsForRepresentation (M, hom, F);
							Add (subsys, rec(bases := [IdentityMat (MTX.Dimension (cf), F)], stab1 := M,
								min := Length (subsys) = 0));
							
							# translate result back
							
							homSpace := VectorSpace (F, homBasis, "basis");
							Assert (1, Dimension (homSpace) = c[2]);
							for bas in Enumerator (homSpace) do
								if bas <> Zero (homSpace) then
									for sys in subsys do
										newbasis := List (sys.bases[1]*bas, ShallowCopy);
										TriangulizeMat (newbasis);
										if ForAll (systems, sys -> not newbasis in sys.bases) then
											orb := Orbit (ImagesSet (rep, G), newbasis, OnSubspacesByCanonicalBasis);
											Assert (1, Length (orb) * Length (newbasis) = Degree (Range (rep)));
											Assert (1, Length (orb) = Index (G, sys.stab1));
											if orb[1] <> newbasis then
												pos := Position (orb, newbasis);
												orb{[1, pos]} := orb{[pos, 1]};
											fi;
											Add (systems, rec (bases := orb, stab1 := sys.stab1)); 
										fi;
									od;
								fi;
							od;
						fi;
					fi;
				od;
			fi;
		fi;
	od;
	
	# add trivial system
	
	Add (systems, rec (bases := [IdentityMat (Degree (Range (rep)), F)], stab1 := G, min := Length (systems) = 0));
	return systems;
end);


############################################################################
##
#A  ImprimitivitySystemsOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (ImprimitivitySystemsOp, "for matrix group handled by nice mono. and finite field", 
	IsMatGroupOverFieldFam,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl) and IsHandledByNiceMonomorphism, IsField and IsFinite], 0, 
	function (G, F)
		local rep;
		rep := RepresentationIsomorphism (G);
		return ImprimitivitySystemsForRepresentation (Source (rep), rep, F);
	end);
	
	
############################################################################
##
#M  ImprimitivitySystemsOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (ImprimitivitySystemsOp, "for matrix group handled by nice mono. and finite field", 
	IsMatGroupOverFieldFam,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl) and IsHandledByNiceMonomorphism, IsField and IsFinite], 0, 
	function (G, F)
		local rep;
		rep := RepresentationIsomorphism (G);
		return ImprimitivitySystemsForRepresentation (Source (rep), rep, F);
	end);
	
	
############################################################################
##
#M  ImprimitivitySystems(<G>)
##
##  see IRREDSOL documentation
##  
InstallOtherMethod (ImprimitivitySystems, "for matrix group: use FieldOfMatrixGroup", true,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl)], 0,
	function (G)
		return ImprimitivitySystems (G, FieldOfMatrixGroup (G));
	end);
	
	
############################################################################
##
#M  MinimalBlockDimensionOfMatrixGroupOp(<G>, <F>)
##
##  see IRREDSOL documentation
##  
InstallMethod (MinimalBlockDimensionOfMatrixGroupOp, "for matrix group having imprimitivity systems",
	IsMatGroupOverFieldFam,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl) and HasComputedImprimitivitySystemss, IsField],
	0,
	function (G, F)
	
		local known, i, sys, d, l;
		
		known := ComputedImprimitivitySystemss (G);
		for i in [1,3..Length(known)-1] do
			if known[i] = F then
				d := DegreeOfMatrixGroup (G);
				for sys in known[i+1] do
					l := Length (sys.bases[1]);
					if l < d then
						d := l;
					fi;
				od;
				return d;
			fi;
		od;
		TryNextMethod ();
	end);
	
	
	
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
InstallGlobalFunction (IsRewritableOverSubfieldNC, function (module, q)

	local module2, gens2;
	
	# compute image under generator of Gal (MTX.Field (module), GF(q)) which powers matrix entries by q
	gens2 := List (MTX.Generators (module), g -> List (g, row -> List (row, a -> a^q)));
	
	module2 := GModuleByMats (gens2, MTX.Field (module));
	return MTX.Isomorphism (module, module2) <> fail;
end);


############################################################################
##
#M  TraceField(<G>)
##
##  see IRREDSOL documentation
##  
InstallMethod (TraceField, "for irreducible matrix group over finite field", true,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl)], 1,

	function (G)

	local ext, gens, q, q0, n, primes, module, basis, p, q1, exp;
	
	if IsTrivial (G) then
		return FieldOfMatrixGroup (G);
	fi;
	
	module := GModuleByMats (GeneratorsOfGroup (G), FieldOfMatrixGroup (G));
	if not MTX.IsIrreducible (module) then
		TryNextMethod();
	elif not MTX.IsAbsolutelyIrreducible (module) then
		module := GModuleByMats (GeneratorsOfGroup (G), GF(Characteristic (G)^MTX.DegreeSplittingField (module)));
		repeat
			basis := MTX.ProperSubmoduleBasis (module);
			module := MTX.InducedActionSubmodule (module, basis);
		until MTX.IsIrreducible (module);
		Assert (1, MTX.IsAbsolutelyIrreducible (module));
	fi;
	
	q := Size (MTX.Field (module));

	# guess a field contained in the smallest field over which module can be realised
	
	q0 := Size ( Field (List (MTX.Generators(module), TraceMat)));
		
	n := LogInt (q, q0);
	
	if n = 1 then
		primes := [];
	else
		primes := Set (Factors (n));
	fi;

	for p in primes do
		repeat
			q1 := q0^(n/p); # size of maximal subfield of E
			if not IsRewritableOverSubfieldNC (module, q1) then
				break;
			else 
				n := n / p;
			fi;
		until n mod p <> 0;
	od;
	# mow module can be rewritten over GF(q0^n) but over no proper subfield
	# translate back to the irreducible but not necessarily absolutely irreducible case
	# the irreducible module has block diagonal matrices which are conjugate via
	# a Galois automorphism of GF(q0^n) of order Deg(G)/Dim(module)
	# so the trace field has index Dim(module)/Deg(G) in GF(q0^n)
	
	exp := LogInt (q0, Characteristic(G))*n*MTX.Dimension (module);
	Assert (1, exp mod DegreeOfMatrixGroup (G) = 0);
	return GF(Characteristic(G)^(exp/DegreeOfMatrixGroup (G)));
end);



############################################################################
##
#M  TraceField(<G>)
##
##  returns a matrix x such that the matrix entries of G^x lie in the
##  trace field of G.
##  
InstallMethod (TraceField, "generic method via conjugacy classes", true,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl)], 0,
	function (G)
	
		local F;
		
		F := FieldOfMatrixGroup (G);
		if IsPrimeField (F) then
			return F;
		elif F = Field (List (GeneratorsOfGroup (G), TraceMat)) then
			return F;
		else
			return Field (List (ConjugacyClasses (G), cl -> TraceMat(Representative (cl))));
		fi;
	end);
	
	

############################################################################
##
#M  ConjugatingMatTraceField(<G>)
##
##  returns a matrix x such that the matrix entries of G^x lie in the
##  trace field of G.
##  
##  This impelemnts an algorithm from 
##  S. P. Glasby, R. B. Howlett, Writing representations over mnimal fields,
##  Comm. Alg. 25 (1997), 1703--1711
##
InstallMethod (ConjugatingMatTraceField, "for absolutely irreducible FFE matrix group", 	
	true,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl)], 0,
	
	function (G)

	
	local ext, q, # p, e, f,  
		t, C, CC, D, Y, A, i, j, mu, nu, 
		module, module2;

		if Length (GeneratorsOfGroup (G)) = 0 then
			return One(G);
		fi;

		ext := FieldOfMatrixGroup (G);
		q := Size (TraceField (G));

		t := LogInt (Size (ext), q);
	
		if t = 1 then
			return One(G);
		fi;

		module := GModuleByMats (GeneratorsOfGroup (G), ext);

		if not MTX.IsAbsolutelyIrreducible (module) then
			TryNextMethod();
		fi;

		# taking q-th powers is a generator of Gal (ext/field)

		module2 := GModuleByMats (List (MTX.Generators (module), 
			A -> List (A, row -> List (row, x -> x^q))), ext);
	
		C := MTX.Isomorphism (module, module2);
	
		if C = fail then
			Error ("panic: cannot rewrite matrix group over trace field!");
		fi;
	
		CC := C;
		D := C;
		for i in [1..t-1] do
			CC := List (CC, row -> List (row, x -> x^q));
			D := D*CC;
		od;
	
		mu := D[1][1];

		repeat
			nu := Random (ext);
		until Norm (FieldOfMatrixGroup (G), TraceField (G), nu) = mu;
	
		C := nu^-1 * C;
	
		repeat 
			Y := RandomMat (MTX.Dimension (module), MTX.Dimension (module), ext);
			A := Y;
			for i in [2..t] do
				A := Y + C * List (A, row -> List (row, x -> x^q));
			od;
		until Length (NullspaceMat (A)) = 0;
	
		Assert (0, ForAll (GeneratorsOfGroup (G), g -> IsSubfield (GF(q), Field (Flat (g^A)))));
		return A;
	end);	


############################################################################
##
#E
##
