############################################################################
##
##  loading.gi                   IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#V  GUARDIAN_ABS_IRRED_DATA
#V  ABS_IRRED_DATA
#V  ABS_IRRED_GAL_PERM
#V  ABS_IRRED_DATA_REPS
#V  MAX_ABS_IRRED_DATA
#V  DIVISORS_FIELD_ORDER
##
##  data structures for storing the groups in the library
##  GUARDIAN_ABS_IRRED_DATA and ABS_IRRED_DATA are read from files
##  (with subsequent conversion of some data), the others are
##  computed when needed
##  
BindGlobal ("GUARDIAN_ABS_IRRED_DATA", []);
BindGlobal ("ABS_IRRED_DATA", []);
BindGlobal ("ABS_IRRED_GAL_PERM", []);
BindGlobal ("ABS_IRRED_DATA_REPS", []);
BindGlobal ("MAX_ABS_IRRED_DATA", []);
BindGlobal ("DIVISORS_FIELD_ORDER", []);


	
############################################################################
##
#F  PathAbsolutelyIrreducibleSolvableGroupData(<n>, <q>)
##
##  returns the path of the database file, or
##  fail if the file does not exist or is unreadable
##  
InstallGlobalFunction (PathAbsolutelyIrreducibleSolvableGroupData,
	function (n, q)
	
		local pathname, filename, dirs, dir, inds, desc, gddesc, i;
		
		if n = 1 then
			Error ("n must be at least 2");
		fi;
	
		filename := Concatenation ("gl_", String (n), "_",String (q),".gp");
			
		dirs := DirectoriesPackageLibrary ("irredsol", "data");
		for dir in dirs do
			pathname := Filename (dir, filename);
			if IsReadableFile (pathname) then
				return pathname;
			fi;
		od;
		
		return fail;
	end);
	

############################################################################
##
#F  IsAvailableAbsolutelyIrreducibleSolvableGroupData(<n>, <q>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (IsAvailableAbsolutelyIrreducibleSolvableGroupData,
	function (n, q)
	
		if not IsPosInt (n) or not IsPosInt (q) or not IsPrimePowerInt (q)  then
			Error ("n and q must be positive integers and q must be a prime power");
		fi;
		if n = 1 then 
			return q < 65536;
		else
			return PathAbsolutelyIrreducibleSolvableGroupData (n, q) <> fail;
		fi;
	end);
	
	
