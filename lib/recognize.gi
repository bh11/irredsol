############################################################################
##
##  recognize.gi                 IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#F  IdIrreducibleSolvableMatrixGroupAvailable(<G>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IdIrreducibleSolvableMatrixGroupAvailable,
	function (G)
		return IsMatrixGroup(G) and IsFinite (FieldOfMatrixGroup(G))
			and IsSolvable (G)  and IsIrreducibleMatrixGroup (G)
			and IsAvailableIrreducibleSolvableGroupData (
				DegreeOfMatrixGroup (G), Size (TraceField(G)));
	end);


############################################################################
##
#F  IdAbsolutelyIrreducibleSolvableMatrixGroupAvailable(<G>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IdAbsolutelyIrreducibleSolvableMatrixGroupAvailable,
	function (G)
		return IsMatrixGroup(G) and IsFinite (FieldOfMatrixGroup(G))
			and IsSolvable (G) and IsAbsolutelyIrreducibleMatrixGroup (G)
			and IsAvailableAbsolutelyIrreducibleSolvableGroupData (
				DegreeOfMatrixGroup (G), Size (TraceField(G)));
	end);


############################################################################
##
#M  FingerprintMatrixGroup(<G>)
##
##  see the IRREDSOL manual
##  
InstallMethod (FingerprintMatrixGroup, "for irreducible FFE matrix group", true,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl)], 0,
	function (G)

	local ids, counts, cl, id, pos, rep, i, F, g, q;
	
	F := DefaultFieldOfMatrixGroup (G);
	q := Size (TraceField (G));
	rep := RepresentationIsomorphism (G);
	ids := [];
	for cl in AttributeValueNotSet (ConjugacyClasses, Source (rep)) do
		g := Representative (cl);
		if g <> g^0 then
			id := [Size (cl), Order (g), 
				NumberOfFFPolynomial (CharacteristicPolynomial (F, ImageElm (rep, g)), 
					q), 1];
			pos := PositionSorted (ids, id);
			if not IsBound (ids[pos]) or ids[pos]{[1,2,3]} <> id{[1,2,3]} then
				ids{[pos+1..Length (ids)+1]} := ids{[pos..Length (ids)]};
				ids[pos] := id;
			else
				ids[pos][4] := ids[pos][4] + 1;
			fi;
		fi;
	od;
	return ids;
end);


############################################################################
##
#F  ConjugatingMatIrreducibleOrFail(G, H, F)
##
##  G and H must be irreducible matrix groups over the finite field F
##
##  computes a matrix x such that G^x = H or returns fail if no such x exists
##
InstallGlobalFunction(ConjugatingMatIrreducibleOrFail,
	function (G, H, F)

		local repG, repH, gensG, iso, gensH, autH, moduleG, orb, modules, i, x, a, gens, module;
		
		repG := RepresentationIsomorphism (G);
		repH := RepresentationIsomorphism (H);
		
		gensG := SmallGeneratingSet (Source (repG));
		iso := IsomorphismGroups (Source (repG), Source (repH));
		if iso = fail then
			return fail;
		fi;
		
		gensH := List (gensG, g -> ImageElm (iso, g));
		
		autH := AutomorphismGroup (Source (repH));
		
		moduleG := GModuleByMats (List (gensG, h -> ImageElm (repG, h)), F);
		if not MTX.IsIrreducible (moduleG) then
			Error ("G must be irreducible over F");
		fi;

		orb := [gensH];
		modules := [GModuleByMats (List (gensH, h -> ImageElm (repH, h)), F)];
		if not MTX.IsIrreducible (modules[1]) then
			Error ("panic: image should be irreducible");
		fi;
		
		x := MTX.Isomorphism (moduleG, modules[1]);
		if x <> fail then 
			Info (InfoIrredsol, 3, "conjugating matrix found");
			return x;
		fi;
		
		i := 1;
		while i <= Length (orb) do
			for a in GeneratorsOfGroup (autH) do
				gens := List (orb[i], h -> ImageElm (a, h));
				module := GModuleByMats (List (gens, h -> ImageElm (repH, h)), F);
				if not MTX.IsIrreducible (module) then
					Error ("panic: image should be irreducible");
				fi;
				x := MTX.Isomorphism (moduleG, module);
				if x <> fail then 
					Info (InfoIrredsol, 3, "conjugating matrix found");
					return x;
				fi;
				if ForAll (modules, m -> MTX.Isomorphism (m, module) = fail ) then
					Add (orb, gens);
					Add (modules, module);
				fi;
			od;
			i := i + 1;
		od;
		Info (InfoIrredsol, 3, "group are not conjugate");
		return fail;
	end);


