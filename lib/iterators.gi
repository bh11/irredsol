############################################################################
##
##  iterators.gi                 IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#R  IsIteratorIrreducibleSolvableMatrixGroups
##
##  representation for an iterator running throug a list of irreducible
##  solvable matrix groups
##  
DeclareRepresentation ("IsIteratorIrreducibleSolvableMatrixGroups", 
	IsIterator and IsComponentObjectRep,
	["dims", "dimi", "qs", "qi", "indices", "pos", "divdim", "divi",
		"orders", "max", "primiive", "blockdims", "absirred",
		"testfuncs", "testvals", "nextGroup"]);


############################################################################
##
#F  SelectionAbsolutelyIrreducibleSolvableMatrixGroups(n, q, orders, blockdims, max)
##
##  selects the set of indices of absolutely irreducible matrix gropus
##  whose orders are in <orders>, whose minimal block dims are in <blockdims>
##  if max is true, only the maximal soluble groups are returned, if max is
##  false, the non-maximal ones are returned. 
##  To ignore one of the parameters orders, blockdims, max, set it to fail
##  
InstallGlobalFunction (SelectionAbsolutelyIrreducibleSolvableMatrixGroups,
	function (n, q, orders, blockdims, max)
	
		local descs, guardianDescs, desc, guardianDesc, grpinds, inds, i, grp;
		
		LoadAbsolutelyIrreducibleSolvableGroupData (n,q);
		
		if orders = fail and blockdims = fail and max = fail then
			return IndicesAbsolutelyIrreducibleSolvableMatrixGroups (n, q);
		fi;
		
		if n = 1 then
			if blockdims <> fail and not 1 in blockdims then
				return [];
			fi;
			if max = true then
				if orders = fail or q-1 in orders then
					return [Length (DIVISORS_FIELD_ORDER [q])];
				fi;
			else
				inds := [];
				for i in [1..Length (DIVISORS_FIELD_ORDER [q])] do
					if orders = fail or DIVISORS_FIELD_ORDER [q][i] in orders then
						Add (inds, i);
					fi;
				od;
				if max = false then
					RemoveSet (inds, Length (DIVISORS_FIELD_ORDER [q]));
				fi;
				return inds;
			fi;
		fi;
		
		descs := ABS_IRRED_DATA[n][q];
		guardianDescs := GUARDIAN_ABS_IRRED_DATA[n][q];
		if max = true then
			grpinds := MAX_ABS_IRRED_DATA[n][q];
		elif max = false then
			grpinds := Difference (IndicesAbsolutelyIrreducibleSolvableMatrixGroups (n, q), MAX_ABS_IRRED_DATA[n][q]);
		else
			grpinds := IndicesAbsolutelyIrreducibleSolvableMatrixGroups (n, q);
		fi;
		
		inds := [];
		
		for i in grpinds do
			desc := descs[i]; # description of group
			guardianDesc := guardianDescs[desc[ABS_IRRED_GUARDIAN_NUMBER]]; # and corresponding guardian
			grp := Source (guardianDesc[GUARDIAN_PC_PRESENTATION]); # pc group isomorphic with guardian
			if (orders = fail or
					OrderGroupByCanonicalPcgsByNumber (RelativeOrders (Pcgs (grp)), desc[ABS_IRRED_CANONICAL_PCGS]) in orders)
				and (blockdims = fail or guardianDesc[GUARDIAN_MIN_BLOCKDIM] in blockdims) then
					Add (inds, i);
			fi;
		od;
		return inds;
	end);


