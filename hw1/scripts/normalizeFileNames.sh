#This shell scropt will change the file names from timetesty_snaw.log to
#timetest0y_snaq.log, where "y" is a digit between 1 and 9.
#The .out files will be changed similarly as well.




#1) Change .log files to include '0' before single digit
for logfile in log/timetest?_snaq.log
 do mv "$logfile" "${logfile/est/est0}"
done




#2) Change .out files to include '0' before single digit  

for outfile in out/timetest?_snaq.out
  do mv "$outfile" "${outfile/est/est0}"
done






