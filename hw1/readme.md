# Stat679 - Homework 1

Data for this assignment was obtained from the course repo. It was copied (cp)
from that repo to this folder.

Assignment:



Data for homework assignments and group projects
are organized in different folders. See the readme file
in each folder for instructions on specific assignments.

1. follow these
[instructions](http://cecileane.github.io/computingtools/pages/git.html)
to install and configure git.
2. below are instructions to use git to set up your homework repository
3. jump to instructions to [submit](#Commit-push-and-submit-your-work) your work

## set-up your course repository

To submit homework and projects, use one repository, say `stat679work`,
that will contain several subdirectories: one per homework/project.
This repository should be *separate* from the `coursedata` repository.

In other words, you need to download the data for the course in a git repository
that is **kept separate** from your own directories when you do the work.
Git repositories **must not** be nested within one another.
(if you hear about submodules, forget about them for now).

Option 1 might be easier, but use
option 2 if you already started your work.

### option 1: github first

1. go to github and create a repository there, called "stat679work"
  for instance. Click on the "+" sign in the top right corner near your picture,
  then "New Repository". Click "Private" if you want to keep it private, which
  should be free through your student developer pack. Check the box to initialize
  the repository with a readme file called "README.md". Do *not* check the box
  if you would prefer to create this file yourself later, named "readme.md"
  for instance (that's my preference because lower-case letters save time).

2. still on github, in your new repo, click the green button "Clone or download",
  then click "Use SSH" on the right if you see "Clone with HTTPS" instead
  of "Clone with SSH". Copy the string (or click the "copy" button). The link
  should look like this:
  `git@github.com:your_user_name/stat679work.git`

3. on your laptop, nagivate to where you want your stat 679 work to be.
  This *must not* be inside an existing repository, so it must *not* be
  inside the directory with the stat 679 data. Then create your local
  version of your homework repository:
  `git clone git@github.com:your_user_name/stat679work.git`
  but paste the link that you copied in step 2.

4. move (`mv`) inside the new directory, which should be named with the name
  given in step 1 (like `stat679work`). Once there,
  * edit your readme file to explain what you intend to put in this directory
    and what subdirectories will be there,
  * create a subdirectory `hw1`
  * copy (`cp`) the data for homework 1 from `coursedata`
    to this new directory `hw1`.
  * create another readme file in `hw1` to explain what will be there,
    and how you got the data that is in there
    (copy-paste the command that was used in the previous step).

5. check that your local repository knows about the remote repository on github:
  `git remote -v`. You should see an output like this:

        origin	git@github.com:your_user_name/stat679work.git (fetch)
        origin	git@github.com:your_user_name/stat679work.git (push)

    if you do not get any output, then do step 7 in option 2 below.

6. save your work for homework 1 in `hw1`, organized with subdirectories
  to separate the data from your scripts. Instructions to "push" your work
  and to submit it are below.

### option 2: start your work first

3. create (`mkdir`) a directory `stat679work`, where you will do all of your work
  for the course, to be used to submit your homework and projects.
  This directory *must be* outside any other git repository, in particular,
  outside of the course data repository `coursedata`.

4. move (`mv`) inside your new directory `stat679work`. Once there,
  * create a `readme.md` file to explain what you intend to put in this directory
    and what subdirectories will be there,
  * create a subdirectory `hw1`
  * copy (`cp`) the data for homework 1 from `coursedata`
    to this new directory `hw1`.
  * create another readme file in `hw1` to explain what will be there,
    and how you got the data that is in there
    (copy-paste the command that was used in the previous step).

6. save your work for homework 1 in `hw1`, organized with subdirectories
  to separate the data from your scripts. Instructions to "push" your work
  and to submit it are below.

1. go to github and create a repository, called "stat679work" again.
  Click on the "+" sign in the top right corner near your picture,
  then "New Repository". Click "Private" if you want to keep it private, which
  should be free through your student developer pack. Do **not** check the box
  to initialize the repository with a readme file, because you already created
  a readme file in step 2.

2. still on github, in your new empty repository,
  copy the commands below "...or push an existing repository from the command line",
  which should look like this:

        git remote add origin git@github.com:your_user_name/stat679work.git
        git push -u origin master

7. move back to your `stat679work` directory (parent of `hw1`) to turn this
  directory into a git repository, then take your first "snapshot",
  with your readme file only to keep things simple. Once in `stat679work`,
  do this:

        git init                                     # initialize the repository
        git add readme.md                            # tell git to track the file readme.md
        git commit -m "initial commit: readme only"  # take the snapshot

    If you named your readme file differently (like readme or README or ReadMe or
  README.md or ReadMe.md), then adjust your `git add` command accordingly.
  Using the markdown style and having the extension `.md`
  is highly highly recommended.

5. tell your local repository about the remote repository on github: paste
  the commands copied in step 5, `git remote add ...` and then
  `git push -u origin master`. To check that git understood, do `git remote -v`.
  You should see an output like this:

        origin	git@github.com:your_user_name/stat679work.git (fetch)
        origin	git@github.com:your_user_name/stat679work.git (push)

## Commit, push, and submit your work

These steps are to broadcast your work to github, to submit it there.

(instructions to follow).
