#================================================ Find Source ==================================================================
#
#!/bin/bash
echo "\$0: $0"
echo ${FUNCNAME[0]} in ${BASH_SOURCE[0]}
fun() {
    echo ${FUNCNAME[0]} in ${BASH_SOURCE[0]}
    echo $0
}

#================================================ Bash MAC ==================================================================

# 0. Shortcuts.


CTRL+A  # move to beginning of line
CTRL+B  # moves backward one character
CTRL+C  # halts the current command
CTRL+D  # deletes one character backward or logs out of current session, similar to exit
CTRL+E  # moves to end of line
CTRL+F  # moves forward one character
CTRL+G  # aborts the current editing command and ring the terminal bell
CTRL+J  # same as RETURN
CTRL+K  # deletes (kill) forward to end of line
CTRL+L  # clears screen and redisplay the line
CTRL+M  # same as RETURN
CTRL+N  # next line in command history
CTRL+O  # same as RETURN, then displays next line in history file
CTRL+P  # previous line in command history
CTRL+R  # searches backward
CTRL+S  # searches forward
CTRL+T  # transposes two characters
CTRL+U  # kills backward from point to the beginning of line
CTRL+V  # makes the next character typed verbatim
CTRL+W  # kills the word behind the cursor
CTRL+X  # lists the possible filename completefions of the current word
CTRL+Y  # retrieves (yank) last item killed
CTRL+Z  # stops the current command, resume with fg in the foreground or bg in the background

DELETE  # deletes one character backward
!!      # repeats the last command
exit    # logs out of current session


# 1. Bash Basics.


export              # displays all environment variables

echo $SHELL         # displays the shell you're using
echo $BASH_VERSION  # displays bash version

bash                # if you want to use bash (type exit to go back to your normal shell)
whereis bash        # finds out where bash is on your system

clear               # clears content on window (hide displayed lines)


# 1.1. File Commands.


ls                            # lists your files
ls -l                         # lists your files in 'long format', which contains the exact size of the file, who owns the file and who has the right to look at it, and when it was last modified
ls -a                         # lists all files, including hidden files
ln -s <filename> <link>       # creates symbolic link to file
touch <filename>              # creates or updates your file
cat > <filename>              # places standard input into file
more <filename>               # shows the first part of a file (move with space and type q to quit)
head <filename>               # outputs the first 10 lines of file
tail <filename>               # outputs the last 10 lines of file (useful with -f option)
emacs <filename>              # lets you create and edit a file
mv <filename1> <filename2>    # moves a file
cp <filename1> <filename2>    # copies a file
rm <filename>                 # removes a file
diff <filename1> <filename2>  # compares files, and shows where they differ
wc <filename>                 # tells you how many lines, words and characters there are in a file
chmod -options <filename>     # lets you change the read, write, and execute permissions on your files
gzip <filename>               # compresses files
gunzip <filename>             # uncompresses files compressed by gzip
gzcat <filename>              # lets you look at gzipped file without actually having to gunzip it
lpr <filename>                # print the file
lpq                           # check out the printer queue
lprm <jobnumber>              # remove something from the printer queue
genscript                     # converts plain text files into postscript for printing and gives you some options for formatting
dvips <filename>              # print .dvi files (i.e. files produced by LaTeX)
grep <pattern> <filenames>    # looks for the string in the files
grep -r <pattern> <dir>       # search recursively for pattern in directory


# 1.2. Directory Commands.


mkdir <dirname>  # makes a new directory
cd               # changes to home
cd <dirname>     # changes directory
pwd              # tells you where you currently are


# 1.3. SSH, System Info & Network Commands.


ssh user@host            # connects to host as user
ssh -p <port> user@host  # connects to host on specified port as user
ssh-copy-id user@host    # adds your ssh key to host for user to enable a keyed or passwordless login

whoami                   # returns your username
passwd                   # lets you change your password
quota -v                 # shows what your disk quota is
date                     # shows the current date and time
cal                      # shows the month's calendar
uptime                   # shows current uptime
w                        # displays whois online
finger <user>            # displays information about user
uname -a                 # shows kernel information
man <command>            # shows the manual for specified command
df                       # shows disk usage
du <filename>            # shows the disk usage of the files and directories in filename (du -s give only a total)
last <yourUsername>      # lists your last logins
ps -u yourusername       # lists your processes
kill <PID>               # kills (ends) the processes with the ID you gave
killall <processname>    # kill all processes with the name
top                      # displays your currently active processes
bg                       # lists stopped or background jobs ; resume a stopped job in the background
fg                       # brings the most recent job in the foreground
fg <job>                 # brings job to the foreground

