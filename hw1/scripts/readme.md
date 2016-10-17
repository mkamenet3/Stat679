##scripts

This folder houses the scripts for HW1 Exercises 1, 2, and 3.

The files in here are run from the main folder, hw1 as so: 
'source scripts/__scriptname__'

As the data files uploaded here have already been converted using the
normalizing script, in order to run the summarizing script, simply: 'source
scripts/ex3_summarizeSNaQres.sh' from the main 'hw1' directory.

The scripts found in this folder are:
- ex3_summarizeSNaQres.sh
- normalizeFileNames.sh
- summaraizeSNaQres.sh

Dependencies between _summarizeSnaQres.sh_ and _ex3summarizeSNaQres.sh_ have
been written. Exercise 3 was written up prior to the tag option. It builds upon
exercise 2 by sourcing that code and appending to it. I do not encode
dependence between summarizing and normalizing scripts, although this is
a natural extension for the future. The files uploaded here have already been
converted to have the appropriate file names to run with the summarizing
scripts. 

Code was written using cygwin shell.

In "scripts/ex3_summaraizeSNaQres.sh", I use multiple 'sed' statements to
temporarily find and replace an underscore, P, and N. This is due to the 'bc'
command I had to download externally for cygwin. My understanding is that
windows adds some ASCII characters and this somehow messes up casting from
character to numeric and results in errors. From reading online, this was
a workaround I found.

