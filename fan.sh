#!/bin/bash

#Define GPIO pin 18 as PWM
gpio -g mode 18 pwm

num=true
while [ $num ]; 
do
# Print CPU temp
temp=$(cat /sys/class/thermal/thermal_zone0/temp)
temp=$(($temp/1000))
clear
printf "Temperature: $tempºC\nTurning on fan."

# Variable temperature control
if [ $temp -gt 40 ] && [ $temp -lt 69 ];
then
vartemp=$(echo $[ temp * 13 ])
gpio -g pwm 18 $vartemp

# Maximum fan RPM
elif [ $temp -ge 69 ];
then
gpio -g pwm 18 1024

# Switch off the fan
else
gpio -g pwm 18 0
clear
printf "Temperature: $tempºC\nFan off."
sleep 60
fi

#Pause 1 second
sleep 1

done
exit 0