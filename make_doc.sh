#! /bin/sh
cd doc
tex manual
makeindex manual
bibtex manual.aux
tex manual
tex manual
pdftex manual
pdftex manual
cd ..

 

