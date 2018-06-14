Basics

All bash scripts must tell the o/s what to use as the interpreter. The first line of any script should be:

#!/bin/bash

You must make bash scripts executable.

chmod +x filename

Variables

Create a variable - just assign value. Variables are non-datatyped (a variable can hold strings, numbers, etc. with out being defined as such).

varname=value

Access a variable by putting $ on the front of the name

echo $varname

Values passed in from the command line as arguments are accessed as $# where #= the index of the variable in the array of values being passed in. This array is base 1 not base 0.
command var1 var2 var3 .... varX
$1 contains whatever var1 was, $2 contains whatever var2 was, etc.

Built in variables:

$1-$N	Stores the arguments (variables) that were passed to the shell program from the command line.
$?	Stores the exit value of the last command that was executed.
$0	Stores the first word of the entered command (the name of the shell program).
$*	Stores all the arguments that were entered on the command line ($1 $2 ...).
"$@"	Stores all the arguments that were entered on the command line, individually quoted ("$1" "$2" ...).

Quote Marks

Regular double quotes ("like these") make the shell ignore whitespace and count it all as one argument being passed or string to use. Special characters inside are still noticed/obeyed.

Single quotes 'like this' make the interpreting shell ignore all special characters in whatever string is being passed.

The back single quote marks (`command`) perform a different function. They are used when you want to use the results of a command in another command. For example, if you wanted to set the value of the variable contents equal to the list of files in the current directory, you would type the following command: contents=`ls`, the results of the ls program are put in the variable contents.

Logic and comparisons

A command called test is used to evaluate conditional expressions, such as a if-then statement that checks the entrance/exit criteria for a loop.

test expression
Or
[ expression ]

Numeric Comparisons


int1 -eq int2	Returns True if int1 is equal to int2.
int1 -ge int2	Returns True if int1 is greater than or equal to int2.
int1 -gt int2	Returns True if int1 is greater than int2.
int1 -le int2	Returns True if int1 is less than or equal to int2
int1 -lt int2	Returns True if int1 is less than int2
int1 -ne int2	Returns True if int1 is not equal to int2

String Comparisons
str1 = str2	Returns True if str1 is identical to str2.
str1 != str2	Returns True if str1 is not identical to str2.
str	Returns True if str is not null.
-n str	Returns True if the length of str is greater than zero.
-z str	Returns True if the length of str is equal to zero. (zero is different than null)
File Comparisons

-d filename	Returns True if file, filename is a directory.
-f filename	Returns True if file, filename is an ordinary file.
-r filename	Returns True if file, filename can be read by the process.
-s filename	Returns True if file, filename has a nonzero length.
-w filename	Returns True if file, filename can be written by the process.
-x filename	Returns True if file, filename is executable.


Expression Comparisons
!expression

Returns true if expression is not true
expr1 -a expr2

Returns True if expr1 and expr2 are true. ( && , and )
expr1 -o expr2

Returns True if expr1 or expr2 is true. ( ||, or )



Logic Con't.

If...then

if [ expression ]
then
commands
fi


If..then...else

if [ expression ]
then
commands
else
commands
fi


If..then...else If...else

if [ expression ]
then
commands
elif [ expression2 ]
then
commands
else
commands
fi

Case select

case string1 in
str1)
commands;;
str2)
commands;;
*)
commands;;
esac

string1 is compared to str1 and str2. If one of these strings matches string1, the commands up until the double semicolon (; ;) are executed. If neither str1 nor str2 matches string1, the commands associated with the asterisk are executed. This is the default case condition because the asterisk matches all strings.

Iteration (Loops)

for var1 in list
do
commands
done

This executes once for each item in the list. This list can be a variable that contains several words separated by spaces (such as output from ls or cat), or it can be a list of values that is typed directly into the statement. Each time through the loop, the variable var1 is assigned the current item in the list, until the last one is reached.

while [ expression ]
do
commands
done

until [ expression ]
do
commands
done

Functions

Create a function:

fname(){
commands
}


Call it by using the following syntax: fname

Or, create a function that accepts arguments:

fname2 (arg1,arg2...argN){
commands
}

And call it with: fname2 arg1 arg2 ... argN


#====================================================================================================================

Tests (for ifs and loops) are done with [ ] or with the test command.
Checking files:
-r file Check if file is readable.
-w file Check if file is writable.
-x file Check if we have execute access to file.
-f file Check if file is an ordinary file (as opposed to a directory, a device special file, etc.)
-s file Check if file has size greater than 0.
-d file Check if file is a directory.
-e file Check if file exists. Is true even if file is a directory.
Example:
if [ -s file ]
then
 #such and such
