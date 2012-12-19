#! /bin/sh
cd doc
pdftex manual
makeindex -s manual.ist manual
bibtex manual
pdftex manual
pdftex manual
cd ..

 

