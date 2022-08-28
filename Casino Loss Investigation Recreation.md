# Casino Loss Investigation Recreation
 Script: [A High Stakes Investigation](/Scripts/a_high_stakes_investigation.sh)

 Output File: [Conclusion](/Resources/conclusion)

---
>Note: This script recreate the sceneraio of teh investigation. the script will automatically download the ZIP files from the resource directory of this repository. Use the `rm -r ~/Lucky_Duck_Investigation` command to remove all data created by this script.
## Scenario

Lucky Duck Casino has lost a significant amount of money on the roulette tables over the last month. The manager believes a player works with a Lucky Duck dealer to steal money at the roulette tables. The casino has a large database with data on wins and losses, player analysis, and dealer schedules. The largest losses occurred on March 10, 12, and 15. You are tasked with navigating, modifying, and analyzing these data files to gather evidence on the rogue player and dealer. 

Lucky Duck Casino has provided you with the following files if required:

- [Roulette Player Data: Week of March 10](/Resources/Roulette_Player_WinLoss_0310.zip)
- [Employee Dealer Schedule: Week of March 10](/Resources/Dealer_Schedules_0310.zip)

>Note: These two ZIP files will be downloaded automatically by running the A High Stakes Investigation script.

## Investigation

The research process consisted of five steps. Each of the steps is described in the bash script comments.

Here is a resume of the steps:

1. Investigation file's structure (Directories ans files)
    - Lucky_Duck_Investigations
        - Dealer_Schedules_0310
        - Roulette_Player_WinLoss_0310
        - Roulette_Loss_Investigation
            - Player_Analysis
                - Extracted Roullette files
            - Dealer_Analysis
                - Extracted Dealers Schedules
            - Player_Dealer_Correlation
                - pdCorrelation
                - looses
                - dealers
                - players
                - suspecDealer
                - suspectPlayer
                - conclusion

2. Extract the largest losing days (10, 12 and 15) from the given files to a dealer and player folder respectively

3. Extract data on the times when losses occur and the hours of the roulette dealers.

4. Get the dealer and the player. From the date and times of the biggest losses, get the dealers and repeated players whose were at the roulette during that time.

5. Conclusions

## Output

After running the script, the conclusion will appear on the screen. In addition, a file containing the same information will be created. The file path will be displayed at the end of the script output.

The following is a 'print screen' of this conclusion. A copy of the conclusion file is stored in this repository. It can be accessed by clicking the link at the top of this page. (Conclusion)

![output](/Images/output.PNG)