SHELL=/bin/bash
VERSION=dev
DATE=$(shell echo `date "+%d/%m/%Y"`)
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
    primitive.tex recognition.tex
    
manexts=.bbl .ind .idx .six .pdf .ist .toc \
    .example-2.tst .example-3.tst .example-4.tst .example-5.tst

testfiles=testall.g # we wrap *.tst as well

tarfile=irredsol/irredsol-$(VERSION).tar

taropts=-s /irredsol/irredsol-$(VERSION)/ -f

default: version manual

dist: testver version manual tar

testver:
	if [ "$(tarfile)" == "irredsol/irredsol-dev.tar" ]; \
		then echo "Please define VERSION in make call"; \
        exit 1; \
	fi

version:
	for file in README.in index.in.html PackageInfo.in.g doc/manual.in.tex; \
	do \
		outfile=$${file%.in*}$${file#*.in}; \
		rm -f $$outfile; \
		sed -e "s/IRREDSOL_VERSION/$(VERSION)/g" \
		-e "s-IRREDSOL_DATE-$(DATE)-"  \
		-e "s-GAPROOT-$(TEXROOT)-" \
		-e "s-PKGROOT-$(TEXPKGROOT)-" \
			$$file \
			> $$outfile; \
		chmod a-w $$outfile; \
	done

manual.pdf:
	cd doc; \
	pdftex manual; \
	makeindex -s manual.ist manual; \
	bibtex manual; \
	pdftex manual; \
	pdftex manual

manual.html:
	mkdir -p htm; \
	rm -f htm/CHAP00?.htm; \
	perl $(GAPROOT)/etc/convert.pl -n IRREDSOL -c -i doc htm; \
	chmod -R a+r htm \

manual: manual.pdf manual.html

tar: version
	export COPY_EXTENDED_ATTRIBUTES_DISABLE=1; \
	export COPYFILE_DISABLE=1; \
	cd ../; \
	rm -f $(tarfile); \
	rm -f $(tarfile).bz2; \
	chmod -R a+rX irredsol; \
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
	for file in irredsol/data/*.grp; \
		do tar -r $(taropts) $(tarfile) $$file; \
	done; \
	for file in irredsol/fp/*.idx; \
		do tar -r $(taropts) $(tarfile) $$file; \
	done; \
	for file in irredsol/fp/*.fp; \
		do tar -r $(taropts) $(tarfile) $$file; \
	done; \
	tar -r $(taropts) $(tarfile) irredsol/README; \
	tar -r $(taropts) $(tarfile) irredsol/LICENSE; \
	bzip2 $(tarfile)

testinstall:
teststandard:
testall:
	echo 'Read("tst/testall.g");quit;' | gap $(TESTOPTS)

testrenormalise:
	echo 'Read("tst/renormalise.g");quit;' | gap $(TESTOPTS)