ping <host>              # pings host and outputs results
whois <domain>           # gets whois information for domain
dig <domain>             # gets DNS information for domain
dig -x <host>            # reverses lookup host
wget <file>              # downloads file


# 2. Basic Shell Programming.


# 2.1. Variables.


varname=value                # defines a variable
varname=value command        # defines a variable to be in the environment of a particular subprocess
echo $varname                # checks a variable's value
echo $$                      # prints process ID of the current shell
echo $!                      # prints process ID of the most recently invoked background job
echo $?                      # displays the exit status of the last command
export VARNAME=value         # defines an environment variable (will be available in subprocesses)

array[0] = val               # several ways to define an array
array[1] = val
array[2] = val
array=([2]=val [0]=val [1]=val)
array(val val val)

${array[i]}                  # displays array's value for this index. If no index is supplied, array element 0 is assumed
${#array[i]}                 # to find out the length of any element in the array
${#array[@]}                 # to find out how many values there are in the array

declare -a                   # the variables are treaded as arrays
declare -f                   # uses funtion names only
declare -F                   # displays function names without definitions
declare -i                   # the variables are treaded as integers
declare -r                   # makes the variables read-only
declare -x                   # marks the variables for export via the environment

${varname:-word}             # if varname exists and isn't null, return its value; otherwise return word
${varname:=word}             # if varname exists and isn't null, return its value; otherwise set it word and then return its value
${varname:?message}          # if varname exists and isn't null, return its value; otherwise print varname, followed by message and abort the current command or script
${varname:+word}             # if varname exists and isn't null, return word; otherwise return null
${varname:offset:length}     # performs substring expansion. It returns the substring of $varname starting at offset and up to length characters

${variable#pattern}          # if the pattern matches the beginning of the variable's value, delete the shortest part that matches and return the rest
${variable##pattern}         # if the pattern matches the beginning of the variable's value, delete the longest part that matches and return the rest
${variable%pattern}          # if the pattern matches the end of the variable's value, delete the shortest part that matches and return the rest
${variable%%pattern}         # if the pattern matches the end of the variable's value, delete the longest part that matches and return the rest
${variable/pattern/string}   # the longest match to pattern in variable is replaced by string. Only the first match is replaced
${variable//pattern/string}  # the longest match to pattern in variable is replaced by string. All matches are replaced

${#varname}                  # returns the length of the value of the variable as a character string

*(patternlist)               # matches zero or more occurences of the given patterns
+(patternlist)               # matches one or more occurences of the given patterns
?(patternlist)               # matches zero or one occurence of the given patterns
@(patternlist)               # matches exactly one of the given patterns
!(patternlist)               # matches anything except one of the given patterns

$(UNIX command)              # command substitution: runs the command and returns standard output


# 2.2. Functions.
# The function refers to passed arguments by position (as if they were positional parameters), that is, $1, $2, and so forth.
# $@ is equal to "$1" "$2"... "$N", where N is the number of positional parameters. $# holds the number of positional parameters.


functname() {
  shell commands
}

unset -f functname  # deletes a function definition
declare -f          # displays all defined functions in your login session


# 2.3. Flow Control.


statement1 && statement2  # and operator
statement1 || statement2  # or operator

-a                        # and operator inside a test conditional expression
-o                        # or operator inside a test conditional expression

str1=str2                 # str1 matches str2
str1!=str2                # str1 does not match str2
str1<str2                 # str1 is less than str2
str1>str2                 # str1 is greater than str2
-n str1                   # str1 is not null (has length greater than 0)
-z str1                   # str1 is null (has length 0)

-a file                   # file exists
-d file                   # file exists and is a directory
-e file                   # file exists; same -a
-f file                   # file exists and is a regular file (i.e., not a directory or other special type of file)
-r file                   # you have read permission
-r file                   # file exists and is not empty
-w file                   # your have write permission
-x file                   # you have execute permission on file, or directory search permission if it is a directory
-N file                   # file was modified since it was last read
-O file                   # you own file
-G file                   # file's group ID matches yours (or one of yours, if you are in multiple groups)
file1 -nt file2           # file1 is newer than file2
file1 -ot file2           # file1 is older than file2

-lt                       # less than
-le                       # less than or equal
-eq                       # equal
-ge                       # greater than or equal
-gt                       # greater than
-ne                       # not equal

if condition
then
  statements
[elif condition
  then statements...]
[else
  statements]
fi

for x := 1 to 10 do
begin
  statements
end

for name [in list]
do
  statements that can use $name
done

for (( initialisation ; ending condition ; update ))
do
  statements...
done

case expression in
  pattern1 )
    statements ;;
  pattern2 )
    statements ;;
  ...
esac

select name [in list]
do
  statements that can use $name
done

while condition; do
  statements
done

until condition; do
  statements
done


# 3. Command-Line Processing Cycle.


# The default order for command lookup is functions, followed by built-ins, with scripts and executables last.
# There are three built-ins that you can use to override this order: `command`, `builtin` and `enable`.

command  # removes alias and function lookup. Only built-ins and commands found in the search path are executed
builtin  # looks up only built-in commands, ignoring functions and commands found in PATH
enable   # enables and disables shell built-ins

eval     # takes arguments and run them through the command-line processing steps all over again


# 4. Input/Output Redirectors.


cmd1|cmd2  # pipe; takes standard output of cmd1 as standard input to cmd2
> file     # directs standard output to file
< file     # takes standard input from file
>> file    # directs standard output to file; append to file if it already exists
>|file     # forces standard output to file even if noclobber is set
n>|file    # forces output to file from file descriptor n even if noclobber is set
<> file    # uses file as both standard input and standard output
n<>file    # uses file as both input and output for file descriptor n
<<label    # here-document
n>file     # directs file descriptor n to file
n<file     # takes file descriptor n from file
n>>file    # directs file description n to file; append to file if it already exists
n>&        # duplicates standard output to file descriptor n
n<&        # duplicates standard input from file descriptor n
n>&m       # file descriptor n is made to be a copy of the output file descriptor
n<&m       # file descriptor n is made to be a copy of the input file descriptor
&>file     # directs standard output and standard error to file
<&-        # closes the standard input
>&-        # closes the standard output
n>&-       # closes the ouput from file descriptor n
n<&-       # closes the input from file descripor n


# 5. Process Handling.


# To suspend a job, type CTRL+Z while it is running. You can also suspend a job with CTRL+Y.
# This is slightly different from CTRL+Z in that the process is only stopped when it attempts to read input from terminal.
# Of course, to interupt a job, type CTRL+C.

myCommand &  # runs job in the background and prompts back the shell

jobs         # lists all jobs (use with -l to see associated PID)

fg           # brings a background job into the foreground
fg %+        # brings most recently invoked background job
fg %-        # brings second most recently invoked background job
fg %N        # brings job number N
fg %string   # brings job whose command begins with string
fg %?string  # brings job whose command contains string

kill -l      # returns a list of all signals on the system, by name and number
kill PID     # terminates process with specified PID

ps           # prints a line of information about the current running login shell and any processes running under it
ps -a        # selects all processes with a tty except session leaders

trap cmd sig1 sig2  # executes a command when a signal is received by the script
trap "" sig1 sig2   # ignores that signals
trap - sig1 sig2    # resets the action taken when the signal is received to the default

disown <PID|JID>    # removes the process from the list of jobs

wait                # waits until all background jobs have finished


# 6. Tips and Tricks.


# set an alias
cd; nano .bash_profile
> alias gentlenode='ssh admin@gentlenode.com -p 3404'  # add your alias in .bash_profile

# to quickly go to a specific directory
cd; nano .bashrc
> shopt -s cdable_vars
> export websites="/Users/mac/Documents/websites"

source .bashrc
cd websites


# 7. Debugging Shell Programs.


bash -n scriptname  # don't run commands; check for syntax errors only
set -o noexec       # alternative (set option in script)

bash -v scriptname  # echo commands before running them
set -o verbose      # alternative (set option in script)

bash -x scriptname  # echo commands after command-line processing
set -o xtrace       # alternative (set option in script)

trap 'echo $varname' EXIT  # useful when you want to print out the values of variables at the point that your script exits

function errtrap {
  es=$?
  echo "ERROR line $1: Command exited with status $es."
}

trap 'errtrap $LINENO' ERR  # is run whenever a command in the surrounding script or function exists with non-zero status 

function dbgtrap {
  echo "badvar is $badvar"
}

trap dbgtrap DEBUG  # causes the trap code to be executed before every statement in a function or script
# ...section of code in which the problem occurs...
trap - DEBUG  # turn off the DEBUG trap

function returntrap {
  echo "A return occured"
}

trap returntrap RETURN  # is executed each time a shell function or a script executed with the . or source commands finishes executing


# ======================================================================================================================

# Bash shebang

* ```#!/usr/bin/env bash``` for portability, or less good, ```#!/bin/bash```

# Commenting

```# this symbol makes everything after it on a line a comment```

# Variables

* No data types. Number, char, string, ok!
* No need to declare. Just assign a value to create it.
* Get the value of a variable (whatever is stored in it) by calling it with ```$``` in front.
* declare a local variable in a function by saying ```local``` before creating it.

### Builtin shell variables

```
$0             #Name of this shell script itself.
$1             #Value of first command line parameter (similarly $2, $3, etc)
$#             #In a shell script, the number of command line parameters.
$*             #All of the command line parameters.
$-             #Options given to the shell.
$?             #Return the exit status of the last command.
$$             #Process id of script (really id of the shell running the script)
```

# File redirection and Piping

# Three default files: 0. standard input (stdin), 1. standard output (stdout) and 2. standard error (stderr)
# ```> filename``` redirects stdout to a file (and creates the file if it didn't already exist)
# ```>> filename``` redirects stdout to a file but it *appends* to the end of the file if it already exists
# ```|``` is the pipe. **Piping** is used to chain commands, scripts, files and programs together.
# Piping allows for robust mini programs to be built together like lego kits of separate parts
# Example ```cat *.txt | sort | uniq > result-file``` Sorts the output of all the .txt files and deletes duplicate lines, saving outcome to *result-file*

# Input

* ```read``` command e.g. ```read num``` asks for input and puts it in $num

# Arithmetic

* uses the ```expr``` command

```
result=`expr $1 + 2`
result2=`expr $2 + $1 / 2`
result=`expr $2 \* 5`               #note the \ on the * symbol
```

# Conditionals

* Usually surround comparisons and conditions in brackets not parens e.g. ```if [ $# -gt 1 ]```
* ```&&``` is logical *and*, ```||``` is logical *or*

## Comparisons

### Booleans

```
!     #not
-a    #and
-o    #or
```

### Numerical comparisons

```
-eq == equal to 
-ne ≠ (not equal to)
-gt > greater than
-ge >= greather than or equal to
-lt < less than
-le <= less than or equal to
< less than
<= less than or equal to ((within double parenthesis))
> greater than ((within double parenthesis))
>= greater than or equal to ((within double parenthesis))
= equal to, including for strings, e.g. ```if [ "$a" = "$b" ]```
```

### STRING COMPARISONS

```
== is equal to
!= is NOT equal to
< less than (ascii-betically)
> greater than (ascii-betically)
-z string is null
-n string is not null
```

### Example comparisons

```
if [ "$VAR1" = "$VAR2" ]; then
	echo "expression evaluated as true"
else
	echo "expression evaluated as false"
fi
```

```
case "$C" in
"1")
	do_this()
	;;
"2" | "3")
	do_what_you_are_supposed_to_do()
	;;
*)    #fallback default case
	do_nothing()
	;;
esac
```

# Looping

* Iterates over a string of values

```
### FOR loop
for i in 1 2 3 4 5    # can also be written for i in {1..5} or {start..end..increment}
do
	echo "Welcome $i times"
done
```

* ```select``` looping works just like ```for```
* with select, use p3 prompt. User options get a number prefix and waits for number response.

## Example - Basic text menu

```
#!/bin/bash
OPTIONS="Hello Quit"
select opt in $OPTIONS; do
		if [ "$opt" = "Quit" ]; then
		echo done
		exit
	elif [ "$opt" = "Hello" ]; then
		echo Hello World
	else
		clear
		echo bad option
	fi
done
```

### WHILE loop

```
while [ condition ]
do
	command
done
```

```
### UNTIL loop
until [ condition ] # executes until condition = true
do
	command
done
```

# Functions

* works same as other languages
* can take parameters

```
function e {
	echo $1
}

e Hello #will echo Hello when called
```

# Debugging

```#!/bin/bash -x``` Adding ```-x``` to the shebang produces output information

# Additional shell features

```
$var           #Value of shell variable var.
${var}abc      #Example: value of shell variable var with string abc appended.
#              #At start of line, indicates a comment.
var=value      #Assign the string value to shell variable var.
cmd1 && cmd2   #Run cmd1, then if cmd1 successful run cmd2, otherwise skip.
cmd1 || cmd2   #Run cmd1, then if cmd1 not successful run cmd2, otherwise skip.
cmd1; cmd2     #Do cmd1 and then cmd2.
cmd1 & cmd2    #Do cmd1, start cmd2 without waiting for cmd1 to finish.
(cmds)         #Run cmds (commands) in a subshell.
```
# ====================================================================================================================

The best resource for understanding existing shell scripts is explainshell

Good practices:

#!/bin/bash     #Explicitly tell shell this is a bash script
set -e          #Exit as soon as any line in the bash script fails
set -x          #Prints each command executed (prefix with ++)
set -ex         #Do both (for good practice)
Tests (for ifs and loops) are done with [ ] or with the test command.

Checking files:

-r file     #Check if file is readable.
-w file     #Check if file is writable.
-x file     #Check if we have execute access to file.
-f file     #Check if file is an ordinary file (not a directory, a device file, etc.)
-s file     #Check if file has size greater than 0.
-d file     #Check if file is a directory.
-e file     #Check if file exists.  Is true even if file is a directory.
Example:

if [ -s file ]
then
    #such and such
fi
Checking strings:

s1 = s2     #Check if s1 equals s2.
s1 != s2    #Check if s1 is not equal to s2.
-z s1       #Check if s1 has size 0.
-n s1       #Check if s2 has nonzero size.
s1          #Check if s1 is not the empty string.
Example:

if [ $myvar = "hello" ] ; then
echo "We have a match"
fi
Checking numbers: Note that a shell variable could contain a string that represents a number. If you want to check the numerical value use one of the following:

n1 -eq n2      #Check to see if n1 equals n2.
n1 -ne n2      #Check to see if n1 is not equal to n2.
n1 -lt n2      #Check to see if n1 < n2.
n1 -le n2      #Check to see if n1 <= n2.
n1 -gt n2      #Check to see if n1 > n2.
n1 -ge n2      #Check to see if n1 >= n2.
Example:

if [ $# -gt 1 ]
then
    echo "ERROR: should have 0 or 1 command-line parameters"
fi
Boolean operators:

!     #not
-a    #and
-o    #or
Example:

if [ $num -lt 10 -o $num -gt 100 ]
then
    echo "Number $num is out of range"
elif [ ! -w $filename ]
then
    echo "Cannot write to $filename"
fi
Note that ifs can be nested. For example:

if [ $myvar = "y" ]
then
    echo "Enter count of number of items"
    read num
    if [ $num -le 0 ]
    then
        echo "Invalid count of $num was given"
    else
#... do whatever ...
fi
fi
The above example also illustrates the use of read to read a string from the keyboard and place it into a shell variable. Also note that most UNIX commands return a true (nonzero) or false (0) in the shell variable status to indicate whether they succeeded or not. This return value can be checked. At the command line echo $status. In a shell script use something like this:

if grep -q shell bshellref
then
    echo "true"
else
    echo "false"
fi
Note that -q is the quiet version of grep. It just checks whether it is true that the string shell occurs in the file bshellref. It does not print the matching lines like grep would otherwise do.

I/O Redirection:

pgm > file     #Output of pgm is redirected to file.
pgm < file     #Program pgm reads its input from file.
pgm >> file    #Output of pgm is appended to file.
pgm1 | pgm2    #Output of pgm1 is piped into pgm2 as the input to pgm2.
n > file       #Output from stream with descriptor n redirected to file.
n >> file      #Output from stream with descriptor n appended to file.
n >& m         #Merge output from stream n with stream m.
n <& m         #Merge input from stream n with stream m.
<< tag         #Standard input comes from here through next tag at start of line.
Note that file descriptor 0 is normally standard input, 1 is standard output, and 2 is standard error output.

Shell Built-in Variables:

$0             #Name of this shell script itself.
$1             #Value of first command line parameter (similarly $2, $3, etc)
$#             #In a shell script, the number of command line parameters.
$*             #All of the command line parameters.
$-             #Options given to the shell.
$?             #Return the exit status of the last command.
$$             #Process id of script (really id of the shell running the script)
Pattern Matching:

*              #Matches 0 or more characters.
?              #Matches 1 character.
[AaBbCc]       #Example: matches any 1 char from the list.
[^RGB]         #Example: matches any 1 char not in the list.
[a-g]          #Example: matches any 1 char from this range.
Quoting:

\c             #Take character c literally.
`cmd`          #Run cmd and replace it in the line of code with its output.
"whatever"     #Take whatever literally, after first interpreting $, `...`, \
'whatever'     #Take whatever absolutely literally.
Example:

match=`ls *.bak`        #Puts names of .bak files into shell variable match.
echo \*                 #Echos * to screen, not all filename as in:  echo *
echo '$1$2hello'        #Writes literally $1$2hello on screen.
echo "$1$2hello"        #Writes value of parameters 1 and 2 and string hello.
Grouping: Parentheses may be used for grouping, but must be preceded by backslashes since parentheses normally have a different meaning to the shell (namely to run a command or commands in a subshell). For example, you might use:

if test \( -r $file1 -a -r $file2 \) -o \( -r $1 -a -r $2 \)
then
    #do whatever
fi
Case statement: Here is an example that looks for a match with one of the characters a, b, c. If $1 fails to match these, it always matches the * case. A case statement can also use more advanced pattern matching.

case "$1" in
    a) cmd1 ;;
    b) cmd2 ;;
    c) cmd3 ;;
    *) cmd4 ;;
esac
Loops: Bash supports loops written in a number of forms,

for arg in [list]
do
    echo $arg
done


for arg in [list] ; do
    echo $arg
done
You can supply [list] directly

NUMBERS="1 2 3"
for number in `echo $NUMBERS`
do
  echo $number 
done

for number in $NUMBERS
do
  echo -n $number
done

for number in 1 2 3
do
  echo -n $number
done
If [list] is a glob pattern then bash can expand it directly, for example:

for file in *.tar.gz
do
    tar -xzf $file
done
You can also execute statements for [list], for example:

for x in `ls -tr *.log`
do
   cat $x >> biglog
done
Shell Arithmetic: In the original Bourne shell arithmetic is done using the expr command as in:

result=`expr $1 + 2`
result2=`expr $2 + $1 / 2`
result=`expr $2 \* 5`               #note the \ on the * symbol
With bash, an expression is normally enclosed using [ ] and can use the following operators, in order of precedence:

* / %       #(times, divide, remainder)
+ -         #(add, subtract)
< > <= >=   #(the obvious comparison operators)
== !=       #(equal to, not equal to)
&&          #(logical and)
||          #(logical or)
=           #(assignment)
Arithmetic is done using long integers. Example:

result=$[$1 + 3]
In this example we take the value of the first parameter, add 3, and place the sum into result.

Order of Interpretation: The bash shell carries out its various types of interpretation for each line in the following order:

brace expansion         (see a reference book)
~ expansion             (for login ids)
parameters              (such as $1)
variables               (such as $var)
command substitution    (Example:  match=`grep DNS *` )
arithmetic              (from left to right)
word splitting
pathname expansion      (using *, ?, and [abc] )
Other Shell Features:

$var           #Value of shell variable var.
${var}abc      #Example: value of shell variable var with string abc appended.
#              #At start of line, indicates a comment.
var=value      #Assign the string value to shell variable var.
cmd1 && cmd2   #Run cmd1, then if cmd1 successful run cmd2, otherwise skip.
cmd1 || cmd2   #Run cmd1, then if cmd1 not successful run cmd2, otherwise skip.
cmd1; cmd2     #Do cmd1 and then cmd2.
cmd1 & cmd2    #Do cmd1, start cmd2 without waiting for cmd1 to finish.
(cmds)         #Run cmds (commands) in a subshell.

#=======================================================================================================================================

==========================================        	
             BASH SCRIPTING                       	==========================================
==========================================        	             TEST COMMAND
                                                  	==========================================
Invoke:      bash [options] file                  	
Shebang:     #!/usr/bin/env bash                  	Test:        test expression
                                                  	  In script: [ expression ]
==========================================        	  Alternate: [[ espression ]]
             LOOP                                 	             Does not split string words
==========================================        	             Does not expand pathglobs*
                                                  	
for i in <list>; do echo $i; done                 	Expressions:
                                                  	  True:      [ expression ]
<list>:                                           	  False:     [! expression ]
  FileSpec:  *.txt                                	  Value:     [ (expression) ]
  Set:       1 2 3 4 5                            	  And:       [ exp1 -a exp2 ]   No Short
  Range:     {start..end}       {1..5}            	  Or:        [ exp1 -o exp2 ]    Circuit
             {start..end..increment}              	  Regex:     [[ value =~ regex ]]
  Variable:  $words             "w1 w2 w3"        	                 regex w/out ": ^as.*$
  Arguments: $*                                   	                 or variable  : $regex
  Command:   `command args`                       	
                                                  	Comparisons:
Each args:                                        	  String:    str1 op str2
             for arg; do echo $arg; done          	             "$s1" op "$s2"
                                                  	    Op:      ==  =  !=  <  >  
------------------------------------------        	  Numerical: num1 op num2
                                                  	    Op:      -eq -ne -lt -le -gt -ge
for (( exp1; exp2; exp3 ))                        	  Pattern    [[ "str1" == str* ]]
for (( i=1; i<=5; i++ ))                          	
for ((i=1, j=10; i<=5 ; i++, j=j+5))              	Empty:       -z string          Zero-len.
for (( ; ; ))                   Infinite!         	Not Empty:   -n string          
                                                  	
------------------------------------------        	File Tests:
                                                  	  Exists:    -e file
While:      while [ test ]; do                    	  Is File:   -f file
               commands                           	  Is Dir:    -d file
            done                                  	  Writable:  -w file
  Infinite: while : ...                           	  Terminal:  -t FD              Std*
                                                  	
Until:      until [ test ]; do                    	More:        man test
               commands                           	
            done                                  	==========================================
                                                  	PATTERNS & FILE GLOBS & REGULAR EXPRESSION 
------------------------------------------        	==========================================
                                                  	
Exit loop:  break                                 	Pattern: (not extended regular expression)
Next:       continue                              	  Any:      * 
                                                  	  Start/End:   *end   start*
==========================================        	  Single:   ?
             CONDITTIONAL                         	  Special:  \x
==========================================        	  Brackets: [...]
                                                  	    Set:    [chars]
Syntax:                                           	    Range:  [char-char]
             if [ tests... ];                     	    Class:  [[:class:]]
             then <commands>;                     	    Not in: [^chars]
             elif [ tests... ]; then <cmds>;      	  Alternate:(exp|exp)
             else <commands>;                     	
             fi                                   	Extended REGEX for grep and "test =~":
                                                  	  Character: [chars]
1 Line:      [ test ] && ( commands )             	  Char Range:[char-char]
Unless:      [ test ] || ( commands )             	  Any Char:  .
                                                  	  Repetition:* + ? {n}
Case:        case value in      use "$var"        	  Anchors    ^ $
               pattern) commands ;;               	  Escape:    \char
               *) commands ;;  else               	  Alternate: (exp|exp)
             esac                                 	
  See "Patterns" and "Test command"               	==========================================
                                                  	             TEXT MANIPULATION
