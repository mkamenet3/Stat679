#This shell script will begin the summary of the results of these analyses.
#It will be in a .csv format and will contain 1 row per analysis and 3 columns,
#each of which is 1) analysis, 2) 'h', and 3) "CPUtime"
#This script should be run out of the 'hw1' directory




#1) Create intermediate files
touch output/analysis.csv
touch output/hmax.csv
touch output/CPUtime.csv

#2) Extract

for file in timetest* 
  do 
    echo data/log/$file | grep -Eo 'timetest[0-9][0-9]' >>  output/analysis.csv
    grep "hmax =" data/log/$file | awk '{ print $4 }' | grep -Eo '[0-9]|[0-9][0-9]'>> output/hmax.csv
    grep "Elapsed time: " data/out/$file | awk '{ print $4 }'  >> output/CPUtime.csv
done


#3) Combine intermediate files into master, clean master, add headers, delete
#intermediate files  

##Combine into master
paste -d , output/analysis.csv output/hmax.csv output/CPUtime.csv > output/summary.csv

##Add headers to master
sed 1i"analysis,h,CPUtime" output/summary.csv > output/summaryFiles/master.csv

##remove unnecessary files
rm output/analysis.csv output/hmax.csv output/CPUtime.csv output/summary.csv





























