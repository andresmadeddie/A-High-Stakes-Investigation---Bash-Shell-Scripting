#!/bin/bash

# Variables
root=~/Lucky_Duck_Investigations
roulette=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation
dealerAnalysis=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Dealer_Analysis
playerAnalysis=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Analysis
pdCorrelation=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Dealer_Correlation
losses=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Dealer_Correlation/losses
dealers=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Dealer_Correlation/dealers
times=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Dealer_Correlation/times
players=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Dealer_Correlation/players
suspectDealer=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Dealer_Correlation/suspectDealer
suspectPlayer=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Dealer_Correlation/suspectPlayer
conclusion=~/Lucky_Duck_Investigations/Roulette_Loss_Investigation/Player_Dealer_Correlation/conclusion

# 1 #
# File Structure
if [ ! -d $HOME/Lucky_Duck_Investigations/ ];
then
    mkdir $root $roulette $dealerAnalysis $playerAnalysis $pdCorrelation
    touch $losses $players $dealers $times $suspectDealer $suspectPlayer
    cd $root
    wget "https://tinyurl.com/3-HW-setup-evidence" && chmod +x ./3-HW-setup-evidence && ./3-HW-setup-evidence && rm 3-HW-setup-evidence 
fi

# 2 #
# Move dealers files (days 10, 12, 15) from the given folder to 'Dealer_Analysis folder'
find $root/Dealer_Schedules_0310 -type f \( -iname '*0310*' -o -iname '*0312*' -o -iname '*0315*' \) -exec mv -t $dealerAnalysis {} +
# Move players files (days 10, 12, 15) from the given folder to 'Player_Analysis folder'
find $root/Roulette_Player_WinLoss_0310 -type f \( -iname '*0310*' -o -iname '*0312*' -o -iname '*0315*' \) -exec mv -t $playerAnalysis {} +

# 3 #
# Extract the date, time, first and last name of the roulette dealers
grep : $dealerAnalysis/* | awk -F"/" '{print $7}' | sed 's/_Dealer_schedule//' | awk '{print $1, $2, $5, $6}' > $dealers
# Extract the date, time and players when the losses occurred
grep - $playerAnalysis/* | awk -F"/" '{print $7}' | sed 's/_win_loss_player_data//' > $losses
lossesHours=$(grep - $playerAnalysis/* | wc -l)

# 4 #
# Match times of losses with the dealers' schedule
awk '{print $1, $2}' $losses > $times
grep -f $times $dealers > $suspectDealer
# Count players who appear in more than one of the hours the casino had losses
awk '{print $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15}' $losses | sed s'/,/ /'g | sed s'/  / /'g > $players
for player in $(head -1 $players); do if [ $(grep $player $players | wc -w) -gt 12 ]; then echo $player >> $suspectPlayer; fi; done

# 5 #
# Conclusions
echo -e '\nDealers working during the hours of losses\nDate:time              Name' | tee -a $conclusion
cat $suspectDealer | tee -a $conclusion
echo -e '\n\nPlayers at the Roulette during losses' | tee -a $conclusion
grep -f $suspectPlayer $losses | tee -a $conclusion
echo -e '\nName        # Hours / total hours' | tee -a $conclusion
echo -e $(cat $suspectPlayer): '   ' $(grep -f $suspectPlayer $losses | wc -l) '/' $lossesHours | tee -a $conclusion
echo -e '\nTHE EVIDENCE POINTS TO:' | tee -a $conclusion
suspectarray=( $(head -1 $players) ); echo -e "Dealer: $(cat $suspectDealer | head -1 | awk '{print $3, $4}')\nPlayer: ${suspectarray[4]} ${suspectarray[5]}" | tee -a $conclusion
echo '\ncheck the conclusion file at' $conclusion