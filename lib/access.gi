############################################################################
##
##  access.gi                    IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#F  IndicesAbsolutelyIrreducibleSolvableMatrixGroups(<n>, <q>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IndicesAbsolutelyIrreducibleSolvableMatrixGroups, 
	function ( n, q )
		
		local range, data;
		
		if not IsPosInt (n) or not IsPrimePowerInt (q)  then
			Error ("n and q must be positive integers and q must be a prime power");
		fi;
		LoadAbsolutelyIrreducibleSolvableGroupData (n, q);
		if n = 1 then
			return [1..Length (DIVISORS_FIELD_ORDER [q])];
		else
			data := ABS_IRRED_DATA[n][q];
			return Filtered ([1..Length (data)], i -> IsBound (data[i]));
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
	
		local d, C, pcgs, desc, g, guardianDesc, gdgens, 
			len, idmat, mat, gens, grp, pres, hom;
	
		if not IsPosInt (n) or not IsPrimePowerInt (q) or not IsPosInt (k) then
			Error ("n, q, k must be positive integers and q must be a prime power");
		fi;
			Info (InfoIrredsol, 1, "Constructing absolutely irreducible group with id ", 
				[n, q, k]);
		LoadAbsolutelyIrreducibleSolvableGroupData (n, q);
		idmat := Immutable (IdentityMat(n, GF(q)));
		if n = 1 then
			if not IsBound (DIVISORS_FIELD_ORDER [q][k]) then
				Error ("inadmissible value for k");	
			fi;
			d := DIVISORS_FIELD_ORDER [q][k];
			mat := Immutable ([[Z(q)^((q-1)/d)]]);
			ConvertToMatrixRep (mat, q);
			grp := GroupByGenerators ([mat], idmat);
	    	SetIdAbsolutelyIrreducibleSolvableMatrixGroup (grp, [n, q, k]);
	    	SetIdIrreducibleSolvableMatrixGroup (grp, [n, q, 1, k]);
			SetSize (grp, d);
			SetFieldOfMatrixGroup (grp, GF(q));
			SetTraceField (grp, GF(q));
	        SetIsPrimitiveMatrixGroup (grp, true);
	        SetMinimalBlockDimensionOfMatrixGroup (grp, 1);
	        SetIsIrreducibleMatrixGroup (grp, true);
	        SetIsAbsolutelyIrreducibleMatrixGroup (grp, true);
	        SetIsCyclic (grp, true);
	        C := CyclicGroup (IsPcGroup, d);
	        pcgs := Pcgs (C);
	        gens := [];
	        for d in RelativeOrders (pcgs) do
	        	Add (gens, mat);
	        	mat := mat^d;
	        od;
	        hom := GroupHomomorphismByImagesNC (C, grp, Pcgs (C), gens);
	        SetIsBijective (hom, true);
	        SetRepresentationIsomorphism (grp, hom);
	     	return grp;
		fi;
	    
		if not IsBound (ABS_IRRED_DATA[n][q][k]) then
			Error ("inadmissible value for k");	
		fi;
		
	    # construct group and isomorphic pc group
	    
	    desc  := ABS_IRRED_DATA[n][q][k];
	    guardianDesc := GUARDIAN_ABS_IRRED_DATA[n][q][desc[ABS_IRRED_GUARDIAN_NUMBER]];
	    gdgens := guardianDesc[GUARDIAN_MAT_PCGS];
		pres := guardianDesc[GUARDIAN_PC_PRESENTATION];

	    gens := [];
	    pcgs := CanonicalPcgsByNumber (Pcgs (Source (pres)), 
	    	desc[ABS_IRRED_CANONICAL_PCGS]);
	    gens := List (pcgs, x -> ImageElm (pres, x));
	    	
	    grp := GroupWithGenerators (gens);
	    SetSize( grp, Product (RelativeOrders (pcgs)) );
	    SetIdAbsolutelyIrreducibleSolvableMatrixGroup (grp, [n, q, k]);
	    SetIdIrreducibleSolvableMatrixGroup (grp, [n, q, 1, k]);
		SetFieldOfMatrixGroup (grp, GF(q));
	    SetTraceField (grp, GF(q));			
	    SetConjugatingMatTraceField (grp, One(grp));

		hom := GroupHomomorphismByFunction (GroupOfPcgs (pcgs), grp, 
			x -> ImageElm (pres, x), x -> PreImagesRepresentative (pres, x));
		
	    SetRepresentationIsomorphism (grp, hom);

		SetMinimalBlockDimensionOfMatrixGroup (grp, guardianDesc[GUARDIAN_MIN_BLOCKDIM]);
	    SetIsPrimitiveMatrixGroup (grp, MinimalBlockDimensionOfMatrixGroup(grp) = n);
	    
	    SetIsIrreducibleMatrixGroup (grp, true);
	    SetIsAbsolutelyIrreducibleMatrixGroup (grp, true);
	    SetIsMaximalAbsolutelyIrreducibleSolvableMatrixGroup (grp, 
	    	Order (grp) = Order (Source (pres)));
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
		
		local inds, perm, i, k, l;
		
		if not IsPosInt (n) or not IsPosInt (d) or not IsPosInt (q) 
				or not IsPrimePowerInt (q) then
			Error ("n, q, and d must be positive integers, ",
				"q must be a prime power");
		fi;
		if n mod d <> 0 then
			return [];
		fi;
		
		inds := IndicesAbsolutelyIrreducibleSolvableMatrixGroups (n/d, q^d);
		perm := ABS_IRRED_GAL_PERM[n/d][q^d] ^LogInt (q, SmallestRootInt (q));
		# permutation of a generator of Gal (GF(q^d)/GF(q)) on inds
		i := 1;
		while i <= Length (inds) do
			k := inds[i];
			l := k^perm;
			while l <> k do
				if l < k then
					Error ("panic: got wrong orbit representative");
				fi;
				RemoveSet (inds, l);
				l := l^perm;
			od;
			i := i + 1;
		od;
		return inds;	
	end);

