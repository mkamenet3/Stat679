##scripts

This folder houses the scripts for HW1 Exercises 1, 2, and 3.

The files in here are run from the main folder, hw1 as so: 
'source scripts/__scriptname__'

The scripts found in this folder are:
- ex3_summarizeSNaQres.sh
- normalizeFileNames.sh
- summaraizeSNaQres.sh

Code was written using cygwin shell.

In "scripts/ex3_summaraizeSNaQres.sh", I use multiple 'sed' statements to
temporarily find and replace an underscore, P, and N. This is due to the 'bc'
command I had to download externally for cygwin. My understanding is that
windows adds some ASCII characters and this somehow messes up casting from
character to numeric and results in errors. From reading online, this was
a workaround I found.

