############################################################################
##
##  loadfp.gi                    IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#V  ABS_IRRED_FP_INDEX
#V  ABS_IRRED_FP
##
##  fingerprint database file index and data list
##  
BindGlobal ("ABS_IRRED_FP_INDEX", []);
BindGlobal ("ABS_IRRED_FP", []);
BindGlobal ("ABS_IRRED_FP_ELMS", []);


############################################################################
##
#F  PathAbsolutelyIrreducibleSolvableGroupFingerprintIndex(<n>, <q>)
##
##  returns the path of the fingerprint database index file, or
##  fail if the file does not exist or is unreadable
##  
InstallGlobalFunction (PathAbsolutelyIrreducibleSolvableGroupFingerprintIndex,
	function (n, q)
	
		local pathname, filename, dirs, dir, inds, desc, gddesc, i;
		
		if n = 1 then
			Error ("n must be at least 2");
		fi;
	
		filename := Concatenation ("gl_", String (n), "_",String (q),".idx");
			
		dirs := DirectoriesPackageLibrary ("irredsol", "fps");
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
#F  IsAvailableAbsolutelyIrreducibleSolvableGroupFingerprintIndex(<n>, <q>)
##
##  returns true if the fingerprint data index is available
##  
InstallGlobalFunction (IsAvailableAbsolutelyIrreducibleSolvableGroupFingerprintIndex,
	function (n, q)
	
		if not IsPosInt (n) or not IsPosInt (q) or not IsPrimePowerInt (q)  then
			Error ("n and q must be positive integers and q must be a prime power");
		fi;
		if n = 1 then 
			return q < 65536;
		else
			return PathAbsolutelyIrreducibleSolvableGroupFingerprintIndex (n, q) <> fail;
		fi;
	end);
	
	
############################################################################
##
#F  LoadAbsolutelyIrreducibleSolvableGroupFingerprintIndex(<n>, <q>)
##
##  loads the fingerprint database index file
##  
InstallGlobalFunction (LoadAbsolutelyIrreducibleSolvableGroupFingerprintIndex,
	function (n, q)
	
		local pathname;
		
		if not IsPosInt (n) or not IsPosInt (q) or not IsPrimePowerInt (q)  then
			Error ("n and q must be positive integers and q must be a prime power");
		fi;
		
		if n = 1 then
			if q > 65535 then
				Error ("field size must not exceed 65535");
			fi;
			return;
		fi;
		
		if not IsBound (ABS_IRRED_FP_INDEX[n]) then
			ABS_IRRED_FP_INDEX[n] := [];
		fi;
		
		if not IsBound (ABS_IRRED_FP_INDEX[n][q]) then
			pathname := PathAbsolutelyIrreducibleSolvableGroupFingerprintIndex(n,q);
			if pathname = fail then
				Error("cannot access data file for irreducible groups of degree ", n, " over GF(",q,"). ",
					"Maybe the parameters are out of range?");
			fi;
			
			Read (pathname);
			
			if not IsBound (ABS_IRRED_FP_INDEX[n][q]) then
				Error ("Panic: reading data file didn't define required data");
			fi;
			MakeImmutable (ABS_IRRED_FP_INDEX[n][q]);
			
		fi;
		return;
	end);
	

############################################################################
##
#F  PathAbsolutelyIrreducibleSolvableGroupFingerprint(<n>, <q>, <k>)
##
##  returns the path to the k-th fingerprint data file for GL(n,q), 
##  if it exists and is readable, or fail otherwise.
##  
InstallGlobalFunction (PathAbsolutelyIrreducibleSolvableGroupFingerprint,
	function (n, q, k)
	
		local pathname, filename, dirs, dir, inds, desc, gddesc, i;
		
		if n = 1 then
			Error ("n must be at least 2");
		fi;
	
		filename := Concatenation ("gl_", String (n), "_",String (q),"_", String(k),".fpc");
			
		dirs := DirectoriesPackageLibrary ("irredsol", "fps");
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
#F  IsAvailableAbsolutelyIrreducibleSolvableGroupFingerprint(<n>, <q>, <o>)
##
##  returns true if the fingerprint data file for subgroups of order o of
##  GL(n,q) exists and is readable
##  
InstallGlobalFunction (IsAvailableAbsolutelyIrreducibleSolvableGroupFingerprint,
	function (n, q, order)
	
		local pos, index;
		if not IsPosInt (n) or not IsPosInt (q) or not IsPrimePowerInt (q) 
			or not IsPosInt (order) then
			Error ("n, q, and order must be positive integers and q must be a prime power");
		fi;
		if n = 1 then 
			return q < 65536;
		elif IsAvailableAbsolutelyIrreducibleSolvableGroupFingerprintIndex (n, q) then
			LoadAbsolutelyIrreducibleSolvableGroupFingerprintIndex (n, q);
			pos := PositionSet (ABS_IRRED_FP_INDEX[n][q][1], order);
			if pos = fail then
				return true; # group is unique, up to conjugacy, no information stored
			fi;
			index := ABS_IRRED_FP_INDEX[n][q][2][pos]; # number of fp file
			return PathAbsolutelyIrreducibleSolvableGroupFingerprint (n, q, index) <> fail;
		else
			return false;
		fi;
	end);
	

###########################################################################
##
#F  AbsolutelyIrreducibleSolvableGroupFingerprintData(<n>, <q>, <o>)
##
##  returns the fingerprint data for subgroups of order o of GL(n,q) 
##  The fiongerprint data is a record with entries elms
##  and fps. Elms is a set of lists of four integers
##  fps is a list. Each entry corresponds to one fingerprint
##  For each fingerprint, there is a list with three entries,
##  the first being the group order (i.e., <o>), the second is a set of 
##  integers from [1..Length (elms)], indicating
##  which of the entries in elms is in the particular fingerprint
##  The third is a list indicating the indices of the gropus
##  having that fingerprint.
##  
InstallGlobalFunction (AbsolutelyIrreducibleSolvableGroupFingerprintData,
	function (n, q, order)
	
		local pathname, pos, index, i;
		
		if not IsPosInt (n) or not IsPosInt (q) or not IsPrimePowerInt (q)  then
			Error ("n and q must be positive integers and q must be a prime power");
		fi;

		if n = 1 then
			return fail; # group is unique, up to conjugacy - no informations stored
		fi;

		LoadAbsolutelyIrreducibleSolvableGroupFingerprintIndex (n, q);

		pos := PositionSet (ABS_IRRED_FP_INDEX[n][q][1], order);
		if pos = fail then
			return fail; # group is unique, up to conjugacy, no information stored
		fi;
		index := ABS_IRRED_FP_INDEX[n][q][2][pos]; # number of fp file

		if not IsBound (ABS_IRRED_FP[n]) then
			ABS_IRRED_FP[n] := [];
		fi;
			
		if not IsBound (ABS_IRRED_FP[n][q]) then
			ABS_IRRED_FP[n][q] := [];
		fi;
		
		if not IsBound (ABS_IRRED_FP_ELMS[n]) then
			ABS_IRRED_FP_ELMS[n] := [];
		fi;
		
		if not IsBound (ABS_IRRED_FP_ELMS[n][q]) then
			ABS_IRRED_FP_ELMS[n][q] := [];
		fi;
		if not IsBound (ABS_IRRED_FP[n][q][pos]) then
		
			pathname := PathAbsolutelyIrreducibleSolvableGroupFingerprint (n, q, index);
			if pathname = fail then
				Error("cannot access data file for irreducible groups of degree ", n, " over GF(",q,"). ",
					"Maybe the parameters are out of range?");
			fi;
			
			Info (InfoIrredsol, 1, "reading file ", pathname);
			Read (pathname);
			
			if not IsBound (ABS_IRRED_FP[n][q][pos]) or not IsBound (ABS_IRRED_FP_ELMS[n][q][pos])then
				Error ("Panic: reading data file didn't define required data");
			fi;
			for i in [1..Length (ABS_IRRED_FP_INDEX[n][q][2])] do
				if ABS_IRRED_FP_INDEX[n][q][2][i] = index then
					MakeImmutable (ABS_IRRED_FP[n][q][i]);
				fi;
			od;
			
		fi;
		return rec (elms := ABS_IRRED_FP_ELMS[n][q][pos],
					fps := ABS_IRRED_FP[n][q][pos]);
	end);
	
		
###########################################################################
##
#F  UnloadAbsolutelyIrreducibleSolvableGroupFingerprints(<arg>)
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (UnloadAbsolutelyIrreducibleSolvableGroupFingerprints,
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
			MakeReadWriteGlobal ("ABS_IRRED_FP");
			UnbindGlobal ("ABS_IRRED_FP");
			BindGlobal ("ABS_IRRED_FP", []);
			MakeReadWriteGlobal ("ABS_IRRED_FP_ELMS");
			UnbindGlobal ("ABS_IRRED_FP_ELMS");
			BindGlobal ("ABS_IRRED_FP_ELMS", []);
			MakeReadWriteGlobal ("ABS_IRRED_FP_INDEX");
			UnbindGlobal ("ABS_IRRED_FP_INDEX");
			BindGlobal ("ABS_IRRED_FP_INDEX", []);
		elif IsPosInt (arg[1]) and Length (arg) = 1 then
			if arg[1] > 1 then
				UnbindIfBound (ABS_IRRED_FP, arg[1]);
				UnbindIfBound (ABS_IRRED_FP_INDEX, arg[1]);
			fi;
		elif Length (arg) = 2 and IsPosInt (arg[1]) and IsPrimePowerInt (arg[2]) and arg[2] <> 1 then
			if arg[1] > 1 then
				UnbindIfBound (ABS_IRRED_FP, arg[1], arg[2]);
				UnbindIfBound (ABS_IRRED_FP_INDEX, arg[1], arg[2]);
			fi;
		else
			Error ("Usage: `UnloadAbsolutelyIrreducibleSolvableGroupFingerprints ( [n [, q]] )'");
		fi;
	end);


############################################################################
##
#F  LoadedAbsolutelyIrreducibleSolvableGroupFingerprints()
##
##  see IRREDSOL documentation
##  
InstallGlobalFunction (LoadedAbsolutelyIrreducibleSolvableGroupFingerprints,
	function ()
	
		local n, p, data, fields;
		
		data := [];
		for n in [1..Length (ABS_IRRED_FP)] do
			if IsBound (ABS_IRRED_FP[n]) then
				fields := [];
				for p in [1..Length (ABS_IRRED_FP[n])] do
					if IsBound (ABS_IRRED_FP[n][p]) then
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
						



###########################################################################
##
#E
##