############################################################################
##
#F  CanonicalIndexIrreducibleSolvableMatrixGroup(<n>, <q>, <d>, <k>)
##
##  computes a valid id for the group obtained by
##  rewriting AbsolutelyIrreducibleSolvableMatrixGroup (n/d, q^d, k)
##  as a matrix group over F_p^n. The result is meaningless if
##  AbsolutelyIrreducibleSolvableMatrixGroup (n/d, q^d, k) does not exist
##  
##
InstallGlobalFunction (CanonicalIndexIrreducibleSolvableMatrixGroup, 
	function ( n, q, d, k )

		local perm, l, m;
		
		LoadAbsolutelyIrreducibleSolvableGroupData (n/d, q^d);
		
		perm := ABS_IRRED_GAL_PERM[n/d][q^d]^LogInt (q, SmallestRootInt (q));
		
		# permutation of a generator of Gal (GF(q^d)/GF(q)) on parameters
		
		m := k;
		l := k^perm; # check whether k is least in orbit
		while l <> k do
			if l < k then
				m := l;
			fi;
			l := l^perm;
		od;
		return [n, q, d, m];
	end);
	

############################################################################
##
#F  IrreducibleSolvableMatrixGroup(<n>, <q>, <d>, <k>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IrreducibleSolvableMatrixGroup, 
	function ( n, q, d, k )
		
		local perm, l, repG, gensG, repH, gensH, G, H;
		
		if not IsPosInt (n) or not IsPosInt (d) or not IsPosInt (q) 
				or not IsPrimePowerInt (q)  or not IsPosInt (k) or not n mod d = 0 then
			Error ("n, q, d, and k must be positive integers, q must be a prime power ",
				"and d must divide n");
		fi;
				
		LoadAbsolutelyIrreducibleSolvableGroupData (n/d, q^d);
		
		perm := ABS_IRRED_GAL_PERM[n/d][q^d]^LogInt (q, SmallestRootInt (q));
		
		# permutation of a generator of Gal (GF(q^d)/GF(q)) on parameters
			
		l := k^perm; # check whether k is least in orbit
		while l <> k do
			if l < k then
				Error ("inadmissible value for k");	
			fi;
			l := l^perm;
		od;

		H := AbsolutelyIrreducibleSolvableMatrixGroup (n/d, q^d, k);
		
		if d = 1 then 
			return H;
		else
			Info (InfoIrredsol, 1, "Constructing irreducible group with id ", 
				[n, q, d, k]);
			repH := RepresentationIsomorphism (H);
			gensH := List (Pcgs (Source (repH)), x -> ImageElm (repH, x));
			gensG := AsMatrixListOverSubield (gensH, d, q);
			G := GroupWithGenerators (gensG);
			SetIsIrreducibleMatrixGroup (G, true);
			SetIsAbsolutelyIrreducibleMatrixGroup (G, false);
			SetIsMaximalAbsolutelyIrreducibleSolvableMatrixGroup (G, false);
			SetIsSolvableGroup (G, true);
			if MinimalBlockDimensionOfMatrixGroup (H) < DegreeOfMatrixGroup (H) then
				SetIsPrimitiveMatrixGroup (G, false);
			fi;
			SetSize( G, Size (Source (repH)) );
			SetIdIrreducibleSolvableMatrixGroup (G, [n, q, d, k]);
			SetFieldOfMatrixGroup (G, GF(q));
			SetTraceField (G, GF(q));
			SetConjugatingMatTraceField (G, One(G));
		
			repG := GroupHomomorphismByImagesNC (Source(repH), G, 
				Pcgs (Source (repH)), gensG);
			SetIsBijective (repG, true);
			SetRepresentationIsomorphism (G, repG);
			return G;
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
	
		if not IsPosInt (n) or not IsPrimePowerInt (q)  then
			Error ("n and q must be positive integers and q must be a prime power");
		fi;
		LoadAbsolutelyIrreducibleSolvableGroupData (n, q);
		if n = 1 then
			return [Length (DIVISORS_FIELD_ORDER [q])];
		else
			return MAX_ABS_IRRED_DATA[n][q];
		fi;
	end);


############################################################################
##
#E
##
