SHELL=/bin/bash
VERSION=dev
libfiles=access.gd access.gi iterators.gd iterators.gi loadfp.gd loadfp.gi \
   loading.gd loading.gi matmeths.gd matmeths.gi primitive.gd primitive.gi \
   recognize.gd recognize.gi recognizeprim.gd recognizeprim.gi \
   util.g util.gd util.gi obsolete.gd obsolete.gi

docfiles=manual.tex copyright.tex overview.tex access.tex matgroups.tex \
    primitive.tex recognition.tex
    
manexts=.bbl .ind .idx .six .pdf .ist .toc \
    .example-2.tst .example-3.tst .example-4.tst .example-5.tst

testfiles=test.tst

tarfile=irredsol/irredsol-$(VERSION).tar

taropts=-s /irredsol/irredsol-$(VERSION)/ -f

manual.pdf:
	( \
			cd doc; \
			pdftex manual; \
			makeindex -s manual.ist manual; \
			pdftex manual; \
			pdftex manual \
	)

manual.html:
	( \
			rm htm/CHAP???.htm; \
			rm htm/biblio.htm; \
			rm htm/theindex.htm; \
			rm htm/chapters.htm; \
			perl ../../etc/convert.pl -n IRREDSOL -c -i doc htm; \
			chmod -R a+r htm \
	)

manual: manual.pdf manual.html

tar: manual
	( \
		if [ "$(tarfile)" = "irredsol/irredsol-.tar" ]; then\
		   echo "Version number expected"; \
		   exit; \
		fi; \
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
		bzip2 $(tarfile) \
	)


