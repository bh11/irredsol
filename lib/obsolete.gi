############################################################################
##
##  access.gd                     IRREDSOL                  Burkhard Höfling
##
##  Copyright © 2003–2016 Burkhard Höfling
##


############################################################################
##
#F  IndicesAbsolutelyIrreducibleSolubleMatrixGroups(<n>, <q>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction(IndicesAbsolutelyIrreducibleSolubleMatrixGroups,
    function(n, q)
        Info(InfoWarning, 1, "Obsolete function. See ?IndicesAbsolutelyIrreducibleSolubleMatrixGroups.");
        return IndicesIrreducibleSolubleMatrixGroups(n, q, 1);
    end);


############################################################################
##
#F  AbsolutelyIrreducibleSolubleMatrixGroup(<n>, <q>, <k>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction(AbsolutelyIrreducibleSolubleMatrixGroup,
    function(n, q, k)
        Info(InfoWarning, 1, "Obsolete function. See ? AbsolutelyIrreducibleSolubleMatrixGroup.");
        return IrreducibleSolubleMatrixGroup(n, q, 1, k);
    end);


############################################################################
##
#F  RecognitionAbsolutelyIrreducibleSolubleMatrixGroup(G, wantmat, wantgroup)
##
##  see the IRREDSOL manual
##
InstallGlobalFunction(RecognitionAbsolutelyIrreducibleSolubleMatrixGroup,
    function(G, wantmat, wantgroup)
        local r;
        Info(InfoWarning, 1, "Obsolete function. See ? RecognitionAbsolutelyIrreducibleSolubleMatrixGroup.");
        r := RecognitionIrreducibleSolubleMatrixGroup(G, wantmat, wantgroup);
        if r.id[3] <> 1 then
            Error("G is not absolutely irreducible");
        fi;
        r.id := r.id{[1,2,4]};
        return r;
    end);


############################################################################
##
#F  RecognitionAbsolutelyIrreducibleSolubleMatrixGroupNC(G, wantmat, wantgroup)
##
##  see the IRREDSOL manual
##
InstallGlobalFunction(RecognitionAbsolutelyIrreducibleSolubleMatrixGroupNC,
    function(G, wantmat, wantgroup)
        local r;
        Info(InfoWarning, 1, "Obsolete function. See ? RecognitionAbsolutelyIrreducibleSolubleMatrixGroupNC.");
        r := RecognitionIrreducibleSolubleMatrixGroupNC(G, wantmat, wantgroup);
        if r <> fail then
            if r.id[3] <> 1 then
                Error("G is not absolutely irreducible");
            fi;
            r.id := r.id{[1,2,4]};
        fi;
        return r;
    end);


############################################################################
##
#A  IdAbsolutelyIrreducibleSolubleMatrixGroup(<G>)
##
##  see the IRREDSOL manual
##  
InstallGlobalFunction("IdAbsolutelyIrreducibleSolubleMatrixGroup",
    function(G)
        local r;
        Info(InfoWarning, 1, "Obsolete function. See ? IdAbsolutelyIrreducibleSolubleMatrixGroup.");
        r := IdIrreducibleSolubleMatrixGroup(G, false, false);
        if r[3] <> 1 then
            Error("G is not absolutely irreducible");
        fi;
        return r{[1,2,4]};
    end);
    

############################################################################
##
#E
##