############################################################################
##
#F  OrdersAbsolutelyIrreducibleSolvableMatrixGroups(n, q, blockdims, max)
##
##  returns a set. Each entry is a pair [order, count] describing how many
##  groups of that order are in the data base whose minimal block dims are in <blockdims>
##  if max is true, only the maximal soluble groups are counted, if max is
##  false, the non-maximal ones are returned. 
##  To ignore one of the parameters blockdims, max, set it to fail
##  
InstallGlobalFunction (OrdersAbsolutelyIrreducibleSolvableMatrixGroups,
	function (n, q, blockdims, max)
	
		local orders, descs, guardianDescs, desc, guardianDesc, grpinds, i, j, grp, o;
	
		LoadAbsolutelyIrreducibleSolvableGroupData (n,q);
		
		if n = 1 then
			if blockdims <> fail and not 1 in blockdims then
				return [];
			fi;
			if max = true then
				return [[DIVISORS_FIELD_ORDER [q][Length (DIVISORS_FIELD_ORDER [q])],1]];
			else
				orders :=  List (DIVISORS_FIELD_ORDER [q], d -> [d,1]);
				if max = false then
					Unbind (orders[Length (orders)]);
				fi;
				return orders;
			fi;
		fi;
		
		descs := ABS_IRRED_DATA[n][q];
		guardianDescs := GUARDIAN_ABS_IRRED_DATA[n][q];
		if max = true then
			grpinds := MAX_ABS_IRRED_DATA[n][q];
		elif max = false then
			grpinds := Difference ([1..Length (descs)], MAX_ABS_IRRED_DATA[n][q]);
		else
			grpinds := [1..Length (descs)];
		fi;
		
		orders := [];

		for i in grpinds do
			desc := descs[i]; # description of group
			guardianDesc := guardianDescs[desc[ABS_IRRED_GUARDIAN_NUMBER]]; # and corresponding guardian
			grp := Source (guardianDesc[GUARDIAN_PC_PRESENTATION]); # pc group isomorphic with guardian
			if (blockdims = fail or guardianDesc[GUARDIAN_MIN_BLOCKDIM] in blockdims) then
				o := OrderGroupByCanonicalPcgsByNumber (RelativeOrders (Pcgs (grp)), desc[ABS_IRRED_CANONICAL_PCGS]);
				j := PositionSorted (orders, [o,1], function (a, b) return a[1] < b[1]; end);
				if IsBound (orders[j]) and orders[j][1] = o then
					orders[j][2] := orders[j][2] + 1;
				else
					orders{[j+1..Length (orders)+1]} := orders{[j..Length (orders)]};
					orders[j] := [o,1];
				fi;
			fi;
		od;
		return orders;
	end);


############################################################################
##
#F  BlockDimensionsAbsolutelyIrreducibleSolvableMatrixGroups(n, q, order)
##
##  returns a list. Each entry corresponds to a divisor d of n (in ascending order)
##  and denotes the number of absolutely irreducible groups of order <order> 
##  in the data base which have block dimension d.
##
InstallGlobalFunction (BlockDimensionsAbsolutelyIrreducibleSolvableMatrixGroups,
	function (n, q, order)
	
		local blockdims, inds, descs, guardianDescs, desc, guardianDesc, divs, d, i, j;
	
		if n = 1 then
			return [1];
		fi;
		
		divs := DivisorsInt (n);
		blockdims := ListWithIdenticalEntries (Length (divs), 0);
		
		inds := SelectionAbsolutelyIrreducibleSolvableMatrixGroups (n, q, [order], divs, fail);
		descs := ABS_IRRED_DATA[n][q];
		guardianDescs := GUARDIAN_ABS_IRRED_DATA[n][q];

		for i in inds do
			desc := descs[i]; # description of group
			guardianDesc := guardianDescs[desc[ABS_IRRED_GUARDIAN_NUMBER]]; # and corresponding guardian
			d := guardianDesc[GUARDIAN_MIN_BLOCKDIM];
			j := PositionSet (divs, d);
			blockdims[j] := blockdims[j] + 1;
		od;
		return blockdims;
	end);


