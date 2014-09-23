# Ruby Wars

Ruby Wars is a knockoff of the arcade classic Geometry Wars.  The goal of the game is to build a program that will save the world.  Along the way you have to fight off all the bugs trying to destroy your program.  If you get hit by a bug then the game is over.  For each bug you kill your points go up and the longer you stay alive the more points you get for killing bugs.

Along the way you will find power ups that you can use to help you build the program.  There are help requests that drop in the form of pictures of the Experience Engineers at [Launch Academy](http://www.launchacademy.com).  When used the help requests will kill all bugs currently on the screen.  If you find the Rails power up you will increase the speed that your bullets shoot in order to write the program quicker.  Finally, the last power up you can get is binding.pry.  When you activate a pry all bugs are paused so you can go around and kill them.

## High Scores

High scores are automatically displayed on: http://rubywars.herokuapp.com/. To change the name that you want to be displayed on the site you must pass the name as an argument value on the command line when launching the game. Names with spaces must be put into quotes on the command line.

Example:
```
$ ruby game.rb Spencer

OR

$ ruby game.rb "Spencer Dixon"
```

## Controls

Move: A/W/S/D (A = left, S = down, W = up, D = right)  
Shoot: J/I/K/L (J = left, K = down, I = up, L = right)  

Space: Use help request (if you have any)  
P: Use binding.pry (if you have any)  

R: Reset game if there was a gameover

This game includes many images and sounds that are copyrighted by their respective owners.


## Screenshots
