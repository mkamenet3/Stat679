#This shell script will begin the summary of the results of these analyses.
#It will be in a .csv format and will contain 1 row per analysis and 3 columns,
#each of which is 1) analysis, 2) 'h', and 3) "CPUtime"




#1) Create intermediate files
touch analysis.csv
touch hmax.csv
touch CPUtime.csv

#2) Extract

for file in timetest* 
  do 
    echo log/$file | grep -Eo 'timetest[0-9][0-9]' >>  analysis.csv
    grep "hmax =" log/$file | awk '{ print $4 }' | grep -Eo '[0-9]|[0-9][0-9]'>> hmax.csv
    grep "Elapsed time: " out/$file | awk '{ print $4 }'  >> CPUtime.csv
done


#3) Combine intermediate files into master, clean master, add headers, delete
#intermediate files  

##Combine into master
paste -d , analysis.csv hmax.csv CPUtime.csv > summary.csv

##Add headers to master
sed 1i"analysis,h,CPUtime" summary.csv > summaryFiles/master.csv

##remove unnecessary files
rm analysis.csv hmax.csv CPUtime.csv summary.csv





























