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
    echo log/$file >>  analysis.csv
    grep "hmax =" log/$file | awk '{ print $4 }' >> hmax.csv
    grep "Elapsed time: " out/$file | awk '{ print $4 }'  >> CPUtime.csv
done


#3) Combine intermediate files into master, clean master, add headers, delete
#intermediate files  

##Combine into master
paste -d , analysis.csv hmax.csv CPUtime.csv > summary.csv

##Add headers to master
sed 1i"analysis,h,CPUtime" summary.csv > master.csv

##remove unnecessary files
rm analysis.csv hmax.csv CPUtime.csv summary.csv



#paste -d , test.csv test2.csv > testcombind.csv
##this will create csv with what I need
##so i can create a bunch of intermediate csvs, pipe into master, and then
#remove them


#grep "Elapsed time: " out/timetest02_snaq.out | awk '{ print $3 }'

#grep "hmax =" log/timetest02_snaq.log | awk '{ print $3 }'

#echo log/timetest02_snaq.log


#add in header: sed 1i"head1,head2" test2.csv > new.csv

#cat testMaster.csv  >> test4.csv






























