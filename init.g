############################################################################
##
##  init.g                       IRREDSOL                  Burkhard Höfling
##
##  Copyright © Burkhard Höfling (burkhard@hoefling.name)
##

BindGlobal ("IRREDSOL_Read", function (path)
    if not ReadPackage("irredsol", path) then
        Error("IRREDSOL package: Can't read file ",path, ". The package may be damaged");
    fi;
end);
IRREDSOL_Read("lib/util.g");
IRREDSOL_Read("lib/util.gd");
IRREDSOL_Read("lib/matmeths.gd");
IRREDSOL_Read("lib/loading.gd");
IRREDSOL_Read("lib/loadfp.gd");
IRREDSOL_Read("lib/access.gd");
IRREDSOL_Read("lib/iterators.gd");
IRREDSOL_Read("lib/recognize.gd");
IRREDSOL_Read("lib/primitive.gd");
IRREDSOL_Read("lib/recognizeprim.gd");
IRREDSOL_Read("lib/obsolete.gd");


############################################################################
##
#E
##
