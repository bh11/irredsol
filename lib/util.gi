############################################################################
##
##  util.gi                      IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#I  TestFlag(<n>, <i>)
##
##  tests if the i-th bit is set in binary representation the nonnegative 
##  integer n
##  
InstallGlobalFunction (TestFlag,
	function (n, i)
		return QuoInt (n, 2^i) mod 2 = 1;
	end);
	

############################################################################
##
#F  NumberOfFFPolynomial(<p>, <q>)
##
##  computes a number characterising the polynomial p.
##  The polynomial p wmust be over GF(q)
##  
InstallGlobalFunction (NumberOfFFPolynomial, function (p, q)

	local cf, z, sum, c;
	
	cf := CoefficientsOfUnivariatePolynomial (p);
	z := Z(q);
	sum := 0;
	for c in cf do
		if c = 0*z then
			sum := sum * q;
		else 
			sum := sum * q + LogFFE (c, z) + 1;
		fi;
	od;
	return sum;
end);


############################################################################
##
#F  FFMatrixByNumber(n, d, q)
##
##  computes a d x d matrix over GF(q) represented by the integer n
##  
InstallGlobalFunction (FFMatrixByNumber,
	function (n, d, q)
	
		local z, m, i, j, k;
		
		z := Z(q);
		m := NullMat (d,d, GF(q));
	
		for i in [d, d-1..1] do
			for j in [d, d-1..1] do
				k := RemInt (n, q);
				n := QuoInt (n, q);
				if k > 0 then
					m[i][j] := z^(k-1);
				fi;
			od;
		od;
		ConvertToMatrixRep (m, q);
		return m;
	end);
	
	
############################################################################
##
#F  CanonicalPcgsByNumber(<pcgs>, <n>)
##
##  computes the canonical pcgs wrt. pcgs represented by the integer n
##  
InstallGlobalFunction (CanonicalPcgsByNumber,
	function (pcgs, n)
	
		local gens, cpcgs;
		
		gens := List (ExponentsCanonicalPcgsByNumber (RelativeOrders (pcgs), n), 
			exp -> PcElementByExponents (pcgs, exp));
		cpcgs := InducedPcgsByPcSequenceNC (pcgs, gens);
		SetIsCanonicalPcgs (cpcgs, true);
		return cpcgs;
	end);


############################################################################
##
#F  OrderGroupByCanonicalPcgsByNumber(<pcgs>, <n>)
##
##  computes Order (Group (CanonicalPcgsByNumber(<pcgs>, <n>))) without 
##  actually constructing the canonical pcgs or the group
##  
InstallGlobalFunction (OrderGroupByCanonicalPcgsByNumber,
	function (ros, n)
	
		local order, j;
		
		order := 1;
		n := RemInt (n, 2^Length (ros));
		for j in [1..Length(ros)] do
			if RemInt (n, 2) > 0 then
				order := order * ros[j];
			fi;
			n := QuoInt (n, 2);
		od;
		return order;
	end);


############################################################################
##
#F  ExponentsCanonicalPcgsByNumber(<pcgs>, <n>)
##
##  computes the list of exponent vectors (relative to exp) of the 
##  elements of CanonicalPcgsByNumber(<pcgs>, <n>)) without actually
##  constructing the canonical pcgs itself
##  
InstallGlobalFunction (ExponentsCanonicalPcgsByNumber,
	function (ros, n)
	
		local depths, len, d, exps, exp, j, cpcgs;
		depths := [];
		len := Length(ros);
		for j in [1..len] do
			d := RemInt (n, 2);
			n := QuoInt (n, 2);
			if d > 0 then
				Add (depths, j);
			fi;
		od;
	
		exps := [];
		for d in depths do
			exp := ListWithIdenticalEntries (len, 0);
			exp[d] := 1;
			for j in [d+1..len] do
				if not j in depths then
					exp[j] := RemInt (n, ros[j]);
					n := QuoInt (n, ros[j]);
				fi;
			od;
			Add (exps, exp);
		od;
		
		return exps;
	end);
	
	




	
############################################################################
##
#V  GENS_EXT_AFF
##
##  This variable caches the return values of GeneratorsOfExtendedAffineGroup
##  (see below)
##  
InstallValue (GENS_EXT_AFF, []);