############################################################################
##
#F  CheckAndExtractArguments(specialfuncs, checks, argl, caller)
##
##  This function tests whether argl is a list of even length in which the 
##  entries at odd positions are functions.
##  For special functions in this list (each entry in specialfuncs is a list of synonyms
##  of such functions) it tests whether the following entry in argl satisfies the 
##  function in checks corresponding to specailfunc, and that each specialfunc
##  only occurs once (including synonyms).
##
##  The function returns a record with entries specialvalues, functions, and values.
##  if specialvalues[i] is bound, it was the entry following a function in 
##  specialfuncs[i]. The functions at odd positions in argl but not in specialfuncs 
##  are returned in the record entry functions,
##  the following entries in argl are in the record entry values.
##
InstallGlobalFunction (CheckAndExtractArguments,
	function (specialfuncs, checks, argl, caller)
	
		local funcs, vals, specialvals, i, f, j;
		
		if Length (argl) mod 2 <> 0 then
			Error ("number of arguments of `", caller, "' must be even");
		fi;
		funcs := [];
		vals := [];
		specialvals := [];
		for i in [1,3..Length (argl)-1] do
			f := argl[i];
			if not IsFunction (f) then
				Error (i, "-th argument in function `", caller, "' must be a function");
			fi;
			if IsList (argl[i+1]) then
				argl[i+1] := Set (argl[i+1]);
			else
				argl[i+1] := [argl[i+1]];
			fi;
			j := PositionProperty (specialfuncs, funclist -> f in funclist);
			if j = fail then
				Add (funcs, f);
				Add (vals, argl[i+1]);
			elif IsBound (specialvals[j]) then
				Error ("there may be only one occurrence of ", f, " in `", caller, "'");
			else
				if not ForAll (argl[i+1], x -> checks[j](x)) then
					Error ("inadmissible value for argument ", i+1, " in `", caller, "'");
				fi;
				specialvals[j] := argl[i+1];
			fi;
		od;
		return rec (specialvalues := specialvals, functions := funcs, values := vals);
	end);


############################################################################
##
#F  IteratorIrreducibleSolvableMatrixGroups(<func_1>, <val_1>, ...)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (IteratorIrreducibleSolvableMatrixGroups,
	function (arg)
	
		local r, p, q, k, iterator, primes;
	
		r := CheckAndExtractArguments ([[Degree, DegreeOfMatrixGroup, Dimension, DimensionOfMatrixGroup], 
			[Characteristic, CharacteristicOfField], [Field, FieldOfMatrixGroup], [Order, Size], 
			[MinimalBlockDimension, MinimalBlockDimensionOfMatrixGroup], \
   [IsPrimitive, IsPrimitiveMatrixGroup, IsLinearlyPrimitive], 
			[IsMaximalAbsolutelyIrreducibleSolvableMatrixGroup], 
			[IsAbsolutelyIrreducibleMatrixGroup, IsAbsolutelyIrreducible]], 
			[IsPosInt, p -> IsPosInt (p) and IsPrimeInt (p), F -> IsField (F) and IsFinite (F), IsPosInt,
			IsPosInt, x -> x in [true, false], x -> x in [true, false], x -> x in [true, false]], 
			arg, 
			"IteratorIrreducibleSolvableMatrixGroups");
		
		if ForAny (r.specialvalues, v -> IsEmpty (v)) then
			return Iterator ([]);
		fi;

		if not IsBound (r.specialvalues[1]) then 
			Error ("IteratorIrreducibleSolvableMatrixGroups: You must specify the degree(s) of the desired matrix groups");
		fi;
		
		if not IsBound (r.specialvalues[3]) then 
			Error ("IteratorIrreducibleSolvableMatrixGroups: You must specify the field(s) of the desired matrix groups");
		fi;
		
		iterator := Objectify (NewType (NewFamily ("iterator of finite solvable matrix groups fam"),
			IsIteratorIrreducibleSolvableMatrixGroups and IsMutable), 
			rec());
		
		
		iterator!.testfuncs := r.functions;
		iterator!.testvals := r.values;
		
		iterator!.dims := r.specialvalues[1];

		iterator!.qs := List (r.specialvalues[3], Size);
		if IsBound (r.specialvalues[2]) then
			iterator!.qs := Filtered (iterator!.qs, q -> SmallestRootInt (q) in r.specialvalues[2]);
		fi;
		
		if IsBound (r.specialvalues[4]) then
			iterator!.orders := r.specialvalues[4];
		else
			iterator!.orders := fail;
		fi;
		if IsBound (r.specialvalues[5]) then
			iterator!.blockdims := r.specialvalues[5];
		else
			iterator!.blockdims := fail;
		fi;
		if IsBound (r.specialvalues[6]) then
			if Length (r.specialvalues[6]) = 1 then
				iterator!.primitive := r.specialvalues[6][1];
			else
				Info (InfoWarning, 1, "IteratorIrreducibleSolvableMatrixGroups: `IsPrimitiveMatrixGroup' is redundant - will be ignored");
				iterator!.primitive := fail;
			fi;
		else
			iterator!.primitive := fail;
		fi;
		
		if IsBound (r.specialvalues[7]) then
			if Length (r.specialvalues[7]) > 1 then
				Info (InfoWarning, 1, "IteratorIrreducibleSolvableMatrixGroups: `IsMaximalAbsolutelyIrreducibleSolvableMatrixGroup' is redundant");
				iterator!.max := fail;
			else
				iterator!.max := r.specialvalues[7][1];
			fi;
		else
			iterator!.max := fail;
		fi;
		
		if IsBound (r.specialvalues[8]) then
			if Length (r.specialvalues[8]) > 1 then
				Info (InfoWarning, 1, "IteratorIrreducibleSolvableMatrixGroups: `IsAbsolutelyIrreducibleSolvableMatrixGroup' is redundant");
				iterator!.absirred := fail;
			else 
				iterator!.absirred := r.specialvalues[8][1];
				if iterator!.max = true and iterator!.absirred = false then
					Info (InfoWarning, 1, "IteratorIrreducibleSolvableMatrixGroups: values of `IsMaximalAbsolutelyIrreducibleSolvableMatrixGroup' ",
						"and `IsAbsolutelyIrreducibleSolvableMatrixGroup' contradict each other");
					return Iterator([]);
				fi;
			fi;
		else
			iterator!.absirred := fail;
		fi;
		
		if iterator!.max = true then
			iterator!.absirred := true;
		fi;
		
		# set up start position in iterator, always points to data of next group to read
		# if pos is outside indices, then the next value for dim and/or q has to be loaded
		
		iterator!.qi := 1;
		iterator!.dimi := 0;
		iterator!.divdim := [];
		iterator!.divi := 0;
		iterator!.pos := 1;
		iterator!.indices := [];
		return iterator;
	end);