############################################################################
##
#F  ConjugatingMatImprimitiveOrFail(G, H, d, F)
##
##  G and H must be irreducible matrix groups over the finite field F
##  H must be block monomial with block dimension d
##
##  computes a matrix x such that G^x = H or returns fail if no such x exists
##
##  The function works best if d is small. Irreducibility is only requried 
##  if ConjugatingMatIrreducibleOrFail is used
##
InstallGlobalFunction (ConjugatingMatImprimitiveOrFail, function (G, H, d, F)

# H must have minimal block dimension d and must be a block monomial group for that block size

	local n, systemsG, W, hom, r, basis, orb, posbasis, act, i, blocks, 
		permW, permH, sys, permG, gensG, C, Cinv, mat;
	
	n := DegreeOfMatrixGroup (H);
	systemsG := ImprimitivitySystems (G);

	if d = n then
		if Size (G) mod 1024 <> 0 and Size(G) < 100000 then
			return ConjugatingMatIrreducibleOrFail (G, H, F);
		fi;
		hom := NiceMonomorphism (GL(n, Size(F)));
		r := RepresentativeAction (ImagesSource (hom), 
				ImagesSet (hom, G), ImagesSet (hom, H));
		if r <> fail then
			Info (InfoIrredsol, 3, " conjugating matrix found");
			return PreImagesRepresentative (hom, r);
		else
			Info (InfoIrredsol, 3, "groups are not conjugate");
			return fail;
		fi;
	else
		W := WreathProductOfMatrixGroup (GL (d, Size (F)), SymmetricGroup (n/d));
		basis := IdentityMat (n, F);
		orb := Orbit (W, basis[1], OnRight);
		posbasis := List (basis, b -> Position (orb, b));
		Assert (1, not fail in posbasis);
		permW := Group (List (GeneratorsOfGroup (W), g -> Permutation (g, orb, OnRight)));
			
		blocks := [];
		for i in [0,d..n-d] do
			Add (blocks, basis{[i+1..i+d]});
		od;
		act := TransitiveIdentification (Action (H, blocks, OnSubspacesByCanonicalBasis));
			
		permH := Group (List (GeneratorsOfGroup (H), g -> Permutation (g, orb, OnRight)));
		Assert (1, IsSubgroup (permW, permH));
	
		for sys in systemsG do
			if Length (sys.bases[1]) = d 
					and TransitiveIdentification (
						Action (G, sys.bases, OnSubspacesByCanonicalBasis)) = act then				
				C := Concatenation (sys.bases);
				Cinv := C^-1;
				gensG := List (GeneratorsOfGroup (G), B -> C*B*Cinv);
				permG := Group (List (gensG, g->Permutation (g, orb, OnRight)));
				Assert (1, IsSubgroup (permW, permG));
				r := RepresentativeAction (permW, permG, permH);
				if r <> fail then
					# compute the corresponding matrix
					mat := List (posbasis, k -> orb[k^r]);
					r := Cinv * mat;
					Info (InfoIrredsol, 3, " conjugating matrix found");
					return r;
				fi;
			fi;
		od;
		Info (InfoIrredsol, 3, "groups are not conjugate");
		return fail;
	fi;
end);


############################################################################
##
#F  RecognitionAbsolutelyIrreducibleSolvableMatrixGroup(G, wantmat, wantgroup)
##
##  Let G be an absolutely irreducible solvable matrix group over a finite field. 
##  This function identifies a conjugate H of G group in the library. 
##
##  It returns a record which has the following entries:
##  id:                contains the id of H (and thus of G), 
##                     cf. IdAbsolutelyIrreducibleSolvableMatrixGroup
##  mat: (optional)    a matrix x such that G^x = H
##  group: (optional)  the group H
##
##  The entries mat and group are only present if the booleans wantmat and/or
##  wantgroup are true, respectively.
##
##  Note that in most cases, the function will be much slower if wantmat
##  is set to true.  
##
InstallGlobalFunction (RecognitionAbsolutelyIrreducibleSolvableMatrixGroup, 
	function (G, wantmat, wantgroup)
	
		local info;
		
		# test if G is solvable
	
		if not IsMatrixGroup (G) or not IsFinite (FieldOfMatrixGroup (G)) or not IsSolvableGroup (G) then
			Error ("G must be a solvable matrix group over a finite field");
		fi;

		if not IsBool (wantmat) or not IsBool (wantgroup) then
			Error ("wantmat and wantgroup must be boolean");
		fi;
		info := RecognitionAbsolutelyIrreducibleSolvableMatrixGroupNC (G, wantmat, wantgroup);
		if info = fail then
			Error ("This group is not within the scope of the IRREDSOL library");
		fi;
		return info;
	end);

	
