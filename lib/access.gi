############################################################################
##
##  access.gi                    IRREDSOL                 Burkhard Hoefling
##
##  @(#)$Id$
##
##  Copyright (C) 2003-2005 by Burkhard Hoefling, 
##  Institut fuer Geometrie, Algebra und Diskrete Mathematik
##  Technische Universitaet Braunschweig, Germany
##


############################################################################
##
#F  IndicesAbsolutelyIrreducibleSolvableMatrixGroups(<n>, <q>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IndicesAbsolutelyIrreducibleSolvableMatrixGroups, 
	function ( n, q )
		
		local range, data, inds;
		
		if not IsPosInt (n) or not IsPPowerInt (q)  then
			Error ("n and q must be positive integers and q must be a prime power");
		fi;
		LoadAbsolutelyIrreducibleSolvableGroupData (n, q);
		if n = 1 then
			return [1..Length (IRREDSOL_DATA.GROUPS_DIM1 [q])];
		else
			data := IRREDSOL_DATA.GROUPS[n][q];
			inds := Filtered ([1..Length (data)], i -> IsBound (data[i]));
			MakeImmutable (inds);
			return inds;
		fi;
	end);


############################################################################
##
#F  AbsolutelyIrreducibleSolvableMatrixGroup(<n>, <q>, <k>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (AbsolutelyIrreducibleSolvableMatrixGroup, 
	function ( n, q, k )
	
		local d, C, pcgs, desc, g, gddesc, len, mat, gens, grp, pres, hom;
	
		if not IsPosInt (n) or not IsPPowerInt (q) or not IsPosInt (k) then
			Error ("n, q, k must be positive integers and q must be a prime power");
		fi;
			Info (InfoIrredsol, 1, "Constructing absolutely irreducible group with id ", 
				[n, q, k]);
		LoadAbsolutelyIrreducibleSolvableGroupData (n, q);
		
		if n = 1 then
			if not IsBound (IRREDSOL_DATA.GROUPS_DIM1[q][k]) then
				Error ("inadmissible value for k");	
			fi;
			d := IRREDSOL_DATA.GROUPS_DIM1 [q][k][1];
			
			mat := [[Z(q)^((q-1)/d)]];
			grp := GroupWithGenerators ([mat], IdentityMat(n, GF(q)));
			SetSize (grp, d);
	        SetIsCyclic (grp, true);
	        SetMinimalBlockDimensionOfMatrixGroup (grp, 1);
			SetIsMaximalAbsolutelyIrreducibleSolvableMatrixGroup (grp, d = q-1);
			
	        if d = 1 then
	        	hom := IdentityMapping (grp);
	        else
	        	C := AbelianGroup (IsPcGroup, [d]);
	        	hom := GroupHomomorphismByImagesNC (C, grp, [C.1], [mat]);
	        fi;
	        SetIsBijective (hom, true);
		else
			if not IsBound (IRREDSOL_DATA.GROUPS[n][q][k]) then
				Error ("inadmissible value for k");	
			fi;
		
		    # construct group and isomorphic pc group
	    
		    desc  := IRREDSOL_DATA.GROUPS[n][q][k];
		    gddesc := IRREDSOL_DATA.GUARDIANS[n][q][desc[1]];
			pres := gddesc[3];
		
		    pcgs := CanonicalPcgsByNumber (Pcgs (Source (pres)), desc[2]);
		    gens := List (pcgs, x -> ImageElm (pres, x));
	    	
		    grp := GroupWithGenerators (gens, IdentityMat(n, GF(q)));
		    SetSize( grp, Product (RelativeOrders (pcgs)) );
			hom := GroupHomomorphismByFunction (GroupOfPcgs (pcgs), grp, 
				x -> ImageElm (pres, x), x -> PreImagesRepresentative (pres, x));
			SetIsBijective (hom, true);
			SetMinimalBlockDimensionOfMatrixGroup (grp, gddesc[4]);
	   		SetIsMaximalAbsolutelyIrreducibleSolvableMatrixGroup (grp, 
	    		k in IRREDSOL_DATA.MAX[n][q]);
		fi;
		
	    SetIdAbsolutelyIrreducibleSolvableMatrixGroup (grp, [n, q, k]);
	    SetIdIrreducibleSolvableMatrixGroup (grp, [n, q, 1, k]);
		SetFieldOfMatrixGroup (grp, GF(q));
		SetDefaultFieldOfMatrixGroup(grp, GF(q));
	    SetTraceField (grp, GF(q));			
	    SetConjugatingMatTraceField (grp, One(grp));

	    SetRepresentationIsomorphism (grp, hom);

	    SetIsPrimitiveMatrixGroup (grp, MinimalBlockDimensionOfMatrixGroup(grp) = n);
	    
	    SetIsIrreducibleMatrixGroup (grp, true);
	    SetIsAbsolutelyIrreducibleMatrixGroup (grp, true);
	    SetIsSolvableGroup (grp, true);
	    return grp;
	end);