############################################################################
##
#M  IsDoneIterator
##
##  for iterator of database of irreducible soluble matrix groups
##  
InstallMethod (IsDoneIterator, "for irreducible solvable matrix groups", true,
	[IsIteratorIrreducibleSolvableMatrixGroups], 0,
	function (iterator)
	
		local blockdims, dim, div, q, min, max, G, H, gensH, repH, gensG, repG;
		
		# make sure that IsDoneIterator can be called several times after it has returned `true'
		
		if iterator!.qi > Length (iterator!.qs) then
			return true;
		fi;

		while not IsBound (iterator!.nextGroup) do # try to find next group
			while iterator!.pos > Length (iterator!.indices) do
				iterator!.divi := iterator!.divi + 1;
				
				if iterator!.divi > Length (iterator!.divdim) then 
					
					# next dimension
					iterator!.dimi := iterator!.dimi + 1;

					if iterator!.dimi > Length (iterator!.dims) then
						iterator!.dimi := 1;
						iterator!.qi := iterator!.qi + 1;
						if iterator!.qi > Length (iterator!.qs) then
							return true;
						fi;
					fi;
				
					# set up divisors for the construction of groups which are not absolutely irreducible
					if iterator!.absirred = true then
						iterator!.divdim := [1];
						iterator!.divi := 1;
					else
						iterator!.divdim := DivisorsInt (iterator!.dims[iterator!.dimi]);
						if iterator!.absirred = false then
							iterator!.divi := 2; # we don't want the absolutely irreducible ones
						else
							iterator!.divi := 1;
						fi;
					fi;
				
				fi;
				# get relevant indices for new values of n and q
				
				div := iterator!.divdim[iterator!.divi];
				dim := iterator!.dims[iterator!.dimi]/div;
				q := iterator!.qs[iterator!.qi];
				
				# merge information about block dims and primitivity
				
				if iterator!.primitive = true then
					blockdims := [dim];
				else 
					blockdims := DivisorsInt (dim);
					if div = 1 and iterator!.primitive = false then
						blockdims := blockdims{[1..Length (blockdims)-1]}; # remove primitive ones
					fi;
				fi;
				
				if iterator!.blockdims <> fail then
					if div = 1 then
						blockdims := Intersection (blockdims, iterator!.blockdims);
					else #  we can only rule out those groups whose minimal block dimension is smaller than the minimum
						min := Minimum (iterator!.blockdims);
						blockdims := Filtered (blockdims , d -> d * div >= min); 
					fi;
				fi;

				if div = 1 then #absolutely irreducible case
					max := iterator!.max;
				elif iterator!.max = true then
					Error ("internal error: iterator!.max is true but trying to construct groups which are not abs. irred");
				else
					max := fail;
				fi;

				Info (InfoIrredsol, 1, "selecting new subgroups of ", 
					"GL(", iterator!.dims[iterator!.dimi], ", ", q, ") ", 
					"from absolutely irreducible subgroups of ",
					"GL(", dim, ", ", q^div, ") ",
					"block dims ", blockdims,
					" max: ", max);
				
				if IsAvailableAbsolutelyIrreducibleSolvableGroupData (dim, q^div) then
					LoadAbsolutelyIrreducibleSolvableGroupData (dim, q^div);
					iterator!.indices := SelectionAbsolutelyIrreducibleSolvableMatrixGroups (
						dim, q^div, iterator!.orders, blockdims, max);
				else
					Error ("group data for GL(", dim, ", ",q^div,") is not available. Type \'return;\' to skip these subgroups.");
					iterator!.indices :=  [];
				fi;
				iterator!.pos := 1;
			od;
			G := IrreducibleSolvableMatrixGroup (iterator!.dims[iterator!.dimi], iterator!.qs[iterator!.qi], 
				iterator!.divdim[iterator!.divi], iterator!.indices[iterator!.pos]);
			iterator!.pos := iterator!.pos + 1;
			
			# now test primitivity and minimal block dimension if not absolutely irreducible
			if 			(iterator!.divdim[iterator!.divi] = 1 
					or  	((iterator!.primitive = fail or 
					   		iterator!.primitive = IsPrimitiveMatrixGroup (G, GF(iterator!.qs[iterator!.qi])))
						and (iterator!.blockdims = fail or 
							MinimalBlockDimensionOfMatrixGroup (G, GF(iterator!.qs[iterator!.qi])) in iterator!.blockdims))) 
				and ForAll ([1..Length (iterator!.testfuncs)], i -> iterator!.testfuncs[i](G) in iterator!.testvals[i]) then
					iterator!.nextGroup := G;
			fi;
		od;
		return false;
	end);


