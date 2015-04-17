#/!bin/bash
#
#
# Author:  Taco Bakker
# Purpose: Monitore the system for heavy load
#          find jobs with cpu load >= 90%, longer that 5 seconds
#          and alert root with an email
#

# Commands to use:
# ps -eo pcpu,pid -o comm= | head
# mail -s "performance is too high" root < .
# dd if=/dev/zero of=/dev/null


# request the system load with command
#alternative grep ^' [0-9]'   --> do it with single quotes, do net let the shell interpret stuff
#other alternative: ps -eo pcpu,pid -o comm= | awk '$1>90 { print $0 }' 

measurecpu()
{
  HIGHEST=$(ps -eo pcpu,pid -o comm= | sort -rn | grep -v CPU | head -n1)
  CPUPERC=$(echo $HIGHEST | awk '{print $1}')
  PROCPID=$(echo $HIGHEST | awk '{print $2}')
  PROCNAME=$(echo $HIGHEST | awk '{print $3}')
  CPUPERC=${CPUPERC%%.*}
}

# set the cpu limit percentage
TOOHIGH=1

#alternative while sleep 5
while true
do
  measurecpu
  ps -eo pcpu,pid -o comm= | sort -rn | grep -v CPU > output1
  CPUPERC1=$CPUPERC
  PROCPID1=$PROCPID
  PROCNAME1=$PROCNAME
  if [ ! -z $PROCPID1 ] ; then
    if [ $CPUPERC1 -ge $TOOHIGH ] ; then
      sleep 5
      measurecpu
      ps -eo pcpu,pid -o comm= | sort -rn | grep -v CPU > output2
      CPUPERC2=$CPUPERC
      PROCPID2=$PROCPID
      PROCNAME2=$PROCNAME
      if [[ $CPUPERC2 -ge $TOOHIGH && $CPUPID1 == $CPUPID2 ]] ; then
        echo "Houston we have a problem! Process name: " $PROCNAME2 " PID: " $PROCPID2 " CPU load: " $CPUPERC2
        #mail -s "performance is too high" root < . 2> /dev/null
      fi
    fi
  fi
  sleep 10
done

exit 0
