############################################################################
##
##  primitive.gi                 IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#F  PrimitivePcGroupIrreducibleMatrixGroup(<G>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (PrimitivePcGroupIrreducibleMatrixGroup,
	function (G)
			
		if not IsMatrixGroup (G) or not IsFinite (FieldOfMatrixGroup (G)) 
				or not IsPrimeInt (Size (FieldOfMatrixGroup (G)))
				or not IsIrreducibleMatrixGroup (G) then
			Error ("G must be an irreducible matrix group over a prime field");
		fi;

		return PrimitivePcGroupIrreducibleMatrixGroupNC (G);
	end);
	
			
############################################################################
##
#F  PrimitivePcGroupIrreducibleMatrixGroupNC(<G>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (PrimitivePcGroupIrreducibleMatrixGroupNC,
	function (G)
		local p, iso, pcgs, ros, f, coll, exp, mat, i, j, H;
		
		p := Size (FieldOfMatrixGroup (G));

		if not IsPrimeInt (p) then
			Error ("G must be over a prime field ");
		fi;
		iso := RepresentationIsomorphism (G);
		pcgs := Pcgs (Source (iso));
		ros := RelativeOrders (pcgs);
		
		f := FreeGroup (Length (pcgs) + DegreeOfMatrixGroup (G));
		coll := SingleCollector (f, 
			Concatenation (ros, 
				ListWithIdenticalEntries (DegreeOfMatrixGroup (G), p)));
				
		exp := [];	
		exp{[1,3..2*Length(pcgs)-1]} := [1..Length(pcgs)];
		for i in [1..Length (pcgs)] do
			exp{[2,4..2*Length(pcgs)]} := ExponentsOfPcElement (pcgs, pcgs[i]^ros[i]);
			Print ("power relation ", i,": ", exp, "\n");
			SetPower (coll, i, ObjByExtRep (FamilyObj (f.1), exp));
			for j in [i+1..Length (pcgs)] do
				exp{[2,4..2*Length(pcgs)]} := ExponentsOfPcElement (pcgs, pcgs[j]^pcgs[i]);
				Print ("conj. relation ", j, "^", i,": ", exp, "\n");
			SetConjugate (coll, j, i, ObjByExtRep (FamilyObj (f.1), exp));
			od;
		od;
		
		for j in [1..DegreeOfMatrixGroup (G)] do
			SetPower (coll, j+Length (pcgs), One(f));
		od;
		
		exp := [];
		exp{[1,3..2*DegreeOfMatrixGroup (G)-1]} := 
			[Length(pcgs) + 1..Length (pcgs) + DegreeOfMatrixGroup (G)];
				
		for i in [1..Length (pcgs)] do
			mat := ImageElm (RepresentationIsomorphism(G), pcgs[i]);
			for j in [1..DegreeOfMatrixGroup (G)] do
				exp{[2,4..2*DegreeOfMatrixGroup(G)]} := List (mat[j], IntFFE);
				Print ("conj. relation ", j+ Length (pcgs), "^", i,": ", exp, "\n");
				SetConjugate (coll, j + Length (pcgs), i, ObjByExtRep (FamilyObj (f.1), exp));
			od;
		od;
		
		H := GroupByRws (coll);
		SetSocle (H, GroupOfPcgs (InducedPcgsByPcSequenceNC (FamilyPcgs (H),
			FamilyPcgs(H){[Length (pcgs) + 1..Length (FamilyPcgs (H))]})));
		SetFittingSubgroup (H, Socle (H));

#       the following would require the CRISP package, so we leave it out

#		if IsBound (SocleComplement) then
#			SetSocleComplement (H, GroupOfPcgs (InducedPcgsByPcSequenceNC (FamilyPcgs (H),
#				FamilyPcgs(H){[1..Length (pcgs)]})));
#		fi;
#		if IsBound (IsPrimitiveSolvable) then
#			SetIsPrimitiveSolvable (H, true);
#		fi;
		return H;
	end);
	

############################################################################
##
#F  IrreducibleMatrixGroupPrimitivePcGroup(<G>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (IrreducibleMatrixGroupPrimitivePcGroup,
	function (G)
	
		local F, p;
		
		if not IsSolvableGroup (G) then
			Error ("G must be solvable");
		fi;
		
		F := FittingSubgroup (G);
		
		if not IsPGroup (F)  or not IsAbelian (F) then
			Error ("G must be primitive");
		fi;
		
		p := PrimePGroup (F);
		
		if ForAny (GeneratorsOfGroup (F), x -> x^p <> One(G)) then
			Error ("G must be primitive");
		fi;
		
		return IrreducibleMatrixGroupPrimitivePcGroupNC (G);
	end);
	
			
