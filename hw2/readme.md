#Stat 679 - Homework 2

##Overview
###Data Acquisition
Data was downloaded from \url{https://github.com/UWMadison-computingtools/coursedata}. The repo was cloned and then files extracted using ```cp *.csv```. The .csv files for the assignment now reside in the **data** folder here for hw2. There should be two .csv files: $energy.csv$ and $waterTemperature.csv$.

Calling the script from the command line, user should be in the **hw2** directory. The particular script can also be run in conjunction with the call to code at the bottom.  If this repo is cloned, all folder structures will remain intact to enable the user to run the code as instructed here.

###The Build

Code was written in Python 3 on Cygwin shell.

###Structure
The folder structure is as follows:
- **data**: contains files waterTemperature.csv and energy.csv - the two inputs
- **output**: will contain the results of the merge. This will be a csv with either user-defined name or default $output.csv$ name
- **scripts**: contains $hw2_script.py$, which is the python file which performs the merge

###Running the Code
Be sure to start with an empty output directory first.
Code can be run in two ways.

Running code from the command line and accepting defaults:
```
./scripts/hw2_script.py
```
The defaults are that the waterTemperature.csv, energy.csv, and output files are hardcoded at the bottom of the call. If user wants to change what the name of the output file is or accept the default (output.csv), this needs to be changed inside script/hw2_script.py:

Where to change the inputs to the main call:
```
#Call with user-defined output file name
reformat_twofiles("data/waterTemperature.csv",
                  "data/energy.csv",
                  "output/merged_output.csv")
#OR

#Call with default:
reformat_twofiles("data/waterTemperature.csv",
                  "data/energy.csv")

```

Here, we specify the output file name to be "merged_output.csv"

We have included a feature where, if a file with the same name already exists in the directory, user will be prompted as to whether or not they want to overwrite that file. Input is either 'y' or 'n'. Single quotes are required (next iteration of code will allow user to input without quotes). Any other input in quotes will result in a break as will 'n'. Not using quotes will result in an error. Presently, this check only works for when there is a single file in the directory (will work any expanding this to if any of the files in the folder already exists with the proposed name).

For next steps, we will also allow user to call the python code from the command line and input file names as arguments.


##The Exercises

###Background (may be skipped)
----------

These data give an example of a common task, where data are collected
from different sources and at different rates, but need to be combined
for downstream analyses.
On the same roof, two different solar collector systems are installed,
one to heat water and the other to provide electricity.
Data are collected every month from each system:

- hot water: hourly data on the hot water *temperature*
- electricity: daily data on the *energy* produced by a photovoltaic system.

Merging data files from these 2 data loggers is necessary for downstream
analyses, such as correlation between the 2 systems. Doing any downstream
analysis is *not* the goal of the exercise.

The goal of the exercise is to produce a script that could be used monthly
to merge the 2 data files of the month, where the energy value from each day
is matched to the temperature value at the nearest time, with no need for any
manual copy-paste operation. The script is meant to be used repeatedly,
so it should accept 2 file names as arguments:
the names of the temperature file and of the energy file.


###data files
----------

This directory contains one file with water [temperature](waterTemperature.csv)
data and another file with [energy](energy.csv) data
(received by email on 2016-08-17).

###exercise
--------

Write a Python script that takes 2 file names as arguments, and creates
an output with the merged data, in csv format (comma-separated variables).

- The output should contain all of the information in the temperature file.
- The energy values in Wh should be divided by 1000 and written in an additional column.
- The energy value for a particular time should be matched with
  (placed on the same row as) the temperature data logged just before that time.
  For instance, the energy value at 2016-07-30 00:00:00 -0500 (9468 Wh / 1000)
  should be matched with the water temperature at
  07/29/16 11:26:34 PM (row numbered 14 in the temperature file).
- The temperature file name should be the first argument; the energy file name should be the second.

Extra desired features:

- Check for potential errors, such as data files with
  non-overlapping dates, or with an unexpected format, etc.
- Add a third argument for the script, for the output file name.
  If missing, the script should return the output to the STDOUT stream.
- Be should be safe for user: not overwriting existing files
  unintentionally.
- Have an option to append to (or to overwrite) the output file.

The last point is to let the user run the script on multiple pairs of files,
such as from multiple months, and always append the merged data onto the
same output file, which could then contain data from a whole year.

The **learning goal** (for yourself, not the script user) is to learn Python,
get more experience with git, think about algorithm strategy,
and get good habits of computing practices like project management,
code documentation, writing code for humans, planning for errors, etc.  
Therefore, do *not* use pre-defined modules for handling data arrays or
merging data files. Use this exercise to practice low-level python functions.

suggested algorithm
-------------------

This is just a suggestion of steps that your script could take.
There are always many ways to get the job done.
These steps below do not require pre-defined modules
(except to handle dates), with the intention to provide a richer
coding experience.

1. read the energy file: store data in 2 arrays: one with the dates,
  one with the energy values. Assume (but check) that all dates are at
  00:00:00 (midnight, morning of the given day, Wisconsin time).
  check that dates are ordered (row `n` has an earlier date than row `n+1`)

2. set `n_energy=1` and set a variable `currentEnergyDay` to day `1`
  (midnight morning), as read in the first row of the energy file.
  In general, we mean `currentEnergyDay` to be the day on line `n_energy`
  of the energy file, and the energy value on that day is the next
  energy value to be added to the temperature information.

3. read the next line in the temperature file (read the first line, at first)

  - strip the end-of-line character from this line
  - get the day corresponding to this line of temperature data
  - if this day is greater than or equal to `currentEnergyDay`:
    * quit with an error if this day is not equal to `currentEnergyDay`
    * write the energy value number `n_energy` to the output
    * increment `n_energy` by one and
      update `currentEnergyDay`: make it the day number `n_energy` for the
      energy data
  - write a newline character to the output
  - write the line to the output (no end of line)
  - write a comma to the output
