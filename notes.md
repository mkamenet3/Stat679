#title: "Stat 679 - Computing Tools (Fall 2016)"
#author: "Maria Kamenetsky"
#date: "9-8-16"

For detailed notes from Professor Cecile Ane, please visit the course [website](http://cecileane.github.io/computingtools/) .


##9/8/16

###Navigating File Directories
```
ls -F #add trailing / to names of directories

/bin #primarily for apps or executables

ls -F -a #-a flag shows hidden directories

ls -rlt #will sort by time
```

###Removing things
```
rm -r -i fakedirectory #the -i flag means 'interactively' which means that it will prompt you to make sure you know what you're doing

ls -R #-R lists contents of directories recursively
```
###Pipes and Filters

```
wc *.pdb
```

this spits out 1) number of lines in file, 2) number of words, 3) number of characters

```
sort -n lengths.txt
```
sorts the stuff, don't need to cat here

```
sort lengths.txt | head -n 3| csvlook -H

wc -l *.txt | sort| head -n 5 | csvlook -H
```

As well as using > to redirect a program’s output, we can use < to redirect its input, i.e., to read from a file instead of from standard input

##9/13/16
```
ls -F
```
this is actually really nice cuz it shows you what is a file versus a directory

```
rmdir
```
opposite of mkdir

```
atom
```
I can just type 'atom' and it will launch an atom window

```
rm -r
```
-r mean recursive, so delete all the files and subdirectories in it
so you should really use -r -i (so it prompts you)

```
ls -R
```
recursively lists everything in the directories and sub-directories

###dedupping
```
uniq -d salmon.txt | csvlook -H
```
the -d flag limits it to 1 entry per group; otherwise it only removes adjacent groups

can use diff on text files
```
diff salmon.txt salmonNew.txt #shows the difference
```

'cp' can be dangerous cuz if you cp something into a folder where that file already exists, then it will overwrite the file in there
to be safe you should just:
```
cp -i #which prompts interactive mode
```

PROTIP: to search the man pages, just "/" and then search term


##9/15/16

```
less
```
is a viewer

FYI: the shell indexes at 1 (not 0!);so if you want something starting at 5, it will start at 5

```
tail -n +5 sortedlengths.txt
```
if you want to start at the 5th line and go down

Let's say you want to list the last 'n' commands you ran:
```
history | tail -n 5
```

```
?
```
character only matches 1 thing in regular expression

```
[AB]
```
Square brackets mean 'or'; so this is A or B
This is case sensitive

```
echo {1..10}
```
shell will print range of this


##9/20/2016
```
>>
```
Appends

CTRL + z #to pause

```
ps
```
Lists the processes

```
top
```
same as ls but lists them

```
cut -d. -f1,2
```
This will take everything up to the second instance of the chosen delimiter "."


##9/22/2016

CTRL + D #d is for done

CTRL + A or E #go to beginning or end of lines


```
find . -name "*.txt"
find . -name *.txt
```
xargs
```
find . -name '*.txt' | xargs wc  -l
```

 ^ means beginning of the line
 $=end of line

```
grep -v '^\s*$'
```

####directory structure

at the onset: create a few directories (mkdir) and empty readme files (touch)
all files in a project: live in a single directory, with a clear name (don’t scatter your files)
separate directories for:
- data
- scripts
- binaries (of other people’s programs that you used)
- results, or analysis
- figures
- manuscript
- or even: subprojects, with its own script & analysis directories
- data: all in the same directory, or separate directory data_clean for intermediate data, or subdirectories data/original and data/clean. Never edit raw data. Use a script to clean the original data file, then save the resulting clean data.

- results or analysis: if the pipeline is complex, use different directories for different kinds of results (intermediate, or different analyses), or subdirectories
- scripts: if there are many, organize them in subdirectories.
use relative paths in scripts: you can move your entire directory somewhere else (e.g. on your collaborator’s laptop) and things will still work.
short scripts to double-check quality, make a quick figure, etc: may be in results.
- figures: not everybody will agree. Can make your life easier to modify a figure for a publication (if asked by reviewers) or for a presentation 6 months later.


##9-29-16

```
git diff
```

What if you committed something and you don't want that
```
git revert #moves head to old snapshot

git reset #you lose information

git rebase #more drastic than git rebase

git rm --cached output/summaryFiles/x3_master.csv

git log
```

##9-29-16

