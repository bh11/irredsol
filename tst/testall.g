############################################################################
##
##  testall.g                       IRREDSOL                Burkhard Höfling
##
##  Copyright © 2016 Burkhard Höfling
##
LoadPackage("irredsol", "", false);
TestDirectory(DirectoriesPackageLibrary("irredsol", "tst"),
    rec(exitGAP := true));

############################################################################
##
#E
##