############################################################################
##
#F  LoadAbsolutelyIrreducibleSolvableGroupData(<n>, <q>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (LoadAbsolutelyIrreducibleSolvableGroupData,
	function (n, q)
	
		local filename, pathname, dirs, dir, inds, desc, guardianData, guardianDesc, 
			i, p, d, e, divs, G, H, hom, inv,
			pos, gdPos, maxes, cpcgscode, pcgs;
		
		if not IsPosInt (n) or not IsPosInt (q) or not IsPrimePowerInt (q)  then
			Error ("n and q must be positive integers and q must be a prime power");
		fi;
		
		if not IsBound (ABS_IRRED_GAL_PERM[n]) then
			ABS_IRRED_GAL_PERM[n] := [];
		fi;

		if n = 1 then
			if not IsBound (DIVISORS_FIELD_ORDER[q]) then
				if q > 65535 then
					Error ("field size must not exceed 65535");
				else
					Info (InfoIrredsol, 1, "Computing irreducible solvable group data for ",
						"GL(", n, ", ", q, ")");
					p := SmallestRootInt (q);
					e := LogInt (q, p);
					divs := ShallowCopy (DivisorsInt (q-1));
					if e > 1 then
						for d in Set (Factors (e)) do
							SubtractSet (divs, DivisorsInt (p^(e/d) - 1));
						od;
					fi;
					DIVISORS_FIELD_ORDER[q] := divs;
					ABS_IRRED_GAL_PERM[1][q] := ();
				fi;
			fi;
			return;
		fi;
		
		if not IsBound (GUARDIAN_ABS_IRRED_DATA[n]) then
			GUARDIAN_ABS_IRRED_DATA[n] := [];
		fi;
		if not IsBound (ABS_IRRED_DATA[n]) then
			ABS_IRRED_DATA[n] := [];
		fi;
		if not IsBound (ABS_IRRED_DATA_REPS[n]) then
			ABS_IRRED_DATA_REPS[n] := [];
		fi;
		if not IsBound (MAX_ABS_IRRED_DATA[n]) then
			MAX_ABS_IRRED_DATA[n] := [];
		fi;
		
		if not IsBound (GUARDIAN_ABS_IRRED_DATA[n][q]) or not IsBound (ABS_IRRED_DATA[n][q]) 
				or not IsBound (MAX_ABS_IRRED_DATA[n][q]) or not IsBound (ABS_IRRED_GAL_PERM[n][q]) then
			pathname := PathAbsolutelyIrreducibleSolvableGroupData (n,q);
			if pathname = fail then
				Error("cannot access data file for irreducible groups of degree ", n, " over GF(",q,"). ",
					"Maybe the parameters are out of range?");
				return;
			fi;
			
			Info (InfoIrredsol, 1, "Reading library file ", pathname);
			Read (pathname);
			
			if not IsBound (GUARDIAN_ABS_IRRED_DATA[n][q]) or not IsBound (ABS_IRRED_DATA[n][q]) 
					# or not IsBound (ABS_IRRED_GAL_PERM[n][q]) 
					then
				Error ("Panic: reading data file didn't define required data");
			fi;
			
			# convert guardian data
			
			guardianData := GUARDIAN_ABS_IRRED_DATA[n][q];
			maxes := [];
			
			for gdPos in [1..Length (guardianData)]  do
				guardianDesc := guardianData[gdPos];
				guardianDesc[GUARDIAN_MAT_PCGS] := List (guardianDesc[GUARDIAN_MAT_PCGS], 
					m -> FFMatrixByNumber (m, n, q));

				G := PcGroupCode (guardianDesc[GUARDIAN_PC_PRESENTATION], guardianDesc[GUARDIAN_ORDER]);
				H := Group (guardianDesc[GUARDIAN_MAT_PCGS]);
				SetSize (H, Size (G));
				hom := GroupHomomorphismByImagesNC (G, H,
					Pcgs (G), guardianDesc[GUARDIAN_MAT_PCGS]);
				SetIsBijective (hom, true);
				guardianDesc[GUARDIAN_PC_PRESENTATION] := hom;
				if TestFlag (guardianDesc[GUARDIAN_FLAGS], GUARDIAN_MAX_FLAG) then
					cpcgscode := 2^Length (Pcgs(G)) - 1;
					pos := PositionProperty (ABS_IRRED_DATA[n][q], 
						desc -> desc[ABS_IRRED_CANONICAL_PCGS] = cpcgscode 
									and desc[ABS_IRRED_GUARDIAN_NUMBER] = gdPos);
					if pos = fail then
						Error ("panic: did not find guardian in list of groups");
					fi;
					AddSet (maxes, pos);
				fi;
			od;	
			GUARDIAN_ABS_IRRED_DATA[n][q] := guardianData; # now attach converted data
			MAX_ABS_IRRED_DATA[n][q] := maxes;
			MakeImmutable (GUARDIAN_ABS_IRRED_DATA[n][q]);
			MakeImmutable (ABS_IRRED_DATA[n][q]);
			MakeImmutable (MAX_ABS_IRRED_DATA[n][q]);
			Info (InfoIrredsol, 2, "irreducible solvable group data for GL(", n, ", ", q, ") loaded");
		fi;
		return;
	end);
	
			
############################################################################
##
#F  LoadedAbsolutelyIrreducibleSolvableGroupData()
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (LoadedAbsolutelyIrreducibleSolvableGroupData,
	function ()
	
		local n, p, data, fields;
		
		data := [];
		for n in [1..Length (ABS_IRRED_DATA)] do
			if IsBound (ABS_IRRED_DATA[n]) then
				fields := [];
				for p in [1..Length (ABS_IRRED_DATA[n])] do
					if IsBound (ABS_IRRED_DATA[n][p]) then
						Add (fields, p);
					fi;
				od;
				if not IsEmpty (fields) then
					Add (data, [n, fields]);
				fi;
			fi;
		od;
		return data;
	end);
						