```
cut filename.txt -f1 | head #to make sure you're cutting the right thing
cut filename.txt -f1 | sort | uniq

# you should sort first before unique because it does a grid search for unique values

```
f - for field, c for character
can cut range of columns, -f2-4 (2 through 4) or -f2,4 (only columns 2 and 4)

if you have non-tab file, then you need to specify the separation values

how to find random characters: pipe first n lines into text file and can ask atom to show lines in the editor
```
#doing this with commas
cut -f2 -d, filename.txt | head
```
-d specifies the delimiter

```
grep '_' combined.nex | cut -f 1 -d ' ' > taxa
wc taxa
head taxa
```

```
sort -k1,1 -k2,2n example.bed
sort -k1,1 -k2,2nr example.bed
sort -k1,1 -k2,2n -r example.bed
sort -k1,1 -k2,2n -c example.bed
```
can sort in reverse order (add r)
```
grep -v "^#" Mus_musculus.GRCm38.75_chr1.gtf | cut -f1-8 |column -t | head
```
search for everything without # sign (-v, search for everything without the character),
take columns 1-8, make it a nice table, take head

basename and dirname extract the file/folder name and its path from a string (the file/folder need not exist).
can use basename to get rid of suffix, ending of file name; basename does nothing to the file, only works on the filename as a string
```
basename -s "txt" "relative/path/to/myfile.txt"
```

sed

```
sed s/pattern/replacement/ filename > newfile # do NOT redirect to input file!
sed -i s/pattern/replacement/ filename # for in-place replacement
```

s/// to replace first occurrence of a match, s///g to replace globally (all instances),
s///i and s///gi for case-insensitive search
option -E for Extended (not basic) regular expressions

-n option to not print every line
p flag to print: s///p print if there is a match

warning: unlike grep, sed does not recognize “enhanced” (Perl-like) expressions like \d (digit),
\s (space) or \w (word character). use classes instead: like [0-9] or [a-zA-Z_].

need -E for extended regular expressions

```
sed "s/.*transcript_id "([^"]+)".*/\1/" something.txt | head

#if it matches then print
sed -n "s/.*transcript_id "([^"]+)".*/\1/" something.txt | head


grep -v "^#" Mus_musculus.GRCm38.75_chr1.gtf |
  sed -E -n 's/.*transcript_id "([^"]+)".*/\1/p' | sort | uniq | head
```

##10-6-2016

```
sed -n
```
-n option says only print out the things that match
-E is edit in place

command-line arguments stored in variables $1, $2, etc.
$0: name of script $#: number of arguments


```
echo "script name: $0"
echo "first argument: $1"
echo "number of arguments: $#"
(head -n 2; tail -n 2) < "$1"
```
parentheses are to evaluate in place (subshell)
< #take $1 as input to the head/tail argument

 #!/bin/bash - tells the path of where the executable


 ```
 #!/bin/bash
set -e # script terminates if any command exits with non-zero status
set -u # terminates if any variable is unset
set -o pipefail # terminates if command within a pipes exits unsuccessfully
```

exit status 1 = there's a problem


```
rm -rf /tmpfile

```
it would be vrey bad if it can't find tmpfile cuz it will remove everything! WHy you should set set -u


```
echo $PATH
```
if bash says whatever.sh: command not found; look at the PATH and tell it ./whatever.sh

rwx
1) user, 2) group permissions, 3) everybody else who might log in and have access to the files

CHANGING permissions

```
chmod u+x headtail.sh
```

```
./headtail whatever.bed | column -t

ls -l
chmod u+x headtail.sh
ls -l
```
./headtail.sh Mus_musculus.GRCm38.75_chr1.bed
./headtail.sh Mus_musculus.GRCm38.75_chr1.bed | column -t
u, g, o: user, group, other; a for all
+ or - to add or remove permissions
r, w, x: read, write, execute


if you put executable of your software in one of the files echoed in echo $PATH,
then you can call that from anywhere and you won't need to ./filename.sh

good place to put scripts is the home directory

ARITHMETIC expressions
```
i=3678
echo "my variables is: i=$i"
((i = i+6))
echo "I incremented i by 6: now i=$i"
((i--))
echo "I decremented i by 1: now i=$i"
((i++)); echo "I incremented i by 1: now i=$i"
((i+=1)); echo "I incremented i by 1 again: now i=$i"
((i/=5)); echo "finally, I divided i by 5: now i=$i"
echo $((i++))
echo $i # i++ executes the command and increments i after
echo $((++i))
echo $i # ++i increments i first, then executes the command
```

