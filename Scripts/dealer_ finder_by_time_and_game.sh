#!/bin/bash

# Users inputs
read -p "input date(MMDD): " date
read -p "input hour (HH): " hour
read -p 'input AM or PM:' meridian
read -p "enter letter game(b for BlackJack / r for Roulette / t for TexasHoldE): " game

# Variables
path=~/Lucky_Duck_Investigations/Dealer_Schedules_0310/
time=$(echo "$hour:00:00 $meridian")


# FORMAT VALIDATION
# Validate date format
if [[ ! $date =~ ^[0-9]{4}$ ]]; then
    echo -e "Wrong date input. Please input date format (MMDD) Ex: 0311"
    exit 1
# Validate time format
elif [[ ! $hour =~ ^0[1-9]|1[0-2]$ ]]; then
    echo -e "Wrong hour input. Please input an hour between 01 and 12\nFormat: HH\nExample: 01"
    exit 1
# Validate Meridian format
elif [[ ! $meridian =~ ^[PApa][Mm]$ ]]; then
    echo -e "Wrong meridian input. Please input AM or PM"
    exit 1
fi


# EXISTENCE VALIDATION
# Validate date exists in the database
if [ ! -f "$path$date"_Dealer_schedule ]; then
    echo -e "The date does not match any date on the database/n Current available dates are:\n$(ls $path | sed 's/_Dealer_schedule//')"
    exit 1
# Validate hour exists in th database
elif [ $(ls $path | grep -q "$date") ]; then
    echo -e "The hour does not match any hour on the database.\n Current available times for $date are:\n$(cat "$path$date"_Dealer_schedule | awk '{print $1, $2}')"
    exit 1
# Validate game input
elif [[ ! $game =~ ^[btr]$ ]]; then
    echo -e "Wrong game input. Please choose between b, r, or t"
    exit 1
fi

# Display the query
echo -e "\n\n TIME       DEALER'S NAME\n"
if [ $game = 'b' ]; then
    cat "$path$date"_Dealer_schedule | awk '{print $1, $2, $3, $4}' | grep "$time"
elif [ $game = 'r' ]; then
    cat "$path$date"_Dealer_schedule | awk '{print $1, $2, $5, $6}' | grep "$time"
elif [ $game = 't' ]; then
    cat "$path$date"_Dealer_schedule | awk '{print $1, $2, $7, $8}' | grep "$time"
fi
echo -e "\n\n"