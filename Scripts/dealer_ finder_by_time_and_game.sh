#!/bin/bash

# Users inputs
read -p "input date(MMDD): " date
read -p "input hour (HH): " h
read -p 'input AM or PM:' m
read -p "enter letter game(b for BlackJack / r for Roulette / t for TexasHoldE): " g

date=0311
h=01
m=PM
g=r

# Variables
path=~/Lucky_Duck_Investigations/Dealer_Schedules_0310/
time=$(echo "$h:00:00 $m")

# Validate date exists in the database
if [ ! -f "$path$date"_Dealer_schedule ]; then
    echo 'The date does not match any date on the database. Date input example for March eleven: 0311'
    exit 1
#elif [ ! $(grep -q "$time" "$path$date"_Dealer_schedule) eq 1 ]; then
#elif [ $(ls $path | grep -q "$date"_Dealer_schedule) eq 1 ]; then
    echo -e 'The hour does not match any hour on the database./n hour input example for 1:00 PM: 01/n AM/PM example: PM'
elif [ $g == 'b' ]; then
    cat "$path$date"_Dealer_schedule | awk '{print $1, $2, $3, $4}' | grep "$time"
elif [ $g == 'r' ]; then
    cat "$path$date"_Dealer_schedule | awk '{print $1, $2, $5, $6}' | grep "$time"
elif [ $g == 't' ]; then 
    cat "$path$date"_Dealer_schedule | awk '{print $1, $2, $7, $8}' | grep "$time"
else
    echo wrong game input
fi