############################################################################
##
#F  IndicesIrreducibleSolvableMatrixGroups(<n>, <q>, <d>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IndicesIrreducibleSolvableMatrixGroups, 
	function ( n, q, d )
		
		local inds, perm, i, k, l, max;
		
		if not IsPosInt (n) or not IsPosInt (d) or not IsPosInt (q) 
				or not IsPPowerInt (q) then
			Error ("n, q, and d must be positive integers, ",
				"q must be a prime power");
		fi;
		if n mod d <> 0 then
			return [];
		fi;
		if d < n then
			inds := ShallowCopy (IndicesAbsolutelyIrreducibleSolvableMatrixGroups (n/d, q^d));
		else
			LoadAbsolutelyIrreducibleSolvableGroupData (1, q^d);
			inds := [1..Length(IRREDSOL_DATA.GROUPS_DIM1 [q^d])];
			if d > 1 then
				if IRREDSOL_DATA.GROUPS_DIM1 [q^d][1] = 1 then
					RemoveSet (inds, 1); # rewriting the trivial group over a smaller field yields a reducible group
				fi;
			fi;
		fi;
		perm := IRREDSOL_DATA.GAL_PERM[n/d][q^d]^LogInt (q, SmallestRootInt (q));
		# permutation of a generator of Gal (GF(q^d)/GF(q)) on inds

		if perm <> () then
			i := PositionSorted (inds, SmallestMovedPoint(perm));
			max := LargestMovedPoint(perm);
			while i <= Length (inds) do
				k := inds[i];
				if k > max then 
					break;
				fi;
				l := k^perm;
				while l <> k do
					RemoveSet (inds, l);
					l := l^perm;
				od;
				i := i + 1;
			od;
		fi;
		MakeImmutable (inds);
		return inds;	
	end);


############################################################################
##
#F  PermCanonicalIndexIrreducibleSolvableMatrixGroup(<n>, <q>, <d>, <k>  
##
InstallGlobalFunction (PermCanonicalIndexIrreducibleSolvableMatrixGroup, 
	function ( n, q, d, k )

		local perm, pow, l, orb, min, powmin;
		
		LoadAbsolutelyIrreducibleSolvableGroupData (n/d, q^d);
		
		perm := IRREDSOL_DATA.GAL_PERM[n/d][q^d]^LogInt (q, SmallestRootInt (q));
		
		# permutation of a generator of Gal (GF(q^d)/GF(q)) on parameters
		
		powmin := 0;
		l := k^perm; # check whether k is least in orbit
		pow := 1;
		min := k;
		orb := [k];
		while l <> k do
			Add (orb, l);
			# we have l = k^(perm^pow)
			if l < k then
				powmin := pow;
				min := l;
			fi;
			l := l^perm;
			pow := pow + 1;
		od;
		return rec (perm := perm, pow := powmin, orb := orb, min := min);
	end);
	