i++; do addition operation and then increment by 1
echo $((++i)) ; first incremenet i and then print it

####IF Statements

```
if [ $i -lt 800 ] # the spaces after `[` and before `]` are REQUIRED
then
  echo "i is less than 800"
else
  echo "i is not less than 800"
fi
```

-lt = less than

```
if [ $# -lt 1 -o ! -f $1 -o ! -r $1 ] #this test is only used if there is a problem in the first place
then
  echo "error: no argument, or no file, or file not readable"
  exit 1 # exit script with error code (1). 0 = successful exit
fi
```
If number of arguments ($#), then:
- ```-o ! -f ```= "or not a file"
- ```-o ! -r ``` "or not readable"

-eq = equal
-ne = not equal

only use 1 equal sign to test and need space around spaces
```
str1 = str2

#tests is str1 is equal to str2, need the spaces around equal signs and only 1 equal sign in the first place
```
use parentheses  () to group tests (this and that AND this or that)


(file is readable) or (error: with message)
```
echo $PS1
\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$
```


##10-11-2016

Recover old versions

```
git log --graph # copy-paste the SHA from just before divergence
cat readme.md
git checkout 7d82504d7dfb3 -- readme.md
cat readme.md
git log --graph --abbrev-commit --pretty=oneline
git checkout -- readme.md # back to version from HEAD (default)

git tag 'oldcommit name' v1.2

```
git commit --amend to add change the last commit message. But do not do this if you already pushed your change to github.

git revert to revert changes (creates a new commit). For example, to undo the last commit, we would do: git revert HEAD. This would create a new commit whose actions would cancel the actions of the last commit. To undo the changes of the second-to-last commit (but not the changes in the last commit), we would do: git revert HEAD~1. This is safe, and much recommended if you already pushed to github the commits to be undone.

git reset and git rebase: I very highly recommend that you do not use them, until you know exactly what you do. Even then, do not use them if you already pushed your commits to github.

```
git commit --amend #will change SHA of commit
```

##10-13
don't be in a git repository when you clone your buddy's repository: then git clone _address_

Can rename the repo git clone _address_ myreponame

&& and || for and/or

in regular expressions, it's only one bar, |


grep -v "^#"
The -v flag means not; so search for lines that do NOT start with pound sign


wget is recursive so we can download the files and all inner files from website; might be a good idea to limit

curl - lots of options for passwords


##10-18-16
```
cat ~/.ssh/known_hosts
```

If you need to find the ip address of all the hosts you've logged on to. If you come across an ssh error, may need to go in here and delete the ip address so it doesn't remember

```
scp ane@desk22.stat.wisc.edu:private/st679/notes/statservers.md ../notes/
cd ..
ls -l notes/statservers.md
scp -r desk22.stat.wisc.edu:private/st679/coursedata/hw1-snaqTimeTests/log .
ls -l
ls -l log/
echo "hi Cecile" > coolfile
scp coolfile ane@desk22.stat.wisc.edu:private/ # works both directions

cp -r logFolder/files .
```
- don't include the / at the end of files to include the folder and everything in the folders as well

```
mb mrBayes-run.nex > screenlog &
tail -f screenlog
```
- & - start process and wait
- tail -f = prints things

nohup = will catch and ignore hangup signal

##10-20-16


##10-25-16

```
dir(...)
help(...)
?...
dir("") #any methods of the string
```

Basics types in python:
- bool(True, False); int; float; None; string
- tuples
```
data[0,:] #extract first row, :means everything
```

R has vectors, elements are all of the same types
Lists don't have to be of the same type; can be list of anything

Don't need parentheses with tuples

tab != 4 spaces

For strings, you can slice and extract things from them but you can't change them because strings are immutable. Lists and arrays are mutable and if you change b and a = b, then a will also change because by setting a = b, you are setting the address of a = b.

Mind your brackets!

_Deep copy vs. simple copy_

- deep copy = when you see an address like this, recursively copy everything; does not change the things that are connected to that address
- Number is not mutable; array is mutable


##10-27-16
.strip() will get rid of any white space at the end

last 4 elements:
```
print(a[-4:])
```
tuples have (), not square brackets

list  = address to somewhere else; tuple = right there

with tuples, don't need to allocate new memory; just need to specify parentheses


With lists, + operator just appends.

list is just a shallow copy

sorting on a mixed list will return an error

glob - grabs all files with certain pattern

if testing if something  = 0, instead of 0 (if it's a float)
you should test abs(x) <= 10^e-15

truly empty things are false; None is false; all else is True
bool(a) to see what's up and if it would be true or false

```
dir a #will give you a list of all the methods applicable to a
```

##11-1-16

```
print(re.findall(r'i.*n',filenames[0]))
```
find 'i' and then anything else any number of times
```
*? - means don't be greedy
*+? - as few as possible
*+1 - plus 1 characters
```

_Functions_

- you need the function to return, otherwise empty
- python doesn't require the different roxygen comments, param exports definitions
- signature species what the format of the input is; docstring shows you the explanation
  - can also do help _functionaname_
  - in notebook: ?startswithi

- if you're copy-pasting, then just write a function
- if a nested loop, write a function


```
def fact_name()
  """my docstring for future function"""
  pass
```
When schematic-ing out code, write empty functions with the docstrings you think the functions will do; then give it pass


##11-3-16

- goal is to calculate n choose k


##11-8-16

-fh is the file handle - to read or write
- need to remember to close the file after the close Statements

- should check to make sure ASCII characters

- range; iterators generators to replicate a list prior to .writelines()

- line.strip() - gets rid of new line or white space in beginning or end of a line

```
if not line:
  continue

```
 - will be false unless empty string; will only be empty if you get to end of string or if line is completely empty after stripping blanks; try-catch error thing
- no default file type it's writing to


```
import sys
reformat_onefile("filename.fasta", sys.stdout)
```

- need to import sys module so function writes to screen (or standard out stream) instead of writing to file right away
```
- glob.glob("*-protein.fasta")
```
  - glob returns a list of file names

- keys have to be immutable (string or ____?)
  - pop deletes element of which key from the dictionary


#11-15-16
- hashes and sets are super fast
- don't need to go through each thing like you need to do with a for loop
- set only has keys, no values
- for list comprehension,  you can include 'if' statements


list comprehension:
 - single thing; good for short loops
 - if it's complicated, go back to a for loop

 a = {print(k) for k in )}

 ### subprocesses:
  - python can bypass the shell and run program directly

- exit 0 = true in shell; exit 1 = process has an error
- shell=True - asks shell to run it

###Object-oriented programming
- functions apply to objects
- functions are called methods
- attributes (attributes of the object)

Ex:
- graph consists of nodes and edges
  - build a class for edge; build a class for tree which will have edges
- each class has its own init functions (3 is an object of type integer)
  - init creates an object of type that we defined; NEED THIS
- def __str__(self): predefined method which helps to print results to screen


```
class Edge:
    """Edge class, to contain a directed edge of a tree or directed graph.
    attributes parent and child: index of parent and child node in the graph.
    """

    def __init__ (self, parent, child, length=None):
        """create a new Edge object, linking nodes
        with indices parent and child."""
        print("starting __init__ for new Edge object/instance")
        self.parent = parent
        self.child = child
        self.length = length

    def __str__(self):
        res = "edge from " + str(self.parent) + " to " + str(self.child)

  ```
- funciton is creating an object which will have 3 attributes - don't use parentheses to access them
- string method converts them to string



##11-17-16

```
ste1.union(set2)

```

```{python}
def get_path2root(self, i):
  res = []
  nextnode = i
  while True:
    res.append(nextnode)
    if nextnode == self.root:
      break
    nextnode = self.node2edge[nextnode].parent #need [] because it's a dictonary not a function
  return(res)

def get_nodelist(self, i,j):
"""takes 2 nodes and returns the distance btweeen them: number of edges from node i to node j"""
  if i == j:
    return 0
  res = 0
  pathi = self.get_path2root(i) #last node in this list: root
  pathj = self.get_path2root(j)
  while pathi and pathj:
    anci = pathi[-1]
    ancj = path[-1]
    if anci == anj:
      pathi.pop()
      pathj.pop()
    else:
      break
  res = len(pathi) + len(pathj)
  return res



```

methods use ()
attributes - no parentheses


##12-8-16

Julia continued

```
function sumofsins1(n::Integer)  
    r = 0  
    for i in 1:n  
        r += sin(3.4)  
    end  
    return r  
end

```
- output is always floating point here:
```
function sumofsins2(n::Integer)  
    r = 0.0  
    for i in 1:n  
        r += sin(3.4)  
    end  
    return r  
end
```
- in Julia, you can _ every 3 zeros to make it easier to read (100_000)
- you can do cool things like:
```\alpha
```
(and then tab)

- commenting: singleline comment: #; multi-line comment: #/comment=#
- Julia does garbage collection automatically
  - do you don't need to de-construc the constructors
  - used memory and then don't use it
- "type stability"
- will warn you if there is type instability:
```
@code_warntype sumofsins2(3)
@code_warntype sumofsins1(3)
```

- red things = potential problems in
- docstring needs to be above the function
- || = or, && = and

```
x=5; y=6.2
if x>6 || y>6
  println("x or y is >6")
end
x>6 || error("x is not greater than 6: can't continue")
x>6 || warn("oops, x not >6, is this normal?")
x>6 && info("checked: x is greater than 6")

function test(x,y)
  if x ≈ y # type \approx then TAB. Same as isapprox(x,y).
    relation = "(approx) equal to"
  elseif x < y
    relation = "less than"
  else
    relation = "greater than"
  end
  println(x, " is ", relation, " ", y, ".")
end
test(x,y)
1.1+0.1 == 1.2
test(1.1+0.1, 1.2)

isxbig = x>3 ? "yes" : "no" # ternary expression: very short if/else
```

```
paramvalues = [10.0^i for i in -3:2]
```
- up to 2 included



##12-13-16 - Julia + Doug Bates

- compiled languages are fast because they're very explicit
- R vector of floating point, vectors of integers, character strings, and pointers to things
- functional symantecs: gives you  impression that arguments passed to function are copied.
  - don't modify argument inside function
```
@rput pvals
```
- macros; delay evaluation until it can figure out what the symbol means
- most of system-time gets taken up for garbage collection
- in R, big vector = creating 4 copies: problem with vectorization
- in R, no scalars, only vectors of length 1

- BenchmarkTools - allws you to benchmark your calculations
- abstract types have names that start with 'abstract'
- multiple dispatch: looks at arguments and decides which method to call


##12-15-16 - SLURM and Stat HPC Cluster

- all packages and timing are pretty much taken care of for you
- nodes = more and more computers
- head node = lunchbox; need to request access
- AFS vs NFS
  - don't want to be in AFS if you're doing HPC
  - want to be in /workspace (head node)
  - /workspce/software (where the packages will be)
  - personal packages need to be installed into custom location under software
- commands  
  - *sinfo* - displays current partitions (which servers you can submit to)
  - *squeue* - displays jobs currently running or queued
  - *sacct* - displays your jobs, cores used, run statements
  - *sbatch* - submits your batch script to the scheduler

```
cd /workspace/
cd __username__
```
Bash script:
- You want the shebang there - it's not a comment the #SBATCH

```
#!/bin/Bash
#SBATCH --mail-user=_myemail_@wisc.edu
#SBATCH --mail-type=ALL
/bin/hostname
sleep 10
```

```
sinfo #* means the default cluster your job will be submitted to
squeue #gives you a job number
scontrol show_job 1234 #number is job id - this shows you everything that was done
```
```
cat slurm-1234.out
```

```
#!/bin/Bash
#SBATCH --mail-user=_myemail_@wisc.edu
#SBATCH --mail-type=ALL
#SBATCH -t 1 #approx time you want on HPC Cluster, otherwise it's at the bottom of the queue (4 days - bottom of cluster). This is 1 minute
#SBATCH -n 1
#SBATCH -c 2

/bin/hostname
sleep 10
```

For parallel, use ```srun```
```
#SBATCH -n 8 #waits until 8 cores available to run
srun -n 8 bin/hostname
```
```
printenv #print environment for user
srun printenv #prints slurm environment
```

If you're running sub-proceeses within the program you wrote, then if you don't allocate properly, slurm will yell at you.

```
squeue -u username
scancel _jobnumber_
```
```
srun --pty -w marazno05 /bin/bash #drops you into bash
top #can see what process is running as regular
```
Useful to sometimes just specify the home directory
```
export HOME = _dirname
export R_LIBS=/workspace/user/R #set path to R libraries
```
```
sshfs #so you can use atom
```

- *srun* creates job steps
- always include -t and -n, cuz otherwise without time estimates your job will be pushed to the bottom
- try to use software that's compiled on the cluster
- whatever you put in the commandline will override what's in the bash script.
- so you can have the script say submit 200 scripts and on the commandline just specify in the array that it should only run the first 3 (array, 0-2)


For more info, checkout <http://www.stat.wisc.edu/services/hpc-cluster>

Course website also has examples ![here](http://cecileane.github.io/computingtools/pages/notes1215.html)