############################################################################
##
#F  RecognitionAbsolutelyIrreducibleSolvableMatrixGroupNC(G, wantmat, wantgroup)
##
##  version of RecognitionAbsolutelyIrreducibleSolvableMatrixGroup which 
##  does not check its arguments and returns fail if G is not within 
##  the scope of the IRREDSOL library
##
InstallGlobalFunction(RecognitionAbsolutelyIrreducibleSolvableMatrixGroupNC, 
	function (G, wantmat, wantgroup)
		
		local inds, info, fpinfo, fp, pos, t, tinv, F, H, inds2, systems, rep, i, x;
		
		info := rec (); # set up the answer

		F := TraceField (G);
		
		# see if there is only one group of that order
		
		if not IsAvailableAbsolutelyIrreducibleSolvableGroupData (
					DegreeOfMatrixGroup (G), Size (F)) then
			return fail;
		fi;
		
		inds := SelectionAbsolutelyIrreducibleSolvableMatrixGroups (
			DegreeOfMatrixGroup (G), Size (F), [Order(G)], fail, fail);

		Info (InfoIrredsol, 2, "considering orders: ", Length (inds), 
					" groups to check");				
			
		if Length (inds) = 0 then
			Error ("panic: no group of order ", Order (G), " in the IRREDSOL library");
		elif Length (inds) > 1 then 
			# cut down candidate grops by looking at fingerprints
			if IsAvailableAbsolutelyIrreducibleSolvableGroupFingerprint(
					DegreeOfMatrixGroup (G), Size (F), Size (G)) then
				fpinfo := AbsolutelyIrreducibleSolvableGroupFingerprintData (
					DegreeOfMatrixGroup (G), Size (F), Order (G));
				
				if fpinfo = fail then
					Error ("panic: expected more than one group with that fingerprint, ",
						"but no data found in fingerprint file");
				fi;
				
				Info (InfoIrredsol, 2, "computing fingerprint");				
				fp := Filtered ([1..Length (fpinfo.elms)], i -> 
					fpinfo.elms[i] in FingerprintMatrixGroup (G));
				pos := PositionSorted (fpinfo.fps, [Order (G), fp, []]); # find fp in fps
				
				if not IsBound (fpinfo.fps[pos]) or fpinfo.fps[pos][1] <> Order (G) then 
					Error ("panic: no group of order ", Order(G), " found in he IRREDSOL library");
				fi;
				if fpinfo.fps[pos][2] <> fp then 
					Error ("panic: fingerprint not found in database");
				fi;
				
				if not IsSubset (inds, fpinfo.fps[pos][3]) then
					Error ("panic: fingerprint indices do not match the IRREDSOL library indices");
				fi;
				
				inds := fpinfo.fps[pos][3];
				Info (InfoIrredsol, 2, "considering fingerprints: ", Length (inds), 
					" groups to check");				
			else
				fpinfo := fail;
			fi;
		fi;
				
		if Length (inds) > 1 or wantmat then 
			# rewrite G over smaller field if necc.
			
			t := ConjugatingMatTraceField (G);
			if t <> One(G) then
				tinv := t^-1;
				H := GroupWithGenerators (List (GeneratorsOfGroup (G), g -> tinv * g * t));
				Assert (1, FieldOfMatrixGroup (H) = F);
				SetFieldOfMatrixGroup (H, F);
				SetTraceField (H, F);
				rep := RepresentationIsomorphism (G);
				SetRepresentationIsomorphism (H, 
						GroupHomomorphismByFunction (Source (rep), H, 
							g -> tinv * ImageElm (rep, g)*t, h -> PreImagesRepresentative (rep, t*h*tinv)));
				G := H;
				
				# we need the imprimitivity systems of G later anyway, so we can rule out groups
				# with different minimal block dimensions as well
				
				if Length (inds) > 1 then
					systems := ImprimitivitySystems (G);
					inds2 := SelectionAbsolutelyIrreducibleSolvableMatrixGroups (
						DegreeOfMatrixGroup (G), Size (F), [Order(G)], 
						[MinimalBlockDimensionOfMatrixGroup (G)], fail);
					inds := Intersection (inds, inds2);
				fi;
				Info (InfoIrredsol, 2, "considering block dimensions: ", Length (inds), 
					" groups to check");				
			fi;
			
			# find possible groups in the library
						
			for i in [1..Length(inds)-1] do 
				H := AbsolutelyIrreducibleSolvableMatrixGroup (DegreeOfMatrixGroup (G), Size (F), inds[i]);

				if fpinfo = fail then # compare fingerprints now
					Info (InfoIrredsol, 3, "comparing fingerprints");				
					if FingerprintMatrixGroup (G) <> FingerprintMatrixGroup (H) then
						Info (InfoIrredsol, 3, "fingerprint different from id ", 
							IdAbsolutelyIrreducibleSolvableMatrixGroup (H));
						continue;
					fi;
				fi;

				x := ConjugatingMatImprimitiveOrFail (G, H, 
					MinimalBlockDimensionOfMatrixGroup (G), F);
					
				if x = fail then
					Info (InfoIrredsol, 3, "group does not have id ", IdAbsolutelyIrreducibleSolvableMatrixGroup (H));
				else
					Info (InfoIrredsol, 3, "group has id ", IdAbsolutelyIrreducibleSolvableMatrixGroup (H));
					Assert (1, G^x = H);
					info.id := [DegreeOfMatrixGroup (G), Size (F), inds[i]];
					if wantgroup then
						info.group := H;
					fi;
					if wantmat then
						info.mat := t*x;
					fi;
					Info (InfoIrredsol, 1, "group id is ", info.id);
					return info;
				fi;
			od;
		fi;
		
		# we are down to the last group - this must be it
		
		i := inds[Length (inds)];
		info.id := [DegreeOfMatrixGroup (G), Size (F), i];
		Info (InfoIrredsol, 1, "group id is ", info.id);
		if not wantgroup and not wantmat then
			return info;
		fi;
		H := AbsolutelyIrreducibleSolvableMatrixGroup (DegreeOfMatrixGroup (G), Size (F), i);
		if wantgroup then
			info.group := H;
		fi;
		if wantmat then
			x := ConjugatingMatImprimitiveOrFail (G, H, 
				MinimalBlockDimensionOfMatrixGroup (G), F);
			if x = fail then
				Error ("panic: group not found in database");
			fi;
			info.mat := t*x;
		fi;
		return info;
		
	end);


	
