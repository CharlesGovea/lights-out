# lights-out
A small puzzle based on the 1995 tiger game, made entirely in Julia

To play by yourself, select the option number 1 in the menu.
Here, a board will be randomly generated for you to solve by typying in the coordinates of the cell you wish to toggle using the format **n,n**, where **n** is a number between 1 and the length of the grid.

If you've selected solve, you'll need to provide a file containing a grid for the algorithm to solve by itself.
The grid must be either 5x5, 6x6 or 7x7 (though the algorithm is more than capable of solving bigger problems). The format of the grid file must be as follows:
```
n,n,n,...,n
n,n,n,...,n
...
n,n,n,...,n
```

Note that the separator between each value is a coma and there mustn't be any spaces or other character between each coma or number. (Check the format of the example in this repo if there's any doubt).
The program will ask you for the filename containing the grid and, after provided, will solve the grid (if a solution exists).

_Note: For a better experience, use with a terminal that can display emojis_