############################################################################
##
#F  GeneratorsOfExtendedAffineGroup(q, n)
##
##  Let q be a prime power and n an integer. This function returns a 
##  record with entries genmul and gengal.
##
##  Both are n x n matrices over GF(q). genmul is the action of
##  a generator of the multiplicative group of GF(q^n), regarded as a vector 
##  space over GF(q). gengal is a matrix describing the action of a generator
##  of the Galois group of GF(q^n)/GF(q) on that vector space.
##  
InstallGlobalFunction (GeneratorsOfExtendedAffineGroup,
	function (q, n)

		local pol, p, e, con, i, x, z, R, f, m, k, coeffs, g, h;
		
		if not IsBound (GENS_EXT_AFF[n]) then
			GENS_EXT_AFF[n] := [];
		fi;
		if not IsBound (GENS_EXT_AFF[n][q]) then	
			x := X(GF(q));
			z := Zero (GF(q));
			R := PolynomialRing (GF(q), 1);
			p := SmallestRootInt (q);
			e := LogInt (q, p);
			con := ConwayPolynomial (p, n*e);
			if e = 1 then
				con := [con]; # we know that con is irreducible over GF(p)
			else
				con := Factors (R, con);
			fi;
			i := 1;
			repeat
				pol := con[i];	# try which irreducible factor has a root 
								# whose root has the right order
				f := One (R);
				m := NullMat (n, n, GF(q));
				for k in [1..n] do
					f := f * x mod pol;
					coeffs := CoefficientsOfUnivariatePolynomial (f);
					m[k]{[1..Length (coeffs)]} := coeffs;
				od;
				i := i + 1;
			until Order (m) = q^n - 1;
			
			g := NullMat (n, n, GF(q));
			f := One (R);
			h := PowerMod (x, q, pol);
			g[1][1] := One (GF(q));
			for k in [2..n] do
				f := f * h mod pol;
				coeffs := CoefficientsOfUnivariatePolynomial (f);
				g[k]{[1..Length (coeffs)]} := coeffs;
			od;
			GENS_EXT_AFF[n][q] := rec (genmul := m, gengal := g);
		fi;
		return GENS_EXT_AFF[n][q];
	end);


############################################################################
##
#F  AsMatrixListOverSubield(list, n, q)
##
##  list must be a list of square matrices of the same size d over GF(q^n),
##  where q is a prime power and n a positive integer.
##
##  This function rewrites each matrix in list as a matrix acting on
##  GF(q^n)^d, regarded as a GF(q)-vector space.
##  
InstallGlobalFunction (AsMatrixListOverSubield, 
	function (list, n, q)

	local ggal, z, r, d, gens, pow, zero, g, h, i, j, k, x, L;
	
	if IsEmpty (list) then 
		return []; 
	fi;
	
	d := Length (list[1]);
	
	ggal := GeneratorsOfExtendedAffineGroup  (q, n);
	z := ggal.genmul;
	gens := [];
	pow := [];
	zero := 0*Z(q);
	r := Z(q^n);
	for g in list do
		h := NullMat (n*d, n*d, GF(q));
		for i in [1..d] do
			for j in [1..d] do
				x := g[i][j];
				if x <> zero then
					k := LogFFE (x, r) + 1;
					if not IsBound(pow[k]) then
						pow[k] := z^(k-1);
					fi;
					h{[(i-1)*n+1..i*n]}{[(j-1)*n+1..j*n]} := pow[k];
				fi;
			od;
		od;
		Add (gens, h);
	od;

	return gens;
end);

			
############################################################################
##
#M  IsSubfield(<E>, <F>)
##
##  checks whether F is a subfield of E
##  
InstallMethod (IsSubfield, "for two finite fields", true, 
	[IsField and IsFinite, IsField and IsFinite], 0,
	function (E, F)
	
		local p;
		p := Characteristic (F);
		if p <> Characteristic (E) then
			return false;
		else
			return LogInt (Size (E), p) mod LogInt (Size (F), p) = 0;
		fi;
	end);
	
	
############################################################################
##
#F  IsMatGroupOverFieldFam(famG, famF)
##
##  tests whether famG is the collections family of matrices over the field
##  whose family is famF
##  
InstallGlobalFunction (IsMatGroupOverFieldFam, function (famG, famF)
	return CollectionsFamily (CollectionsFamily (famF)) = famG;
end);


############################################################################
##
#E
##
