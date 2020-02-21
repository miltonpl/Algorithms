## Language Use For This Project
The implementation of this code was done using C/C++ libraries on Mac PC.
the libraries Xlib library was used from XQuatz from linux.
## The code was run from the terminal on current file.
```bash
//Step 1 g++ motion_planning.cpp -o motion_planning -lX11 -lm -L/usr/X11R6/lib
//Step 2 ./motion_planning data.txt
```
## Data Txt File
The data.txt file contains vehicule shape 
- V(x,y)(x2,y2)(x3,y3),
- start pososition S(x,y),
- targte posiong T(x,y) 
- obstible dimentions O(x,y)(x2,y2)(x3,y3).
## Vehicle Funtionality Order
The funtionality of the vehicle: can move to left, riht, up,down, and counter clockwire rotation.
Node that the veicule should move and rotate in that order, so that it does rotate in circles.
