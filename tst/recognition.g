RequirePackage ("irredsol");
SetInfoLevel (InfoIrredsol, 4);


RandomAbsolutelyIrreducibleSolvableMatrixGroup := function (n, q, k)

	local gl, d, x, y, G, H1, H, gens, M;

	gl := GL(n, q);
	G := AbsolutelyIrreducibleSolvableMatrixGroup (n, q, k);
	
	H1 := Source (RepresentationHomomorphism (G));
	
	H := TrivialSubgroup (H1);
	gens := [];
	while Size (H) < Size (H1) do
		x := Random (H1);
		if not x in H then
			H := ClosureSubgroupNC (H, x);
			Add (gens, x);
		fi;
	od;
	
	d := Random ([1..LogInt (65535, q)]);
	y := RandomInvertibleMat (n, GF(q^d));
	
	M := Group (List (gens, x -> ImageElm (RepresentationHomomorphism (G), x)^y));
	SetSize (M, Size (G));
	SetIsSolvableGroup (M, true);
	SetIdAbsolutelyIrreducibleSolvableMatrixGroup (M, IdAbsolutelyIrreducibleSolvableMatrixGroup (G));
	return M;
end;

RandomIrreducibleSolvableMatrixGroup := function (n, q, d, k)

	local G, e, M;

	G := RandomAbsolutelyIrreducibleSolvableMatrixGroup (n/d, q^d, k);
	
	Assert (0, IsSubfield (FieldOfMatrixGroup (G), GF(q^d)));
	e := LogInt (Size (FieldOfMatrixGroup (G)), q^d);
	M := Group (AsMatrixListOverSubield (GeneratorsOfGroup (G), d, q^e));
	SetIdIrreducibleSolvableMatrixGroup (M, [n,q, d, k]);
	SetSize (M, Size (G));
	SetIsSolvableGroup (M, true);
	return M;
end;



RecognizeRandomAbsIrred := function (n, q, full)

	local k, G, info;
	
	k := Random ([1.. NumberAbsolutelyIrreducibleSolvableMatrixGroups(n, q)]);
	G := RandomAbsolutelyIrreducibleSolvableMatrixGroup (n, q, k);
	Info (InfoIrredsol, 1, "testing group identification for group of order ", Order (G), 
		" and id ", [n, q, k]);
	
	info := RecognitionAbsolutelyIrreducibleSolvableMatrixGroup (G, full, full);
	if info.id <> [n, q, k] then
		Error ("wrong id");
	fi;
	if full and IdAbsolutelyIrreducibleSolvableMatrixGroup (info.group) <> [n, q, k] then
		Error ("wrong of group");
	fi;
	if full and G^info.mat <> info.group then
		Error ("groups are not conjugate");
	fi;
end;

	
RecognizeRandomIrred := function (n, q, full)

	local k, d, G, info;
	
	d := Random (DivisorsInt (n));
	k := Random ([1.. NumberIrreducibleSolvableMatrixGroups(n, q, d)]);
	G := RandomIrreducibleSolvableMatrixGroup (n, q, d, k);
	Info (InfoIrredsol, 1, "testing group identification for group of order ", Order (G), 
		" and id ", [n, q, d, k]);
	
	info := RecognitionIrreducibleSolvableMatrixGroup (G, false, full);
	if info.id <> [n, q, d, k] then
		Error ("wrong id");
	fi;
	if full and IdIrreducibleSolvableMatrixGroup (info.group) <> [n, q, d, k] then
		Error ("wrong of group");
	fi;
	#if full and G^info.mat <> info.group then
	#	Error ("groups are not conjugate");
	#fi;
end;

	