fi
Checking strings:
s1 = s2 Check if s1 equals s2.
s1 != s2 Check if s1 is not equal to s2.
-z s1 Check if s1 has size 0.
-n s1 Check if s2 has nonzero size.
s1 Check if s1 is not the empty string.
Example:
if [ $myvar = "hello" ] ; then
echo "We have a match"
fi
Checking numbers:
Note that a shell variable could contain a string that represents a number. If you want to check the numerical value use one of
the following:
n1 -eq n2 Check to see if n1 equals n2.
n1 -ne n2 Check to see if n1 is not equal to n2.
n1 -lt n2 Check to see if n1 < n2.
n1 -le n2 Check to see if n1 <= n2.
n1 -gt n2 Check to see if n1 > n2.
n1 -ge n2 Check to see if n1 >= n2.
Example:
if [ $# -gt 1 ]
then
 echo "ERROR: should have 0 or 1 command-line parameters"
fi
Boolean operators:
! not
-a and
-o or
Example:
if [ $num -lt 10 -o $num -gt 100 ]
then
 echo "Number $num is out of range"
elif [ ! -w $filename ]
» Bash Cheat Sheet Johns Blog Page 1 of 4
http://www.johnstowers.co.nz/blog/index.php/reference/bash-cheat-sheet/ 18/3/2553
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
The above example also illustrates the use of read to read a string from the keyboard and place it into a shell variable. Also
note that most UNIX commands return a true (nonzero) or false (0) in the shell variable status to indicate whether they
succeeded or not. This return value can be checked. At the command line echo $status. In a shell script use something like
this:
if grep -q shell bshellref
then
 echo "true"
else
 echo "false"
fi
Note that -q is the quiet version of grep. It just checks whether it is true that the string shell occurs in the file bshellref. It does
not print the matching lines like grep would otherwise do.
I/O Redirection:
pgm > file Output of pgm is redirected to file.
pgm < file Program pgm reads its input from file.
pgm >> file Output of pgm is appended to file.
pgm1 | pgm2 Output of pgm1 is piped into pgm2 as the input to pgm2.
n > file Output from stream with descriptor n redirected to file.
n >> file Output from stream with descriptor n appended to file.
n >& m Merge output from stream n with stream m.
n <& m Merge input from stream n with stream m.
<< tag Standard input comes from here through next tag at start of line.
Note that file descriptor 0 is normally standard input, 1 is standard output, and 2 is standard error output.
Shell Built-in Variables:
$0 Name of this shell script itself.
$1 Value of first command line parameter (similarly $2, $3, etc)
$# In a shell script, the number of command line parameters.
$* All of the command line parameters.
$- Options given to the shell.
$? Return the exit status of the last command.
$$ Process id of script (really id of the shell running the script)
Pattern Matching:
* Matches 0 or more characters.
? Matches 1 character.
[AaBbCc] Example: matches any 1 char from the list.
[^RGB] Example: matches any 1 char not in the list.
[a-g] Example: matches any 1 char from this range.
Quoting:
\c Take character c literally.
`cmd` Run cmd and replace it in the line of code with its output.
"whatever" Take whatever literally, after first interpreting $, `...`, \
'whatever' Take whatever absolutely litera
match=`ls *.bak` #Puts names of .bak files into shell variable match.
echo \* #Echos * to screen, not all filename as in: echo *
echo '$1$2hello' #Writes literally $1$2hello on screen.
echo "$1$2hello" #Writes value of parameters 1 and 2 and string hello.
Grouping:
Parentheses may be used for grouping, but must be preceded by backslashes
since parentheses normally have a different meaning to the shell (namely
to run a command or commands in a subshell). For example, you might use:
if test \( -r $file1 -a -r $file2 \) -o \( -r $1 -a -r $2 \)
then
 #do whatever
fi
Case statement:
Here is an example that looks for a match with one of the characters a, b, c. If $1 fails to match these, it always matches the *
case. A case statement can also use more advanced pattern matching.
case "$1" in
 a) cmd1 ;;
 b) cmd2 ;;
 c) cmd3 ;;
 *) cmd4 ;;
esac
Loops:
Bash supports loops written in a number of forms,
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
 cat $x &gt;&gt; biglog
done
Shell Arithmetic:
In the original Bourne shell arithmetic is done using the expr command as in:
» Bash Cheat Sheet Johns Blog Page 3 of 4
http://www.johnstowers.co.nz/blog/index.php/reference/bash-cheat-sheet/ 18/3/2553
result=`expr $1 + 2`
result2=`expr $2 + $1 / 2`
result=`expr $2 \* 5` #note the \ on the * symbol
With bash, an expression is normally enclosed using [ ] and can use the following operators, in order of precedence:
* / % (times, divide, remainder)
+ - (add, subtract)
< > <= >= (the obvious comparison operators)
== != (equal to, not equal to)
&& (logical and)
|| (logical or)
= (assignment)
Arithmetic is done using long integers.
Example:
result=$[$1 + 3]
In this example we take the value of the first parameter, add 3, and place the sum into result.
Order of Interpretation:
The bash shell carries out its various types of interpretation for each line in the following order:
brace expansion (see a reference book)
~ expansion (for login ids)
parameters (such as $1)
variables (such as $var)
command substitution (Example: match=`grep DNS *` )
arithmetic (from left to right)
word splitting
pathname expansion (using *, ?, and [abc] )
Other Shell Features:
$var Value of shell variable var.
${var}abc Example: value of shell variable var with string abc appended.
# At start of line, indicates a comment.
var=value Assign the string value to shell variable var.
cmd1 && cmd2 Run cmd1, then if cmd1 successful run cmd2, otherwise skip.
cmd1 || cmd2 Run cmd1, then if cmd1 not successful run cmd2, otherwise skip.
cmd1; cmd2 Do cmd1 and then cmd2.
cmd1 & cmd2 Do cmd1, start cmd2 without waiting for cmd1 to finish. 