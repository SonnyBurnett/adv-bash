#/!bin/bash
#
#
# Author:  Taco Bakker
# Purpose: Count the number of text files on the system and store them in an archive.
#

# count number of files on system that are pure text files

# cleanup before we start
[ -f txtfile ] && rm txtfile
[ -f txtarchive ] && rm txtarchive

# browse through the system
# check if a file is of type text
# and if so write the filename to a textfile
find /etc -name '*' | xargs file | grep text >> txtfile

#alternative:
# find /etc -type f -exec grep -Il . {} 2>/dev/null \;

# count the number of lines in the textfile
# which is also the number of textfiles found 
#COUNTER=$(wc -l txtfile | cut -d' ' -f1)
COUNTER=$(wc -l txtfile | awk '{print $1}')
echo "The number of text files is: "$COUNTER

# loop through the textfile line-by-line
# cut out the absolute path of the filename
# and add these to a tar file
while read REGEL
do
  echo $REGEL | cut -d':' -f1 | tar rvf txtarchive   
done < txtfile

#Alternative
# tar --files-from=txtarchive -cf archive

exit 0
