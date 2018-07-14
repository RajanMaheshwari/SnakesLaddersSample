# SnakesLaddersSample

<b>Architecture</b><br>
The architecture currently used is MVC. However if the things go beyond then the architecture can be mixed into MVC+Facade
<br><br>

<b>Classes</b>

<b>SLStartVC</b><br>

This consists of a simple snakes and ladders background with a play button. Play button tap will lead to Game and Player Details Screen

<b>SLPlayerGameDetailsVC</b><br>
This class consists of game settings which include taking the input from user:
1. No of lines
2. Players Names

Conditions:
The no of lines can be between 3-7 and no of players can be maximum 4 and minimum 2
On tap on play button it will lead to Main Game play screen

<b>SLPlayVC</b><br>
1. This consists of main game play. It includes the basic game logic. 4 players upto max can play the game.<br>
2. There is a power label for each ladder and snake consisting block which indicates the player can move up and down to a certain block number respectively<br>
3. On 6 of dice, the player currently playing will get a chance again to throw the dice.<br>
4. Player reaching first to the last value block is declared as a winner and will move to Winning Screen<br>

<b>SLWinningVC</b><br>
This consists of a simple congratulations label with a winner name
There is button Play Again which will again move the screen to Play scene with all settings reset.

<br>
<b>Managers</b><br>
Currently using two managers<br>

GameManager - Which handles some game logic<br>
SoundManager - Which handles sound in the game logic<br>
