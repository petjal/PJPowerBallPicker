#!/bin/bash
#pete@jalajas.com
#2016-01-11
#GPL 3.0 or any later version

#Selects PowerBall numbers from /dev/urandom, not /dev/random
#http://www.powerball.com/powerball/pb_prizes.asp

#WARNING:  Suggestions welcome.   Use at your own risk. 

#USAGE: for mtix in {001..100} true ; do ./PJPowerBallPicker.bash ; done

#CREDITS:  
#Inspired by: https://www.random.org/quick-pick/?tickets=100&lottery=5x69.1x26
#Stolen from web:  od /dev/urandom , tr|sort, echo | wc 

#CONFIG
mAmin=1
mAmax=69  # white balls
mAnum=5   # number of white balls
mPmin=1
mPmax=26  # powerballs
mpicks=0
mticket=''  # will be like "09 12 27 35 58 / 22"

#MAIN
while true
do
    mball=" "$(od -A n -t d -N 1 /dev/urandom)" "
    if [ "$mball" -ge "$mAmin" ] && \
       [ "$mball" -le "$mAmax" ] && \
       [[ $mticket != .*\s${mball}\ .* ]] ; then
       mticket=" $mticket $mball "
       mticket=$(echo $mticket | tr " " "\n" | sort -nu | tr "\n" " " )
       #echo $mticket
    fi

    mpicks=$(echo $mticket | wc -w)

    if [ "$mpicks" == "$mAnum" ] ; then
        break
    fi
    #echo $mticket
done

while true
do
    mball=" "$(od -A n -t d -N 1 /dev/urandom)" "
    if [ "$mball" -ge "$mPmin" ] && \
       [ "$mball" -le "$mPmax" ] ; then
       mpowerball=$mball
       #echo \$mpowerball $mpowerball
       break
    fi
done

mticket=$(echo $mticket "/" $mpowerball )
echo $mticket