############################################################################
##
#F  IrreducibleMatrixGroupPrimitivePcGroupNC(<G>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (IrreducibleMatrixGroupPrimitivePcGroupNC,
	function (G)
	
		local N, p, pcgs, one, mat, mats, g, h, i, H;
		
		N := FittingSubgroup (G);
		
		pcgs := Pcgs (N);
		p := RelativeOrders (pcgs)[1];
		one := One (GF(p));
		
		mats := [];
		
		for g in Pcgs (G) do
			mat := [];
			for i in [1..Length (pcgs)] do
				mat[i] := ExponentsOfPcElement (pcgs, pcgs[i]^g)*one;
			od;
			Add (mats, mat);
		od;
		H := Group (mats);
		SetSize (H, Size (G)/Size (N));
		return H;
	end);
		

############################################################################
##
#R  IsIteratorPrimitivePcGroupsRep
##
##  representation for an iterator running throug a list of primitive
##  solvable pc groups
##  
DeclareRepresentation ("IsIteratorPrimitivePcGroupsRep",
	IsIterator and IsComponentObjectRep,
	["degs", "deginds", "orders", "iteratormatgrp"]);


############################################################################
##
#F  IteratorPrimitivePcGroups(<func_1>, <val_1>, ...)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IteratorPrimitivePcGroups, 
	function (arg)

		local r, iterator;
		
		r := CheckAndExtractArguments ([[Degree, NrMovedPoints, LargestMovedPoint], 
			[Order, Size]], 
			[IsPosInt, IsPosInt], 
			arg, 
			"IteratorPrimitivePcGroups");
		if ForAny (r.specialvalues, v -> IsEmpty (v)) then
			return Iterator ([]);
		fi;

		iterator := Objectify (NewType (NewFamily ("iterator of prinitive pc groups fam"),
			IsIteratorPrimitivePcGroupsRep and IsMutable), 
			rec());

		if not IsBound (r.specialvalues[1]) then 
			Error ("IteratorPrimitivePcGroupsIterator: You must specify the degree(s) of the desired primitive groups");
		else
			iterator!.degs := Filtered (r.specialvalues[1], IsPrimePowerInt);
		fi;	
		
		iterator!.degind := 0;
		
		if IsBound (r.specialvalues[2]) then
			iterator!.orders := r.specialvalues[2];
		else
			iterator!.orders := fail;
		fi;
		
		iterator!.iteratormatgrp := Iterator([]);
		return iterator;
	end);


############################################################################
##
#M  IsDoneIterator
##
##  for iterator of library of primitive soluble pc groups
##  
InstallMethod (IsDoneIterator, "for primitive soluble pc groups groups", true,
	[IsIteratorPrimitivePcGroupsRep], 0,
	function (iterator)

		local d, p, n, orders, o;
		
		if iterator!.degind > Length (iterator!.degs) then
			Error ("isDoneIterator called after it returned true");
		fi;
		
		while IsDoneIterator (iterator!.iteratormatgrp) do
			iterator!.degind := iterator!.degind + 1;
			if iterator!.degind > Length (iterator!.degs) then
				return true;
			fi;
			d := iterator!.degs[iterator!.degind];
			p := SmallestRootInt (d);
			n := LogInt (d, p);
			if IsAvailableIrreducibleSolvableGroupData (n, p) then				
				if iterator!.orders <> fail then
					orders := [];
					for o in iterator!.orders do
						if o mod d = 0 then
							Add (orders, o/d);
						fi;
					od;
					iterator!.iteratormatgrp := IteratorIrreducibleSolvableMatrixGroups(
						Degree, n, Field, GF(p), Order, orders);
				else
					iterator!.iteratormatgrp := IteratorIrreducibleSolvableMatrixGroups(
						Degree, n, Field, GF(p));

				fi;
			else
				Error ("groups of degree ", d, " are beyond the scope of the IRREDSOL library");
				iterator!.iteratormatgrp := Iterator([]);
			fi;
		od;
		return false;
	end);
			
			
############################################################################
##
#M  NextIterator
##
##  for iterator of library of primitive soluble pc groups
##  
InstallMethod (NextIterator, "for primitve solvable pc groups", true,
	[IsMutable and IsIteratorPrimitivePcGroupsRep], 0,
	function (iterator)
		
		local G;
		
		G := NextIterator (iterator!.iteratormatgrp);
		return PrimitivePcGroupIrreducibleMatrixGroupNC (G);
	end);
	

###########################################################################
##
#F  AllPrimitivePcGroups(<arg>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (AllPrimitivePcGroups,
	function (arg)
	
		local iter, l, G;
		
		iter := CallFuncList (IteratorPrimitivePcGroups, arg);
		
		l := [];
		for G in iter do
			Add (l, G);
		od;
		return l;
	end);


###########################################################################
##
#F  OnePrimitivePcGroup(<arg>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (OnePrimitivePcGroup,
	function (arg)
	
		local iter;
		
		iter := CallFuncList (IteratorPrimitivePcGroups, arg);
		if IsDoneIterator (iter) then
			return fail;
		else 
			return NextIterator (iter);
		fi;
	end);


############################################################################
##
#E
##
			
		
		

	