RequirePackage ("irredsol");
d := 2;
limit := 2^16-1;
for d in [2.. limit] do
	if not IsPrimeInt (d) then
		p := SmallestRootInt (d);
		if IsPrimeInt (p) then
			Print (d, "  \c");
			m := LogInt (d, p);
			for e in DivisorsInt (m) do
				LoadAbsolutelyIrreducibleSolvableGroupData (m/e, p^e);
				UnloadAbsolutelyIrreducibleSolvableGroupData (m/e, p^e);
				if e < m then
					LoadAbsolutelyIrreducibleSolvableGroupFingerprintIndex (m/e, p^e);
					for k in Set (ABS_IRRED_FP_INDEX[m/e][p^e][2]) do
						AbsolutelyIrreducibleSolvableGroupFingerprintData (m/e, p^e, k);
					od;
					UnloadAbsolutelyIrreducibleSolvableGroupFingerprints (m/e, p^e);
				fi;
			od;
			Print ("\n");
		fi;
	fi;
od;
