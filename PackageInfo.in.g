#############################################################################
##  
##  PackageInfo.g                 IRREDSOL                  Burkhard Höfling
##
##  Copyright © Burkhard Höfling (burkhard@hoefling.name)
##


SetPackageInfo( rec(

##  This is case sensitive, use your preferred spelling.

PackageName := "IRREDSOL",
Subtitle := "A library of irreducible soluble linear groups over finite fields and of finite primivite soluble groups",
##  See '?Extending: Version Numbers' in GAP help for an explanation
##  of valid version numbers.
Version := "IRREDSOL_VERSION",

##  Release date of the current version in dd/mm/yyyy format.
Date := "IRREDSOL_DATE",

##  Machine readable license information (as an SPDX identifier)
License := "BSD-2-Clause",

BannerString := "\
----------------------------------------------------------------------\n\
                          IRREDSOL Version IRREDSOL_VERSION\n\
  A library of irreducible soluble linear groups over finite fields\n\
                and of finite primivite soluble groups\n\
                         by Burkhard Höfling\n\
----------------------------------------------------------------------\n",
##  URL of the archive(s) of the current package release, but *without*
##  the format extension(s), like '.zoo', which are given next.
##  The archive file name *must be changed* with each version of the archive
##  (and probably somehow contain the package name and version).
ArchiveURL := "https://github.com/bh11/irredsol/releases/download/IRREDSOL-IRREDSOL_VERSION/irredsol-IRREDSOL_VERSION",

ArchiveFormats := ".tar.bz2", # the others are generated automatically

TextBinaryFilesPatterns := [ "B*.pdf", "T*" ],

Persons := [
  rec(
  LastName := "Höfling",
  FirstNames := "Burkhard",
  IsAuthor := true,
  IsMaintainer := true,
  WWWHome := "http://www.icm.tu-bs.de/~bhoeflin",
  Email := "b.hoefling@tu-bs.de"
  )
],

Status := "accepted",

CommunicatedBy := "Gerhard Hiss (Aachen)",
AcceptDate := "08/2006",

README_URL := "https://github.com/bh11/irredsol/releases/latest/download/README.txt",
PackageInfoURL := "https://github.com/bh11/irredsol/releases/latest/download/PackageInfo.g",

AbstractHTML := "The <span class=\"pkgname\">GAP</span> package <span \
class=\"pkgname\">IRREDSOL</span> provides a library of all \
irreducible soluble subgroups of <i>GL(n,q)</i>, up to conjugacy, \
for <i>q<sup>n</sup></i> up to 2^24-1, \
and a library of the primitive soluble groups of degree up to 2^24-1.",

PackageWWWHome := "http://www.icm.tu-bs.de/~bhoeflin/irredsol/index.html",
                  
PackageDoc := rec(
  BookName := "irredsol",
  # format/extension can be one of .zoo, .tar.gz, .tar.bz2, -win.zip
  ArchiveURLSubset := ["doc", "htm"],
  HTMLStart := "htm/chapters.htm",
  PDFFile := "doc/manual.pdf",
  # the path to the .six file used by GAP's help system
  SixFile := "doc/manual.six",
  # a longer title of the book, this together with the book name should
  # fit on a single text line (appears with the '?books' command in GAP)
  LongTitle := "A library of irreducible soluble linear groups over finite fields",
),


##  Are there restrictions on the operating system for this package? Or does
##  the package need other packages to be available?
Dependencies := rec(
  GAP := ">=4.9",
  NeededOtherPackages := [],
  SuggestedOtherPackages := [["crisp", ">=1.3"]],
  ExternalConditions := []
                      
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

# Keywords := ["Smith normal form", "p-adic", "rational matrix inversion"]
Keywords := ["linear group", "matrix group", "irreducible matrix group",
   "absolutely irreducible matrix group",
   "soluble group", "soluble group",
   "library", "data base",
   "matrix group recognition", "conjugacy of matrix groups",
   "finite field", "trace field"],

SourceRepository := rec(Type := "git",
                        URL := "https://github.com/bh11/irredsol.git"),

IssueTrackerURL := "https://github.com/bh11/irredsol/issues"

));


