#!/bin/bash
tarfile=irredsol/irredsol-$1.tar
if [ "$tarfile" = "irredsol/irredsol-.tar" ]; then
   echo "Version number expected"
   exit
fi

taropts1="-c -s /irredsol/irredsol-$1/ -f"
taropts="-r -s /irredsol/irredsol-$1/ -f"

# this suppresses extended attributes in tarballs
export COPY_EXTENDED_ATTRIBUTES_DISABLE=1
export COPYFILE_DISABLE=1

cd ../
rm -f $tarfile
rm -f $tarfile.bz2
chmod -R a+rX irredsol

libfiles="access.gd access.gi iterators.gd iterators.gi loadfp.gd loadfp.gi \
   loading.gd loading.gi matmeths.gd matmeths.gi primitive.gd primitive.gi \
   recognize.gd recognize.gi recognizeprim.gd recognizeprim.gi \
   util.g util.gd util.gi obsolete.gd obsolete.gi"

docfiles="manual.tex copyright.tex overview.tex access.tex matgroups.tex \
    primitive.tex recognition.tex"
    
manexts=".bbl .ind .idx .six .pdf .ist .toc \
    .example-2.tst .example-3.tst .example-4.tst .example-5.tst"

testfiles="test.tst"

tar $taropts1 $tarfile irredsol/PackageInfo.g
tar $taropts $tarfile irredsol/init.g
tar $taropts $tarfile irredsol/read.g

for file  in $libfiles
   do tar $taropts $tarfile irredsol/lib/$file
done

for file in $docfiles
   do tar $taropts $tarfile irredsol/doc/$file
done

for ext in $manexts
   do tar $taropts $tarfile irredsol/doc/manual$ext
done

for file in $testfiles
   do tar $taropts $tarfile irredsol/tst/$file
done

for file in irredsol/html/*.htm
	do tar $taropts $tarfile $file
done

for file in irredsol/data/*.grp
	do tar $taropts $tarfile $file
done

for file in irredsol/fp/*.idx
	do tar $taropts $tarfile $file
done

for file in irredsol/fp/*.fp
	do tar $taropts $tarfile $file
done

tar $taropts $tarfile irredsol/README
tar $taropts $tarfile irredsol/LICENSE

bzip2 $tarfile 