############################################################################
##
#M  NextIterator
##
##  for iterator of database of irreducible soluble matrix groups
##  
InstallMethod (NextIterator, "for irreducible solvable matrix groups", true,
	[IsMutable and IsIteratorIrreducibleSolvableMatrixGroups], 0,
	function (iterator)
		
		local G;
		
		if IsDoneIterator (iterator) then
			Error ("iterator already at its end");
		else
			G := iterator!.nextGroup;
			Unbind (iterator!.nextGroup);
			return G;
		fi;
	end);
		

############################################################################
##
#F  OneIrreducibleSolvableMatrixGroup(<func_1>, <val_1>, ...)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (OneIrreducibleSolvableMatrixGroup,
	function (arg)
	
		local iter;
		
		iter := CallFuncList (IteratorIrreducibleSolvableMatrixGroups, arg);
		if IsDoneIterator (iter) then
			return fail;
		else 
			return NextIterator (iter);
		fi;
	end);
	
	
############################################################################
##
#F  AllIrreducibleSolvableMatrixGroups(<func_1>, <val_1>, ...)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction (AllIrreducibleSolvableMatrixGroups,
	function (arg)
	
		local iter, l, G;
		
		iter := CallFuncList (IteratorIrreducibleSolvableMatrixGroups, arg);
		
		l := [];
		for G in iter do
			Add (l, G);
		od;
		return l;
	end);
		

############################################################################
##
#E
##  