############################################################################
##
#F  RecognitionIrreducibleSolvableMatrixGroup(G, wantmat, wantgroup)
##
##  Let G be an irreducible solvable matrix group over a finite field. 
##  This function identifies a conjugate H of G group in the library. 
##
##  It returns a record which has the following entries:
##  id:                contains the id of H (and thus of G), 
##                     cf. IdIrreducibleSolvableMatrixGroup
##  mat: (optional)    a matrix x such that G^x = H
##  group: (optional)  the group H
##
##  The entries mat and group are only present if the booleans wantmat and/or
##  wantgroup are true, respectively.
##
##  Currently, wantmat may only be true if G is absolutely irreducible.
##
##  Note that in most cases, the function will be much slower if wantmat
##  is set to true.  
##
InstallGlobalFunction (RecognitionIrreducibleSolvableMatrixGroup, 
	function (G, wantmat, wantgroup)
	
		local info;
		
		# test if G is solvable
	
		if not IsMatrixGroup (G) or not IsFinite (FieldOfMatrixGroup (G)) or not IsSolvableGroup (G) then
			Error ("G must be a solvable matrix group over a finite field");
		fi;

		if not IsBool (wantmat) or not IsBool (wantgroup) then
			Error ("wantmat and wantgroup must be boolean");
		fi;
		info := RecognitionIrreducibleSolvableMatrixGroupNC (G, wantmat, wantgroup);
		if info = fail then
			Error ("This group is not within the scope of the IRREDSOL library");
		fi;
		return info;
	end);

	
