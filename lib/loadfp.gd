############################################################################
##
##  loadfp.gd                    IRREDSOL                 Burkhard H\"ofling
##
##  @(#)$Id$
##
##  Copyright (C) 2003 by Burkhard H\"ofling, 
##  Institut f\"ur Geometrie, Algebra und Diskrete Mathematik
##  Technische Universit\"at Braunschweig, Germany
##


############################################################################
##
#F  PathAbsolutelyIrreducibleSolvableGroupFingerprintIndex(<n>, <q>)
##
##  returns the path of the fingerprint database index file, or
##  fail if the file does not exist or is unreadable
##  
DeclareGlobalFunction ("PathAbsolutelyIrreducibleSolvableGroupFingerprintIndex");


############################################################################
##
#F  IsAvailableAbsolutelyIrreducibleSolvableGroupFingerprintIndex(<n>, <q>)
##
##  returns true if the fingerprint data index is available
##  
DeclareGlobalFunction ("IsAvailableAbsolutelyIrreducibleSolvableGroupFingerprintIndex");


############################################################################
##
#F  LoadAbsolutelyIrreducibleSolvableGroupFingerprintIndex(<n>, <q>)
##
##  loads the fingerprint database index file
##  
DeclareGlobalFunction ("LoadAbsolutelyIrreducibleSolvableGroupFingerprintIndex");


############################################################################
##
#F  PathAbsolutelyIrreducibleSolvableGroupFingerprint(<n>, <q>, <k>)
##
##  returns the path to the k-th fingerprint data file for GL(n,q), 
##  if it exists and is readable, or fail otherwise.
##  
DeclareGlobalFunction ("PathAbsolutelyIrreducibleSolvableGroupFingerprint");


###########################################################################
##
#F  IsAvailableAbsolutelyIrreducibleSolvableGroupFingerprint(<n>, <q>, <o>)
##
##  returns true if the fingerprint data file for subgroups of order o of
##  GL(n,q) exists and is readable
##
##  Note that there is no fingerprint information for groups of order o
##  if there is only one group of order o in the IRREDSOL library
##  
DeclareGlobalFunction ("IsAvailableAbsolutelyIrreducibleSolvableGroupFingerprint");


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
DeclareGlobalFunction ("AbsolutelyIrreducibleSolvableGroupFingerprintData");


###########################################################################
##
#F  UnloadAbsolutelyIrreducibleSolvableGroupFingerprints(<arg>)
##
##  see IRREDSOL documentation
##  
DeclareGlobalFunction ("UnloadAbsolutelyIrreducibleSolvableGroupFingerprints");


###########################################################################
##
#F  LoadedAbsolutelyIrreducibleSolvableGroupFingerprints(<arg>)
##
##  see IRREDSOL documentation
##  
DeclareGlobalFunction ("LoadedAbsolutelyIrreducibleSolvableGroupFingerprints");


###########################################################################
##
#E
##