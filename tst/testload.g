LoadPackage ("irredsol", "", false);
UnloadAbsolutelyIrreducibleSolvableGroupData ();

PrimePowers := function(range)

    local max, maxp, p, pows, q, n;
    
    max := Maximum(range);
    maxp := RootInt(max);
    p := 2;
    pows := [];
    repeat
        q := p^2;
        n := 2;
        while q <= max do
            if q in range then
                AddSet(pows, [q, p, n]);
            fi;
            q := q * p;
            n := n + 1;
        od;
        p := NextPrimeInt(p);
    until p > maxp;
    return pows;
end;

d := 2;;
limit := 2^24-1;;

for pow in PrimePowers([2.. limit]) do
    d := pow[1];
    p :=pow[2];
    m := pow[3];
    for e in DivisorsInt (m) do
        if e < m then
            Print("\rGL(", m/e, ",", p^e,")   \c");
            if IsAvailableAbsolutelyIrreducibleSolvableGroupData (m/e, p^e) then
                LoadAbsolutelyIrreducibleSolvableGroupData (m/e, p^e);
                if e > 1 then
                   divs := Difference (DivisorsInt (e), [e]);
                   for j in [1..Length(divs)] do
                      t := divs[j];
                      inds := IndicesIrreducibleSolvableMatrixGroups (m/t, p^t, e/t);
                      if m = e then
                         data := IRREDSOL_DATA.GROUPS_DIM1[p^e];
                         data := data{[1..Length(data)]}[2];
                      else
                         data := IRREDSOL_DATA.GROUPS[m/e][p^e];
                         data := data{[1..Length(data)]}[3];
                      fi;
                      wrong := [];
                      for i in [1..Length (data)] do
                         if IsBound (data[i][j]) <(i in inds) then
                            Add (wrong, i);
                         fi;
                      od;
                      if Length (wrong) > 0 then
                         Error ("wrong subfield info for indices ", wrong, " d = ", t);
                      fi;
                   od;
                fi;
                UnloadAbsolutelyIrreducibleSolvableGroupData (m/e, p^e);
                LoadAbsolutelyIrreducibleSolvableGroupFingerprintIndex (m/e, p^e);
                for k in Set (IRREDSOL_DATA.FP_INDEX[m/e][p^e][2]) do
                    LoadAbsolutelyIrreducibleSolvableGroupFingerprintData (m/e, p^e, k);
                od;
                UnloadAbsolutelyIrreducibleSolvableGroupFingerprints (m/e, p^e);
            else
                Error ("Absolutely irreducible group data for GL(", m/e, ", ", p^e,") not available");
            fi;
        fi;
    od;
od;
