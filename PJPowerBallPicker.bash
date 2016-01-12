#!/bin/bash
#pete@jalajas.com
#2016-01-11
#GPL 3.0 or any later version

#Selects PowerBall numbers from /dev/urandom, not /dev/random
#http://www.powerball.com/powerball/pb_prizes.asp

#WARNING:  Suggestions welcome.   Use at your own risk. 

#USAGE example: for mtix in {001..100} true ; do ./PJPowerBallPicker.bash ; done

#OUTPUT: like:
#2 14 20 39 67 / 18
#1 6 53 65 69 / 18
#16 42 62 65 67 / 9
#8 22 31 47 69 / 17
#37 43 54 62 63 / 24
#9 18 33 37 42 / 15
#7 14 42 50 65 / 9
#1 8 16 18 25 / 22
#9 19 28 34 49 / 23

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
#Select the white balls
while true
do
    #Gather a byte of random bits from urandom in form of decimal digits (0-256?).
    mball=" "$(od -A n -t d -N 1 /dev/urandom)" "
    #Test if in range
    if [ "$mball" -ge "$mAmin" ] && \
       [ "$mball" -le "$mAmax" ] ; then
       #Append to ticket
       mticket=" $mticket $mball "
       #Sort the ticket numbers and remove any duplicates
       mticket=$(echo $mticket | tr " " "\n" | sort -nu | tr "\n" " " )
       #echo $mticket
    fi

    #Count how many unique numbers we have so far...
    mpicks=$(echo $mticket | wc -w)

    #If we have enough numbers for a ticket, then break out of the loop
    if [ "$mpicks" == "$mAnum" ] ; then
        break
    fi
    #echo $mticket
done

#Select the powerball
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

#Append the powerball to the ticket string
mticket=$(echo $mticket "/" $mpowerball )

#Print out the ticket
echo $mticket

 
