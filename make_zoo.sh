#!/bin/csh
cd ../
rm irredsol.zoo
chmod -R a+rX irredsol

set libfiles = (access.gd access.gi iterators.gd iterators.gi loadfp.gd loadfp.gi \
   loading.gd loading.gi matmeths.gd matmeths.gi primitive.gd primitive.gi \
   recognize.gd recognize.gi util.gd util.gi)

set docfiles = (manual.tex overview.tex access.tex matgroups.tex \
    primitive.tex recognition.tex)
    
set manfiles = (.bbl .ind .idx .six .dvi .pdf)

set testfiles = (test.tst testload.g)

zoo ach irredsol irredsol/PackageInfo.g <irredsol/text_comment
zoo ach irredsol irredsol/init.g <irredsol/text_comment
zoo ach irredsol irredsol/read.g <irredsol/text_comment

foreach file ($libfiles)
   zoo ach irredsol irredsol/lib/$file <irredsol/text_comment
end

foreach file ($docfiles)
   zoo ach irredsol irredsol/doc/$file <irredsol/text_comment
end

foreach file ($manfiles)
   zoo ach irredsol irredsol/doc/manual$file <irredsol/text_comment
end

foreach file ($testfiles)
   zoo ach irredsol irredsol/tst/$file <irredsol/text_comment
end

foreach file (irredsol/htm/*)
	zoo ach irredsol $file <irredsol/text_comment
end

foreach file (irredsol/grp/*)
	zoo ach irredsol $file <irredsol/text_comment
end

foreach file (irredsol/fp/*.idx)
	zoo ach irredsol $file <irredsol/text_comment
end

foreach file (irredsol/fp/*.fp)
	zoo ach irredsol $file <irredsol/text_comment
end

zoo ach irredsol irredsol/README <irredsol/text_comment


mv irredsol.zoo irredsol/irredsol-$1.zoo


