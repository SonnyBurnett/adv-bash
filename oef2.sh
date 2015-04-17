#!/bin/bash
#
#
# Author:  Taco Bakker
# Purpose: Test a user specified path and give feedback to this user
#

# loop door alle argumenten

for VALUE in "$@"
do 

# Test if the entered path is an absolute path
# could have done it with regex   ^/  

  FIRSTCHAR=$(echo $VALUE | cut -c1)
  if [ $FIRSTCHAR == "/" ] ; then
    echo "This is an absolute path"
  else
    echo "This is not an absolute path"
    exit 1
  fi

# Test if the path/file exists

  if [ -e $VALUE ] ; then
    echo "path exists"
  else
    echo "path does not exists"
    exit 1
  fi

# Substract the filename and show

  FILENAME=${VALUE##*/}
  if [ -f $FILENAME ] ; then
    echo "This is a file: " $FILENAME
    DIRNAME=${VALUE%/*}
    echo "This is the directory: " $DIRNAME
  else
    DIRNAME=$VALUE
    echo "This is a directory: " $DIRNAME
  fi


# Count the number of directories in the path


  REST=$DIRNAME
  TELLER=0
  while [ ! -z $REST ]
  do
     REST=${REST%/*}
     (( TELLER++ ))
  done
  echo "Directory consists of " $TELLER "parts"

done
exit 0
