#!/bin/bash
#set -e
#set -u
#set -o pipefail

#This shell script uses the same structure as summarizeSNaQres.sh
#It will produce a table in csv format with one row per analysis, 
#including the same columns as before and also including additional columns:
#4)Nruns, 5) Nfail, 6) fabs, 7) frel, 8) xabs, 9) xrel, 10) seed, 
#11) under3460, 12) under3450, 13) under3440
#We will append these columns to the existing .csv file


#1) Run summarizeSNaQres.sh script to update summary.csv (to which we will append new columns)

source scripts/summarizeSNaQres.sh


#1)a) Set targets for calculationsi and create empty csv's to append to
target3460=3460
target3450=3450
target3440=3440

touch output/under3460.csv
touch output/under3450.csv
touch output/under3440.csv

#b) Set Global Files
FILES=`find data/log -name "*.???"`

#2) Extract necessary data
for file in *.???
do
  #Extract features
  grep "seconds in" data/out/$file | awk '{ print $7 }' > output/Nruns.csv
  grep "max number of failed proposals" data/log/$file | awk '{ print $8 }' | cut -d, -f1 > output/Nfail.csv
  grep "ftolAbs=" data/log/$file | awk '{ print $5 }' | cut -d, -f1 | cut -d= -f2 > output/fabs.csv
  grep "ftolRel=" data/log/$file | awk '{ print $4 }' | cut -d, -f1 | cut -d= -f2 > output/frel.csv
  grep "xtolAbs=" data/log/$file | awk '{ print $2}' | cut -d, -f1 | cut -d= -f2 > output/xabs.csv
  grep "xtolRel=" data/log/$file | awk '{ print $3 }' | cut -d, -f1 | cut -d= -f2 > output/xrel.csv
  grep "main seed" data/log/$file | awk '{ print $3 }' > output/seed.csv
done


for file in $FILES
do
  #Count features
  under3460=0
  under3450=0
  under3440=0

  sed 's/_//g;s/P//g;s/N//g' $file > tmp
  exception=`basename -s ".log" $file`
  echo $exception

  if [ $exception == "net1_snaq" ]
  then
    proposedval=`grep "loglik=* of best " tmp | cut -d\s -f4 | tr -d " t" | bc`
  else
    proposedval=`grep "loglik=*\ of best " tmp | cut -d\s -f2 | tr -d " t" | bc`
  fi

  for val in $proposedval
  do
    mynum=`echo $val | awk ' { print $1 } '`
    truth3460=`echo $mynum " < $target3460" | bc`
    truth3450=`echo $mynum " < $target3450" | bc`
    truth3440=`echo $mynum " < $target3440" | bc`
    under3460=$(($under3460+$truth3460))
    under3450=$(($under3450+$truth3450))
    under3440=$(($under3440+$truth3440))
  done
  echo $under3460 >> output/under3460.csv 
  echo $under3450 >> output/under3450.csv
  echo $under3440 >> output/under3440.csv
done


#4) Merging

##Merge in new files into 1
paste -d , output/Nruns.csv output/Nfail.csv output/fabs.csv output/frel.csv output/xabs.csv output/xrel.csv output/seed.csv output/under3460.csv output/under3450.csv output/under3440.csv > output/ex3_summary.csv

##Add in headers to this file
sed 1i"Nruns,Nfail,fabs,frel,xabs,xrel,seed,under3460,under3450,under3440" output/ex3_summary.csv > output/ex3_headers.csv

##Append old summary and new summary
paste -d, output/summaryFiles/master.csv output/ex3_headers.csv > output/summaryFiles/ex3_master.csv


##Remove unnecessary files
rm output/*.csv