############################################################################
##
#F  UnloadAbsolutelyIrreducibleSolvableGroupData([<n>[, <q>]])
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (UnloadAbsolutelyIrreducibleSolvableGroupData,
	function (arg)
	
		local UnbindIfBound;
		
		UnbindIfBound := function (arg)
			local data, i;
			
			data := arg[1];
			i := 2;
			while i < Length (arg)  do
				if not IsBound (data[arg[i]]) then
					return false;
				fi;
				data := data[arg[i]];
				i := i + 1;
			od;
			if IsBound (data[arg[i]]) then
				Unbind (data[arg[i]]);
				return true;
			else
				return false;
			fi;
		end;
		
		if Length (arg) = 0 then
			MakeReadWriteGlobal ("GUARDIAN_ABS_IRRED_DATA");
			MakeReadWriteGlobal ("ABS_IRRED_DATA");
			MakeReadWriteGlobal ("ABS_IRRED_GAL_PERM");
			MakeReadWriteGlobal ("ABS_IRRED_DATA_REPS");
			MakeReadWriteGlobal ("MAX_ABS_IRRED_DATA");
			MakeReadWriteGlobal ("DIVISORS_FIELD_ORDER");			
			UnbindGlobal ("GUARDIAN_ABS_IRRED_DATA");
			UnbindGlobal ("ABS_IRRED_DATA");
			UnbindGlobal ("ABS_IRRED_GAL_PERM");
			UnbindGlobal ("ABS_IRRED_DATA_REPS");
			UnbindGlobal ("MAX_ABS_IRRED_DATA");
			UnbindGlobal ("DIVISORS_FIELD_ORDER");
			BindGlobal ("GUARDIAN_ABS_IRRED_DATA", []);
			BindGlobal ("ABS_IRRED_DATA", []);
			BindGlobal ("ABS_IRRED_GAL_PERM", []);
			BindGlobal ("ABS_IRRED_DATA_REPS", []);
			BindGlobal ("MAX_ABS_IRRED_DATA", []);
			BindGlobal ("DIVISORS_FIELD_ORDER", []);
		elif IsPosInt (arg[1]) and Length (arg) = 1 then
			if arg[1] = 1 then
				MakeReadWriteGlobal ("MAX_ABS_IRRED_DATA");
				UnbindGlobal ("DIVISORS_FIELD_ORDER");
				BindGlobal ("DIVISORS_FIELD_ORDER", []);
			else
				UnbindIfBound (GUARDIAN_ABS_IRRED_DATA, arg[1]);
				UnbindIfBound (ABS_IRRED_DATA, arg[1]);
				UnbindIfBound (ABS_IRRED_GAL_PERM, arg[1]);
				UnbindIfBound (ABS_IRRED_DATA_REPS, arg[1]);
				UnbindIfBound (MAX_ABS_IRRED_DATA, arg[1]);
			fi;
		elif Length (arg) = 2 and IsPosInt (arg[1]) and IsPrimePowerInt (arg[2]) and arg[2] <> 1 then
			if arg[1] = 1 then
				UnbindIfBound (DIVISORS_FIELD_ORDER, arg[2]);
			else
				UnbindIfBound (GUARDIAN_ABS_IRRED_DATA, arg[1], arg[2]);
				UnbindIfBound (ABS_IRRED_DATA, arg[1], arg[2]);
				UnbindIfBound (ABS_IRRED_GAL_PERM, arg[1], arg[2]);
				UnbindIfBound (ABS_IRRED_DATA_REPS, arg[1], arg[2]);;
				UnbindIfBound (MAX_ABS_IRRED_DATA, arg[1], arg[2]);
			fi;
		else
			Error ("Usage: `UnloadAbsolutelyIrreducibleSolvableGroupData ( [n [, q]] )'");
		fi;
	end);


############################################################################
##
#F  IsAvailablerreducibleSolvableGroupData(<n>, <q>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (IsAvailableIrreducibleSolvableGroupData,
	function (n, q)
	
		local d;
		
		if not IsPosInt (n) or not IsPosInt (q) or not IsPrimePowerInt (q)  then
			Error ("n and q must be positive integers and q must be a prime power");
		fi;
		if n = 1 then 
			return q < 65536;
		else
			for d in DivisorsInt do
				if PathAbsolutelyIrreducibleSolvableGroupData (n/d, q^d) = fail then
					return false;
				fi;
			od;
			return true;
		fi;
	end);
	
	
############################################################################
##
#E
##

