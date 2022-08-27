#!/bin/bash

# Variables
root=~/Lucky_Duck_Investigations
roulette=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation
dealerAnalysis=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis
playerAnalysis=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Analysis
correlation=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Dealer_Correlation

# 1 #
# File Structure
if [ ! -d $HOME/Lucky_Duck_Investigations/ ];
then
    mkdir $root $roulette $dealerAnalysis $playerAnalysis $correlation 
    cd $root
    wget "https://tinyurl.com/3-HW-setup-evidence" && chmod +x ./3-HW-setup-evidence && ./3-HW-setup-evidence && rm 3-HW-setup-evidence 
fi

# 2 #
# Move dealers files (days 10, 12, 15) from the given folder to 'Dealer_Analysis folder'
find $root/Dealer_Schedules_0310 -type f \( -iname '*0310*' -o -iname '*0312*' -o -iname '*0315*' \) -exec mv -t $dealerAnalysis {} +
# Move players files (days 10, 12, 15) from the given folder to 'Player_Analysis folder'
find $root/Roulette_Player_WinLoss_0310 -type f \( -iname '*0310*' -o -iname '*0312*' -o -iname '*0315*' \) -exec mv -t $playerAnalysis {} +

# Extract the date, time, first and last name of the roulette dealers
grep : $dealerAnalysis/* | awk -F"/" '{print $7}' | sed 's/_Dealer_schedule//' | awk '{print $1, $2, $5, $6}' > $correlation/dealers
# Extract the date, time and players when the losses occurred
grep - $playerAnalysis/* | awk -F"/" '{print $7}' | sed 's/_win_loss_player_data//' > $correlation/players

# take times of looses and match with dealers working during those hours
awk '{print $1, $2}' $correlation/players > $correlation/times
grep -f $correlation/times $correlation/dealers > $correlation/correlation

# Count players who appear in more than one of the hours the casino had losses

awk '{print $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15}' $correlation/players | sed s'/,/ /'g | sed s'/  / /'g > $correlation/p

for x in $(cat $correlation/p | wc -w); do echo $x && awk '{print $x, $(($x+1))}' $correlation/p; done

for x in $(cat $correlation/p | wc -w); do echo $x && awk '{print $(($x+1))}' $correlation/p; done









# 3
# Isolate and analyse data in Player_Analysis folder (TIMES-PAYERS-COUNT) send output to Notes_Player_Analysis
# Execute in Player_Analysis folder
grep - * $playerAnalysis > Roulette_Losses
awk '{print $1,$2}'  Roulette_Losses > $playerAnalysis/Notes_Player_Analysis
grep Mylie Roulette_Losses | wc -l >> $playerAnalysis/Notes_Player_Analysis

# 4
# Separate the data in the Notes_Player_Analysis (TIMES-OF-LOSSESS) by days. Save and name by date in different files in new folder SupportFiles 
# Execute in any folder
# Create new folder
mkdir $correlation/supportFiles
# For day 0310
awk '{print $1,$2}' FS='_win_loss_player_data:' $playerAnalysis/Notes_Player_Analysis | sed '$d' | sed '$d'| grep 0310 | awk '{print $2,$3}' > $correlation/supportFiles/0310
# For day 0312
awk '{print $1,$2}' FS='_win_loss_player_data:' $playerAnalysis/Notes_Player_Analysis | sed '$d' | sed '$d'| grep 0312 | awk '{print $2,$3}' > $correlation/supportFiles/0312
# For day 0315
awk '{print $1,$2}' FS='_win_loss_player_data:' $playerAnalysis/Notes_Player_Analysis | sed '$d' | sed '$d'| grep 0315 | awk '{print $2,$3}' > $correlation/supportFiles/0315

# 5
# Compare the times with dealers. Save output in Dealers_working_during_losses file
# Excecute in Dealer_Analysis folder
grep -f $correlation/supportFiles/0310 0310_Dealer_schedule | awk '{print $1,$2,$5,$6}' > $dealerAnalysis/Dealers_working_during_losses
grep -f $correlation/supportFiles/0312 0312_Dealer_schedule | awk '{print $1,$2,$5,$6}' >> $dealerAnalysis/Dealers_working_during_losses
grep -f $correlation/supportFiles/0315 0315_Dealer_schedule | awk '{print $1,$2,$5,$6}' >> $dealerAnalysis/Dealers_working_during_losses

# 6
# Record dealer and times in Notes_Dealer_Analysis
# Excecute in Dealer_Analysis folder
echo Billy Jones >> Notes_Dealer_Analysis
cat  Dealers_working_during_losses | wc -l >> Notes_Dealer_Analysis