==========================================        	==========================================
             FILE PROCESSING                      	
==========================================        	Length:      ${#var}
                                                  	Substring:   ${var:start:len}   first=0
Read STDIN:  while read varname; do...            	             ${var:start}       to end
Filename:    while read varname; do               	
               statements...                      	Default:     ${var-default} ${var:-default}
             done < $filename                     	  Can be:          literal, $var, `cmd`
                                                  	Set to Default: ${var=default}
Slurp:       var=`cat $filename`                  	  Like:         $var = ${var-default}
                                                  	Alternate:   ${var+alt_value}
ReplaceFile: echo $data > $file                   	  Like:         $var ? alt_value : ""
Truncate:    echo -n "" > $file                   	Die:         ${var?errmsg}
  Or:        truncate -s 0 $file                  	  Like:         die errmsg unless $var
Write/Append: echo $line >> $file                 	 
                                                  	Strip Lead:  ${var#Pattern}    shortest
                                                  	             ${var##Pattern}   longest
                                                  	String End:  ${var%Pattner}    shortest
                                                  	             ${var%%`attern}   longest
                                                  	
                                                  	Replace:     ${var/Pattern/Replace}
                                                  	  Global:    ${var//Pattern/Replace}
                                                  	  Prefix:    ${var/#Pattern/Replace}
                                                  	  Suffix:    ${var/%Pattern/Replace}
                                                  	
                                                  	Variable globbing, returns matching varnames
                                                  	  Prefix:    ${!varprefix*} ${!varprefix@}
                                                  	  Ex:        for var in ${!namespace*}; ...
                                                  	