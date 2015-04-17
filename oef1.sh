#/!bin/bash
#
#
# Author:  Taco Bakker
# Purpose: check what the file type is of user specified input
# 

# First write a diagram with the structure, before you start coding!


# Check if we've got an argument. If not ask for input

# Old code
#VALUE=$1
#until [ ! -z $VALUE ]
#do
#  read -p " Please enter input " VALUE
#done 


if [ $# -eq 0 ] ; then
   USERINPUT=""
   TELLER=1
   while [[ -z "$USERINPUT" && $TELLER -le 5 ]]
   do
     echo -n "[$TELLER/5] Please specify a file or directory:  " 
     read USERINPUT
     (( TELLER++ ))
   done
else
   USERINPUT=$1
fi

# give feedback about the result
# a) it's a file
# b) it's directory
# c) insult user

if [ -z $USERINPUT ] ; then
  echo "niks is maar niks" 
elif [ -f $USERINPUT ] ; then
  echo $USERINPUT " is a file"
elif [ -d $USERINPUT ] ; then
  echo $USERINPUT " is a directory"
else
  echo "You are good for nothing!"
fi 


exit 0
