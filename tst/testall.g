############################################################################
##
##  testall.g                       IRREDSOL                Burkhard Höfling
##
##  Copyright © 2016 Burkhard Höfling
##
LoadPackage("irredsol", "", false);
if TestDirectory(DirectoriesPackageLibrary("irredsol", "tst")) then
    Print("#I  No errors detected while testing package IRREDSOL\n");
else
    Print("#I  Errors detected while testing package IRREDSOL\n");
fi;

############################################################################
##
#E
##
