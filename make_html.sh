rm htm/CHAP???.htm
rm htm/biblio.htm
rm htm/theindex.htm
rm htm/chapters.htm
perl ../../etc/convert.pl -n IRREDSOL -c -i doc htm
chmod -R a+r htm
