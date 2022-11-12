SHELL=/bin/bash
VERSION=1.4.dev
DATE=$(shell echo `date "+%d/%m/%Y"`)
YEAR=$(shell echo `date "+%Y"`)
GAPROOT=../..
PKGROOT=..
TESTOPTS=-b -m 100m -o 1g -A -q -x 80

ifeq ("$(shell tmp=$(GAPROOT); echo $${tmp:0:1})", "/")
	TEXROOT="$(GAPROOT)"
else 
	TEXROOT="../$(GAPROOT)"
endif 

ifeq ("$(shell tmp=$(PKGROOT); echo $${tmp:0:1})", "/")
	TEXPKGROOT="$(PKGROOT)"
else 
	TEXPKGROOT ="../$(PKGROOT)"
endif 


libfiles=access.gd access.gi iterators.gd iterators.gi loadfp.gd loadfp.gi \
   loading.gd loading.gi matmeths.gd matmeths.gi primitive.gd primitive.gi \
   recognize.gd recognize.gi recognizeprim.gd recognizeprim.gi \
   util.g util.gd util.gi obsolete.gd obsolete.gi

docfiles=manual.tex copyright.tex overview.tex access.tex matgroups.tex \
    primitive.tex recognition.tex versions.tex
    
manexts=.bbl .ind .idx .six .pdf .mst .toc \
    .example-2.tst .example-3.tst .example-4.tst .example-5.tst

testfiles=testall.g randomirred.g # we wrap *.tst as well

update_files=README.in.txt index.in.html PackageInfo.in.g doc/manual.in.tex LICENSE.in.txt


tarfile=irredsol/irredsol-$(VERSION).tar

taropts=-s /irredsol/irredsol-$(VERSION)/ -f

default: update_in

release: dist

dist: testver update_in manual tar

testver:
	if [ "$(tarfile)" == "irredsol/irredsol-dev.tar" ]; \
		then echo "Please define VERSION in make call"; \
        exit 1; \
	fi

update_in:
	for file in $(update_files); \
	do \
		outfile=$${file%.in*}$${file#*.in}; \
		rm -f $$outfile; \
		sed -e "s%IRREDSOL_VERSION%$(VERSION)%g" \
		-e "s%IRREDSOL_DATE%$(DATE)%"  \
		-e "s%IRREDSOL_YEAR%$(YEAR)%"  \
		-e "s%\\\\GAPROOT%$(TEXROOT)%" \
		-e "s%\\\\PKGROOT%$(TEXPKGROOT)%" \
			$$file \
			> $$outfile; \
		chmod a-w $$outfile; \
	done

manual.pdf: update_in
	cd doc; \
	pdftex manual; \
	makeindex -s manual.mst manual; \
	bibtex manual; \
	pdftex manual; \
	pdftex manual

manual.html:
	mkdir -p htm; \
	rm -f htm/CHAP00?.htm; \
	perl $(GAPROOT)/etc/convert.pl -n IRREDSOL -c -i -u doc htm; \
	chmod -R a+r htm \

manual: manual.pdf manual.html

tar: update_in
	export COPY_EXTENDED_ATTRIBUTES_DISABLE=1; \
	export COPYFILE_DISABLE=1; \
	cd ../; \
	rm -f $(tarfile); \
	rm -f $(tarfile).bz2; \
	chmod -R a+rX irredsol; \
	chmod -R go-w irredsol; \
	for file in $(update_files); \
	do \
		outfile=$${file%.in*}$${file#*.in}; \
		chmod +w irredsol/$$outfile; \
	done; \
	tar -c $(taropts) $(tarfile) irredsol/PackageInfo.g; \
	tar -r $(taropts) $(tarfile) irredsol/init.g; \
	tar -r $(taropts) $(tarfile) irredsol/read.g; \
	for file in $(libfiles); \
		do tar -r $(taropts) $(tarfile) irredsol/lib/$$file; \
	done; \
	for file in $(docfiles); \
		do tar -r $(taropts) $(tarfile) irredsol/doc/$$file; \
	done; \
	for ext in $(manexts); \
		do tar -r $(taropts) $(tarfile) irredsol/doc/manual$$ext; \
	done; \
	for file in $(testfiles); \
		do tar -r $(taropts) $(tarfile) irredsol/tst/$$file; \
	done; \
	for file in irredsol/tst/*.tst; \
		do tar -r $(taropts) $(tarfile) $$file; \
	done; \
	for file in irredsol/htm/*.htm; \
		do tar -r $(taropts) $(tarfile) $$file; \
	done; \
	gzip -9 -f -k irredsol/data/*.grp; \
	for file in irredsol/data/*.grp.gz; \
		do tar -r $(taropts) $(tarfile) $$file; \
	done; \
	gzip -9 -f -k irredsol/fp/*.idx; \
	for file in irredsol/fp/*.idx.gz; \
		do tar -r $(taropts) $(tarfile) $$file; \
	done; \
	gzip -9 -f -k irredsol/fp/*.fp; \
	for file in irredsol/fp/*.fp.gz; \
		do tar -r $(taropts) $(tarfile) $$file; \
	done; \
	tar -r $(taropts) $(tarfile) irredsol/README.txt; \
	tar -r $(taropts) $(tarfile) irredsol/LICENSE.txt; \
	bzip2 $(tarfile); \
	for file in $(update_files); \
	do \
		outfile=$${file%.in*}$${file#*.in}; \
		chmod -w irredsol/$$outfile; \
	done; 

testinstall:
teststandard:
testall:
	gap $(TESTOPTS) tst/testall.g

coverage:
	mkdir -p private/coverage
	echo 'Read("tst/in.g");quit;' \
		| gap $(TESTOPTS) --cover private/coverage/cover.gz >/dev/null
	echo 'LoadPackage("profiling", "", false); \
		OutputAnnotatedCodeCoverageFiles("private/coverage/cover.gz", \
			Filename(DirectoriesPackageLibrary("crisp"), ""), \
			"private/coverage");' \
		| gap -b -q -A; \
	open private/coverage/index.html
	