############################################################################
##
#F  IrreducibleSolvableMatrixGroup(<n>, <q>, <d>, <k>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IrreducibleSolvableMatrixGroup, 
	function ( n, q, d, k )
		
		local perm, l, n0, q0, p, i, bas, mat, C, gddesc, desc, pres, gens, pcgs, grp, hom;
		
		if not IsPosInt (n) or not IsPosInt (d) or not IsPosInt (q) 
				or not IsPPowerInt (q)  or not IsPosInt (k) or not n mod d = 0 then
			Error ("n, q, d, and k must be positive integers, q must be a prime power ",
				"and d must divide n");
		fi;
				
		LoadAbsolutelyIrreducibleSolvableGroupData (n/d, q^d);
		
		if d = 1 then # absolutely irreducible group case
			return AbsolutelyIrreducibleSolvableMatrixGroup (n, q, k);
		else
			# switch to larger field
			n0 := n;
			q0 := q;
			n := n0/d;
			q := q0^d;
			p := SmallestRootInt (q0);


			# compute the permutation of a generator of Gal(GF(q)/GF(q0)) 
			# on the ccls of absolutely irreducible subgroups of GL(n,q)

			perm := IRREDSOL_DATA.GAL_PERM[n][q]^LogInt (q0, p);
							
			# check if k is a valid paramter, i. e., least in orbit

			l := k^perm; 
			while l <> k do
				if l < k then
					Error ("inadmissible value for k");	
				fi;
				l := l^perm;
			od;
	
			Info (InfoIrredsol, 1, "Constructing irreducible group with id ", 
				[n0, q0, d, k]);
			
	
			bas := CanonicalBasis (AsVectorSpace (GF(q0), GF(q)));
			        # it is important to use CanonicalBasis here, in order to be sure
			        # that the result is the same when called multiple times
		
			LoadAbsolutelyIrreducibleSolvableGroupData (n, q);

			if n = 1 then
				if not IsBound (IRREDSOL_DATA.GROUPS_DIM1[q][k]) then
					Error ("inadmissible value for k");	
				fi;
				d := IRREDSOL_DATA.GROUPS_DIM1 [q][k][1];
				
				mat := BlownUpMat (bas, [[Z(q)^((q-1)/d)]]);
				grp := GroupWithGenerators ([mat], IdentityMat(n0, GF(q0)));
				SetSize (grp, d);
				SetIsCyclic (grp, true);
				i := PositionSet (DivisorsInt (LogInt (q, p)), LogInt (q0, p));
				SetMinimalBlockDimensionOfMatrixGroup (grp, IRREDSOL_DATA.GROUPS_DIM1[q][k][2][i]);
				
				if d = 1 then
					hom := IdentityMapping (grp);
				else
					C := AbelianGroup (IsPcGroup, [d]);
					hom := GroupHomomorphismByImagesNC (C, grp, [C.1], [mat]);
				fi;
				SetIsBijective (hom, true);
			else
				if not IsBound (IRREDSOL_DATA.GROUPS[n][q][k]) then
					Error ("inadmissible value for k");	
				fi;
			
				# construct group and isomorphic pc group
			
				desc  := IRREDSOL_DATA.GROUPS[n][q][k];
				pres := IRREDSOL_DATA.GUARDIANS[n][q][desc[1]][3]; # presentation homomorphism
			
				pcgs := CanonicalPcgsByNumber (Pcgs (Source (pres)), desc[2]);
				gens := List (pcgs, x -> BlownUpMat (bas, ImageElm (pres, x)));
				
				grp := GroupWithGenerators (gens, IdentityMat(n0, GF(q0)));
				SetSize( grp, Product (RelativeOrders (pcgs)) );
				hom := GroupHomomorphismByImagesNC (GroupOfPcgs (pcgs), grp, 
					pcgs, gens);
				SetIsBijective (hom, true);
				
				# look up minimal block dimension
	
				i := PositionSet (DivisorsInt (LogInt (q, p)), LogInt (q0, p));
				SetMinimalBlockDimensionOfMatrixGroup (grp, IRREDSOL_DATA.GROUPS[n][q][k][3][i]);
			fi;
		
	    	SetIdIrreducibleSolvableMatrixGroup (grp, [n0, q0, d, k]);
			SetFieldOfMatrixGroup (grp, GF(q0));
			SetDefaultFieldOfMatrixGroup(grp, GF(q0));
		    SetTraceField (grp, GF(q0));			
		    SetConjugatingMatTraceField (grp, One(grp));
		    SetRepresentationIsomorphism (grp, hom);
		    SetIsPrimitiveMatrixGroup (grp, MinimalBlockDimensionOfMatrixGroup(grp) = n);
		    SetIsIrreducibleMatrixGroup (grp, true);
		    SetIsSolvableGroup (grp, true);
			return grp;
		fi;
	end);
		
		

############################################################################
##
#F  IndicesMaximalAbsolutelyIrreducibleSolvableMatrixGroups(<n>, <q>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IndicesMaximalAbsolutelyIrreducibleSolvableMatrixGroups,
	function ( n, q )
	
		if not IsPosInt (n) or not IsPPowerInt (q)  then
			Error ("n and q must be positive integers and q must be a prime power");
		fi;
		LoadAbsolutelyIrreducibleSolvableGroupData (n, q);
		if n = 1 then
			return Immutable ([Length (IRREDSOL_DATA.GROUPS_DIM1 [q])]);
		else
			return IRREDSOL_DATA.MAX[n][q];
		fi;
	end);


############################################################################
##
#E
##
