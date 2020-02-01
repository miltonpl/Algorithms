#include <stdio.h>
#include <stdlib.h>
#include <time.h> 
#include <iostream>
#include <vector>
int main(){
    int x,y,n;
    // max = 20000
    // min = -20000
    n=20000;

      srand(time(0));
       int count =40;
       for (size_t i = 0; i < count; i++)
       {
            y = (rand()%(2*n)) - n;
            x = (rand()%(2*n)) - n;

           printf("{\"i\": %lu, \"x\": %d, \"y\": %d},\n",i,x,y);
       }
       
}