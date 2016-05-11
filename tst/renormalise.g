############################################################################
##
##  renormalise.g                  IRREDSOL                 Burkhard Höfling
##
##  Copyright © 2016 Burkhard Höfling
##
LoadPackage("irredsol", "", false);
TestDirectory(DirectoriesPackageLibrary("irredsol", "tst"),
    rec(renormaliseStones := true, exitGAP := true));

############################################################################
##
#E
##