############################################################################
##
#F  RecognitionIrreducibleSolvableMatrixGroupNC(G, wantmat, wantgroup)
##
##  version of RecognitionIrreducibleSolvableMatrixGroup which does not check
##  its arguments and returns fail if G is not within the scope of the 
##  IRREDSOL library
##
InstallGlobalFunction (RecognitionIrreducibleSolvableMatrixGroupNC, 
	function (G, wantmat, wantgroup)

		local module, info, newinfo, basis, rep, H, d, e, q;
		
		# reduce to the absolutely irreducible case
		
		module := GModuleByMats (GeneratorsOfGroup (G), FieldOfMatrixGroup (G));
		
		if not MTX.IsIrreducible (module) then
			Error ("G must be irreducible over FieldOfMatrixGroup (G)");
		elif MTX.IsAbsolutelyIrreducible (module) then
			Info (InfoIrredsol, 2, "group is absolutely irreducible");
			info := RecognitionAbsolutelyIrreducibleSolvableMatrixGroupNC (G, wantmat, wantgroup);
			if info = fail then
				return fail;
			else
				newinfo := rec (id := [DegreeOfMatrixGroup (G), Size (TraceField(G)), 1, info.id[3]]);
				if wantgroup then
					newinfo.group := info.group;
				fi;
				if wantmat then
					newinfo.mat := info.mat;
				fi;
			fi;
		else
			if wantmat then
				Error ("Sorry, constructive recognition (wantmat = true) is not yet impelemented \
					for irreducible but not absolutely irreducible groups");
			fi;
			Info (InfoIrredsol, 2, "reducing to the absolutely irreducible case");
			module := GModuleByMats (GeneratorsOfGroup (G), GF(Characteristic (G)^MTX.DegreeSplittingField (module)));
			repeat
				basis := MTX.ProperSubmoduleBasis (module);
				module := MTX.InducedActionSubmodule (module, basis);
			until MTX.IsIrreducible (module);
			Assert (1, MTX.IsAbsolutelyIrreducible (module));
			rep := RepresentationIsomorphism (G);
			H := Group (MTX.Generators (module));
			SetIsAbsolutelyIrreducible (H, true);
			SetIsSolvableGroup (H, true);
			SetSize (H, Size (G));
			e := LogInt (Size (TraceField (H)), Characteristic (H));
			d := DegreeOfMatrixGroup (G)/MTX.Dimension (module);
			Assert (1, e mod d = 0);
			rep := GroupGeneralMappingByImages (Source (rep), H, 
					List (GeneratorsOfGroup (G), g -> PreImagesRepresentative (rep, g)),
					MTX.Generators (module));
			SetIsGroupHomomorphism (rep, true);
			SetIsBijective (rep, true);
			info := RecognitionAbsolutelyIrreducibleSolvableMatrixGroupNC (H, wantmat, false);
			if info = fail then 
				return fail;
			fi;
			# translate results back
			
			q := Characteristic(H)^(e/d);
			SetTraceField (G, GF(q));
			Assert (1, Size (TraceField (G))^d = info.id[2]);
			newinfo := rec (
				id := CanonicalIndexIrreducibleSolvableMatrixGroup (
					DegreeOfMatrixGroup (G), Size (TraceField(G)), d, info.id[3]));
			if wantgroup then
				newinfo.group := 
					IrreducibleSolvableMatrixGroup (DegreeOfMatrixGroup (G), q, d, info.id[3]);
			fi;
			if wantmat then
				# rewrite info.group over FieldOfMatrixGroup (G),
				# compute minimal submodules for that group (there is one of each isomorphism type), 
				# compute isomorphisms to minimal submodules for G
				# construct conjugating matrices from these isomorphisms
				# for this to work, mapping generators of info.group to the group over the subfield
				# must be a group isomorphism
				# we can force this by creating a new group over the smaller field, but then we don't
				# get the group produced by IrreducibleSolvableMatrixGroup,
				# or we have to rely on IrreducibleSolvableMatrixGroup using the same generators
			fi;
		fi;
		Info (InfoIrredsol, 1, "group is ", newinfo.id);
		return newinfo;
	end);


############################################################################
##
#M  IdIrreducibleSolvableMatrixGroup(<G>)
##
##  see the IRREDSOL manual
##  
InstallMethod (IdIrreducibleSolvableMatrixGroup, 
	"for irreducible solvable matrix group over finite field", true,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl) 
		and IsIrreducibleMatrixGroup and IsSolvableGroup], 0,

	function (G)
		
		local info;
		
		info := RecognitionIrreducibleSolvableMatrixGroupNC (G, false, false);
		if info = fail then
			Error ("group is beyond the scope of the IRREDSOL library");
		else
			return info.id;
		fi;
	end);
	
	
