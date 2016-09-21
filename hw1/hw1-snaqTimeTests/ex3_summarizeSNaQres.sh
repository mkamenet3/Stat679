#This shell script uses the same structure as summarizeSNaQres.sh
#It will produce a table in csv format with one row per analysis, 
#including the same columns as before and also including additional columns:
#4)Nruns, 5) Nfail, 6) fabs, 7) frel, 8) xabs, 9) xrel, 10) seed, 
#11) under3460, 12) under3450, 13) under3440
#We will append these columns to the existing .csv file


#1) Run summarizeSNaQres.sh script to update summary.csv (to which we will append new columns)

source summarizeSNaQres.sh


#2) Create intermediate files
for file in Nruns Nfail fabs frel xabs xrel seed under3460 under3450 under3440
  do touch $file.csv
done

#2)a) Set targets for calculations
target3460=3460
target3450=3450
target3440=3440

#3) Extract necessary data
for file in timetest*
do
  echo log/$file | grep -Eo '[0-9][0-9]' #just so we can see what's going on
  #and there are no mismatched files
  echo out/$file | grep -Eo '[0-9][0-9]'
  grep "seconds in" out/$file | awk '{ print $7 }' >> Nruns.csv
  grep "max number of failed proposals" log/$file | awk '{ print $8 }' | cut -d, -f1>> Nfail.csv
  grep "ftolAbs=" log/$file | awk '{ print $5 }' | cut -d, -f1 | cut -d= -f2 >> fabs.csv
  grep "ftolRel=" log/$file | awk '{ print $4 }' | cut -d, -f1 | cut -d= -f2 >> frel.csv
  grep "xtolAbs=" log/$file | awk '{ print $2}' | cut -d, -f1 | cut -d= -f2 >> xabs.csv
  grep "xtolRel=" log/$file | awk '{ print $3 }' | cut -d, -f1 | cut -d= -f2 >> xrel.csv
  grep "main seed" log/$file | awk '{ print $3 }' >> seed.csv
  grep "loglik=*\ of best " log/$file | cut -d\s -f2 | tr -d " t" | bc | awk '$1<=$target3460{count++}END{print ""count}' >> under3460.csv
  grep "loglik=*\ of best " log/$file | cut -d\s -f2 | tr -d " t" | bc | awk '$1<=$target3450{count++}END{print ""count}' >> under3450.csv
  grep "loglik=*\ of best " log/$file | cut -d\s -f2 | tr -d " t" | bc | awk '$1<=$target3440{count++}END{print ""count}' >> under3460.csv
done


#4) Merging

##Merge in new files into 1
paste -d , Nruns.csv Nfail.csv fabs.csv frel.csv xabs.csv xrel.csv seed.csv under3460.csv under3450.csv under3440.csv > ex3_summary.csv

##Add in headers to this file
sed 1i"Nruns,Nfail,fabs,frel,xabs,xrel,seed,under3460,under3450,under3440" ex3_summary.csv > ex3_headers.csv

##Append old summary and new summary
paste -d, summaryFiles/master.csv ex3_headers.csv > summaryFiles/ex3_master.csv


##Remove unnecessary files
rm *.csv





























