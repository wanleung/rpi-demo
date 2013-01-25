#!/bin/bash

function blink {
  echo "0" > /sys/class/gpio/gpio$1/value
  sleep 1
  echo "1" > /sys/class/gpio/gpio$1/value
}

function switchon {
    echo "0" > /sys/class/gpio/gpio$1/value
}
function switchoff {
    echo "1" > /sys/class/gpio/gpio$1/value
}



echo "17" > /sys/class/gpio/export
echo "in" > /sys/class/gpio/gpio17/direction
echo "18" > /sys/class/gpio/export
echo "in" > /sys/class/gpio/gpio18/direction

echo "21" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio21/direction
echo "22" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio22/direction
echo "23" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio23/direction

echo "1" > /sys/class/gpio/gpio21/value
echo "1" > /sys/class/gpio/gpio22/value
echo "1" > /sys/class/gpio/gpio23/value

S1=`cat /sys/class/gpio/gpio17/value`

while [ $S1 == "0" ]
do
    S1=`cat /sys/class/gpio/gpio17/value`
#    blink 21
#    S1=`cat /sys/class/gpio/gpio17/value`
#    blink 22
#    S1=`cat /sys/class/gpio/gpio17/value`
#    blink 23
    if [ 1 == `cat /sys/class/gpio/gpio18/value` ]; then
       switchon 21
       switchoff 22
       switchon 23
    else
       switchoff 21
       switchon 22
       switchoff 23
    fi
done

switchoff 21
switchoff 22
switchoff 23

echo "17" > /sys/class/gpio/unexport
echo "18" > /sys/class/gpio/unexport
echo "21" > /sys/class/gpio/unexport
echo "22" > /sys/class/gpio/unexport
echo "23" > /sys/class/gpio/unexport
