The implementation of this code was done using C/C++ libraries on Mac PC.
the libraries use for the visulization was Xlib library.
The code was run from the terminal on current file.
//Step 1 g++ motion_planning.cpp -o motion_planning -lX11 -lm -L/usr/X11R6/lib
//Step 2 ./motion_planning data.txt
 The data.txt file contains vehicule shape V(x,y), start pososition S(x,y), targte posiong T(x,y) and obstible dimentions O(x,y)
The funtionality of the vehicle to to move to left, riht, up,down, and counter clockwire rotation.
First move and rotate; in this order will be the prosess the moves
