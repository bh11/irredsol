#! /bin/csh
cd ../
rm irredsol.zoo
set libfiles = (access.gd access.gi iterators.gd iterators.gi loadfp.gd loadfp.gi \
   loading.gd loading.gi matmeths.gd matmeths.gi recognize.gd recognize.gi \
   util.gd util.gi)

set docfiles = (manual.tex overview.tex access.tex matgroups.tex recognition.tex)
set manfiles = (.bbl .ind .idx .six .dvi .pdf)

set testfiles = ()

zoo ach irredsol irredsol/PackageInfo.g <irredsol/text_comment
zoo ach irredsol irredsol/init.g <irredsol/text_comment
zoo ach irredsol irredsol/read.g <irredsol/text_comment

for file ($libfiles)
   zoo ach irredsol irredsol/lib/$file <irredsol/text_comment
end

for file ($docfiles)
   zoo ach irredsol irredsol/doc/$file <irredsol/text_comment
end

for file ($manfiles)
   zoo ach irredsol irredsol/doc/manual$file <irredsol/text_comment
end

for file ($testfiles)
   zoo ach irredsol irredsol/tst/$file <irredsol/text_comment
end

for file (/htm/*)
	zoo ach irredsol irredsol/$file <irredsol/text_comment
end

for file (/data/*)
	zoo ach irredsol irredsol/$file <irredsol/text_comment
end

for file (/fps/*)
	zoo ach irredsol irredsol/$file <irredsol/text_comment
end

zoo ach irredsol irredsol/README <irredsol/text_comment