RedispatchOnCondition(IdIrreducibleSolvableMatrixGroup, true,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl)],
	[IsIrreducibleMatrixGroup and IsSolvableGroup], 0);


############################################################################
##
#M  IdAbsolutelyIrreducibleSolvableMatrixGroup(<G>)
##
##  see the IRREDSOL manual
##  
InstallMethod (IdAbsolutelyIrreducibleSolvableMatrixGroup, 
	"for absolutely irreducible solvable matrix group over finite field", true,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl) 
		and HasIsAbsolutelyIrreducibleMatrixGroup and HasIsSolvableGroup], 0,

	function (G)
		local info;
		info := RecognitionAbsolutelyIrreducibleSolvableMatrixGroupNC (G, false, false);
		if info = fail then
			Error ("group is beyond the scope of the IRREDSOL library");
		else
			return info.id;
		fi;
	end);


RedispatchOnCondition(IdAbsolutelyIrreducibleSolvableMatrixGroup, true,
	[IsMatrixGroup and CategoryCollections (IsFFECollColl)],
	[IsAbsolutelyIrreducibleMatrixGroup and IsSolvableGroup], 0);


############################################################################
##
#V  MS_GROUP_INDEX
##
##  translation table for Mark Short's irredsol library
##
InstallValue (MS_GROUP_INDEX,
[ , 
  [ , [ [ 2, 1 ], [ 1, 1 ] ], [ [ 2, 1 ], [ 1, 1 ], [ 1, 5 ], [ 2, 2 ], [ 1, 
              4 ], [ 1, 3 ], [ 1, 2 ] ],, 
      [ [ 2, 1 ], [ 1, 11 ], [ 2, 2 ], [ 1, 5 ], [ 1, 4 ], [ 2, 3 ], 
          [ 1, 8 ], [ 1, 9 ], [ 2, 4 ], [ 1, 3 ], [ 1, 2 ], [ 1, 10 ], 
          [ 1, 7 ], [ 2, 5 ], [ 1, 14 ], [ 1, 1 ], [ 1, 6 ], [ 1, 13 ], 
          [ 1, 12 ] ],, 
      [ [ 2, 1 ], [ 1, 7 ], [ 1, 10 ], [ 1, 18 ], [ 2, 2 ], [ 1, 8 ], 
          [ 1, 6 ], [ 2, 3 ], [ 1, 14 ], [ 2, 4 ], [ 1, 16 ], [ 1, 4 ], 
          [ 1, 9 ], [ 1, 5 ], [ 2, 5 ], [ 1, 17 ], [ 1, 21 ], [ 1, 22 ], 
          [ 1, 13 ], [ 1, 3 ], [ 1, 2 ], [ 1, 15 ], [ 2, 6 ], [ 1, 12 ], 
          [ 1, 23 ], [ 1, 1 ], [ 1, 20 ], [ 1, 11 ], [ 1, 19 ] ],,,, 
      [ [ 2, 1 ], [ 2, 2 ], [ 2, 3 ], [ 1, 21 ], [ 1, 10 ], [ 2, 4 ], 
          [ 1, 26 ], [ 1, 6 ], [ 2, 5 ], [ 1, 20 ], [ 1, 17 ], [ 2, 6 ], 
          [ 1, 25 ], [ 1, 5 ], [ 1, 7 ], [ 2, 7 ], [ 1, 14 ], [ 2, 8 ], 
          [ 1, 16 ], [ 1, 29 ], [ 2, 9 ], [ 1, 22 ], [ 1, 9 ], [ 1, 8 ], 
          [ 1, 24 ], [ 2, 10 ], [ 1, 13 ], [ 1, 30 ], [ 1, 4 ], [ 1, 18 ], 
          [ 1, 19 ], [ 2, 11 ], [ 1, 23 ], [ 1, 2 ], [ 1, 3 ], [ 1, 12 ], 
          [ 2, 12 ], [ 1, 15 ], [ 1, 28 ], [ 1, 1 ], [ 1, 11 ], [ 1, 27 ] ],, 
      [ [ 1, 26 ], [ 2, 1 ], [ 1, 21 ], [ 1, 23 ], [ 2, 2 ], [ 1, 25 ], 
          [ 1, 27 ], [ 2, 3 ], [ 1, 43 ], [ 1, 18 ], [ 1, 29 ], [ 1, 11 ], 
          [ 2, 4 ], [ 1, 14 ], [ 1, 20 ], [ 1, 22 ], [ 1, 13 ], [ 1, 19 ], 
          [ 1, 30 ], [ 2, 5 ], [ 1, 51 ], [ 1, 50 ], [ 2, 6 ], [ 1, 40 ], 
          [ 1, 38 ], [ 1, 32 ], [ 1, 8 ], [ 1, 9 ], [ 2, 7 ], [ 1, 44 ], 
          [ 1, 17 ], [ 1, 28 ], [ 1, 15 ], [ 1, 12 ], [ 1, 49 ], [ 1, 48 ], 
          [ 2, 8 ], [ 1, 36 ], [ 1, 42 ], [ 1, 5 ], [ 1, 10 ], [ 1, 7 ], 
          [ 1, 6 ], [ 1, 47 ], [ 1, 39 ], [ 1, 35 ], [ 2, 9 ], [ 1, 31 ], 
          [ 1, 16 ], [ 1, 52 ], [ 1, 37 ], [ 1, 3 ], [ 1, 2 ], [ 1, 46 ], 
          [ 2, 10 ], [ 1, 34 ], [ 1, 41 ], [ 1, 1 ], [ 1, 45 ], [ 1, 33 ], 
          [ 1, 24 ], [ 1, 4 ] ] ], 
  [ , [ [ 3, 1 ], [ 1, 1 ] ], [ [ 1, 5 ], [ 3, 1 ], [ 1, 4 ], [ 1, 3 ], 
          [ 1, 2 ], [ 3, 2 ], [ 1, 7 ], [ 1, 1 ], [ 1, 6 ] ],, 
      [ [ 1, 12 ], [ 1, 15 ], [ 1, 16 ], [ 1, 6 ], [ 3, 1 ], [ 1, 3 ], 
          [ 1, 10 ], [ 1, 11 ], [ 1, 9 ], [ 3, 2 ], [ 1, 19 ], [ 1, 4 ], 
          [ 1, 5 ], [ 1, 14 ], [ 1, 13 ], [ 3, 3 ], [ 1, 18 ], [ 1, 8 ], 
          [ 1, 2 ], [ 1, 7 ], [ 1, 17 ], [ 1, 1 ] ] ], 
  [ , [ [ 4, 1 ], [ 2, 3 ], [ 4, 2 ], [ 2, 1 ], [ 1, 5 ], [ 2, 2 ], [ 1, 2 ], 
          [ 1, 3 ], [ 1, 4 ], [ 1, 1 ] ], 
      [ [ 4, 1 ], [ 2, 20 ], [ 4, 2 ], [ 2, 11 ], [ 2, 9 ], [ 2, 8 ], 
          [ 4, 3 ], [ 2, 12 ], [ 2, 16 ], [ 2, 17 ], [ 4, 4 ], [ 1, 73 ], 
          [ 1, 11 ], [ 1, 10 ], [ 2, 4 ], [ 1, 9 ], [ 1, 12 ], [ 1, 34 ], 
          [ 1, 32 ], [ 2, 7 ], [ 2, 6 ], [ 1, 33 ], [ 2, 5 ], [ 2, 10 ], 
          [ 4, 5 ], [ 1, 71 ], [ 2, 18 ], [ 2, 15 ], [ 1, 72 ], [ 2, 24 ], 
          [ 2, 23 ], [ 1, 13 ], [ 1, 14 ], [ 1, 7 ], [ 1, 6 ], [ 2, 3 ], 
          [ 1, 36 ], [ 1, 41 ], [ 2, 2 ], [ 1, 27 ], [ 1, 42 ], [ 1, 26 ], 
          [ 1, 35 ], [ 2, 19 ], [ 2, 14 ], [ 1, 69 ], [ 4, 6 ], [ 1, 70 ], 
          [ 1, 5 ], [ 1, 49 ], [ 1, 38 ], [ 1, 37 ], [ 2, 22 ], [ 2, 25 ], 
          [ 1, 57 ], [ 1, 65 ], [ 2, 26 ], [ 1, 8 ], [ 1, 28 ], [ 1, 39 ], 
          [ 1, 30 ], [ 1, 40 ], [ 1, 29 ], [ 1, 44 ], [ 1, 43 ], [ 1, 21 ], 
          [ 2, 1 ], [ 1, 67 ], [ 1, 68 ], [ 2, 13 ], [ 1, 76 ], [ 1, 3 ], 
          [ 1, 4 ], [ 1, 2 ], [ 1, 31 ], [ 1, 59 ], [ 1, 63 ], [ 1, 64 ], 
          [ 1, 62 ], [ 2, 21 ], [ 1, 61 ], [ 1, 19 ], [ 1, 45 ], [ 1, 24 ], 
          [ 1, 48 ], [ 1, 46 ], [ 1, 47 ], [ 1, 58 ], [ 1, 66 ], [ 1, 75 ], 
          [ 1, 1 ], [ 1, 22 ], [ 1, 23 ], [ 1, 60 ], [ 1, 25 ], [ 1, 54 ], 
          [ 1, 55 ], [ 1, 56 ], [ 1, 74 ], [ 1, 20 ], [ 1, 18 ], [ 1, 52 ], 
          [ 1, 51 ], [ 1, 53 ], [ 1, 17 ], [ 1, 16 ], [ 1, 50 ], [ 1, 15 ] ] ]
    , 
  [ , [ [ 5, 1 ], [ 1, 1 ] ], [ [ 5, 1 ], [ 5, 2 ], [ 1, 11 ], [ 1, 4 ], [ 1, 
              12 ], [ 5, 3 ], [ 1, 3 ], [ 1, 5 ], [ 1, 6 ], [ 5, 4 ], 
          [ 1, 7 ], [ 1, 2 ], [ 1, 8 ], [ 1, 10 ], [ 1, 1 ], [ 1, 9 ] ] ], 
  [ , [ [ 6, 1 ], [ 3, 2 ], [ 3, 4 ], [ 6, 2 ], [ 2, 4 ], [ 2, 3 ], 
          [ 1, 15 ], [ 3, 5 ], [ 2, 5 ], [ 1, 9 ], [ 1, 10 ], [ 6, 3 ], 
          [ 2, 7 ], [ 2, 8 ], [ 2, 2 ], [ 3, 1 ], [ 1, 11 ], [ 2, 11 ], 
          [ 1, 16 ], [ 3, 3 ], [ 2, 1 ], [ 1, 6 ], [ 1, 7 ], [ 2, 6 ], 
          [ 2, 12 ], [ 1, 21 ], [ 1, 20 ], [ 1, 14 ], [ 1, 13 ], [ 1, 8 ], 
          [ 1, 5 ], [ 1, 17 ], [ 1, 19 ], [ 1, 3 ], [ 1, 4 ], [ 1, 2 ], 
          [ 2, 10 ], [ 1, 12 ], [ 1, 1 ], [ 1, 18 ] ] ], 
  [ , [ [ 7, 1 ], [ 1, 1 ] ] ] ]
);

