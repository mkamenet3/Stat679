# Stat679 - Homework 1

Data for this assignment was obtained from the course repo. It was copied (cp)
from that repo to the 'data' folder. The 'data' folder has sub-folders 'log'
and 'out', which contain .log and .out files, respectively. 


All scripts should be run from the main 'hw1' directory. 

Final output is deposited into the 'output/summaryFiles' directory as .csv
files.

##The Exercises


1. Create a shell script `normalizeFileNames.sh` to change all file names
   `timetesty_snaq.log` to `timetest0y_snaq.log` where "y" is a digit between 1 and 9.
   Similarly, change `timetesty_snaq.out` to `timetest0y_snaq.out`.

2. Create a shell script `summarizeSNaQres.sh` to start a summary of the results
   from all these analyses. The script should produce a table in `csv` format,
   with 1 row per analysis and 3 columns:

   - "analysis": the file name root ("xxx")
   - "h": the maximum number of hybridizations allowed during the analysis: `hmax`
   - "CPUtime": total CPU time, or "Elapsed time".

   Hint: start with a single command to extract one piece only (like h) for
   a single analysis. Then wrap it in a loop to apply this command to all
   analyses.

3. Create a script to summarize the results with more information.
   The script should produce a table in `csv` format with 1 row per analysis,
   the same columns as before and additional columns for:

   - Nruns: number of runs
   - Nfail: tuning parameter, "max number of failed proposals"
   - fabs: tuning parameter called "ftolAbs" in the log file (tolerated
     difference in the absolute value of the score function, to stop the search)
   - frel: "ftolRel"
   - xabs: "xtolAbs"
   - xrel: "xtolRel"
   - seed: main seed, i.e. seed for the first runs
   - under3460: number of runs that returned a network with a score better than
     (below) 3460
   - under3450: number of runs with a network score under 3450
   - under3440: number of runs with a network score under 3440