############################################################################
##
#F  IdIrreducibleSolvableMatrixGroupIndexMS(<n>, <p>, <k>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IdIrreducibleSolvableMatrixGroupIndexMS,
	function (n, p, k)
		if IsInt (n) and n > 1 and IsPosInt (p) and IsPrimeInt (p) 
				and IsPosInt (k) then
			if IsBound (MS_GROUP_INDEX[n]) then
				if IsBound (MS_GROUP_INDEX[n][p]) then
					if IsBound (MS_GROUP_INDEX[n][p][k]) then
						return Concatenation ([n, p], MS_GROUP_INDEX[n][p][k]);
					else
						Error ("k is out of range");
					fi;
				else
					Error ("p is out of range");
				fi;
			else
				Error ("n is out of range");
			fi;	
		else
			Error ("n, p, k must be integers, n > 1, and p must be a prime");
		fi;
	end);


############################################################################
##
#F  IndexMSIdIrreducibleSolvableMatrixGroup(<n>, <q>, <d>, <k>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IndexMSIdIrreducibleSolvableMatrixGroup,
	function (n, p, d, k)
		local pos;
		
		if IsInt (n) and n > 1 and IsPosInt (p) and IsPrimeInt (p) 
				and IsPosInt (k) and IsPosInt (d) and n mod d = 0 then
			if IsBound (MS_GROUP_INDEX[n]) then
				if IsBound (MS_GROUP_INDEX[n][p]) then
					pos := Position (MS_GROUP_INDEX[n][p], [d, k]);				
					if pos <> fail then
						return [n, p, pos];
					else
						Error ("inadmissible value for k");
					fi;
				else
					Error ("p is out of range");
				fi;
			else
				Error ("n is out of range");
			fi;	
		else
			Error ("n, p, d, k must be integers, n > 1, p must be a prime, and d must divide n");
		fi;
	end);


############################################################################
##
#E
##
