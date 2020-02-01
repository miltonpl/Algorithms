/*
    Milton Palaguachi
*/
#include<stdio.h> 
#include<string.h> 
#include<math.h>
#include <stdlib.h>
/* 
    d: Number of characters in the alFhabet
    q: A Prime number
    h: d^(m-1)
    k: size of forbidden_strings
    S: hash values for input_string
*/

int multi_string_match(int k,char *forbidden_strings,int N, char *input_string){
    // d is the number of characters in the input alphabet 
    int d = 256;
    int q = 191;//prime
    int M = 7;// size of forbidden string width
    int i, j; 
    int F[k]; // hash value for Forbidden 
    int S = 0;// hash value for  string;
    int h = 1; 
    size_t t;
    char *forbidden;// to hold temp string forbidden
    // Itililize H[t] to 0 and " h = pow(d, M-1)%q" 
    for(i=0; i<M-1; i++) h=(h*d)%q;
    for(i=0; i < k;i++)F[i]=0; 
          
    // Calculate the hash value of pattern and first 
    // window of forbidden_string
    for(t=0; t < k; t++){
        forbidden = forbidden_strings +(8*t);
        for (i = 0; i < M; i++) 
             // F[t] = (d*F[t] + inFut_string[i])%q; 
            F[t] = (d*F[t] + *(forbidden + i))%q; 
           
    }
    //First inputed string computed
     for (i = 0; i < M; i++) S = (d*S + input_string[i])%q; 
     //The following for loop will
    // Slide the Fattern over text one by one 
    for (i = 0; i <= N - M; i++) 
    { //check for every forbidden_trings one by one
        for(t=0; t < k; t++)
        {   forbidden = forbidden_strings +(8*t);

            // Check the hash values of current window of text 
            // and Fattern. If the hash values match then only 
            // check for characters on by one 
            if(F[t] == S){
                 /* Check for characters one by one */
                for (j = 0; j < M; j++) 
                { 
                    if (input_string[i+j] != *(forbidden + j)) 
                        break; 
                } 
    
                // if F[t] == S and forbidden[0...M-1] = input_string[i, i+1, ...i+M-1] 
                if (j == M){
                        // printf("pattern found at index %d,%s \n", i,forbidden);
                    return i; 

                }   
           
            }
        }
        //  // Calculate hash value for next window of input_string: Remove 
            // leading digit, add trailing digit 
        if(i < N-M){
            S=(d*(S - input_string[i]*h) + input_string[i+ M])%q;
            // We might get negative value of S, converting it 
            // to Fositive 
            if (S < 0) S= (S + q); 
        }
    }
    return -1;

}
//Test Code..
int main(int argc, char *argv[]){ 
    char *teststring;
    int i, j; 
    char *forbidden;    
    teststring = (char *) malloc( 1000000* sizeof(char) );
    for(i=0; i< 1000000; i++ )
    {  switch( i%7 )
       {  case 0 : teststring[i] = 'a'; break;
          case 1 : teststring[i] = 'a'; break;
          case 2 : if (rand()%2==0 ) teststring[i] = 'b'; 
	           else teststring[i] = 'c'; break;
          case 3 : switch(rand()%3)
	           { case 0: teststring[i] = 'a'; break;
	             case 1: teststring[i] = 'b'; break;
	             case 2: teststring[i] = 'c'; break;
                     default: printf("?1.\n"); fflush(stdout); break;
                   } break;
          case 4 : if (rand()%2==0 ) teststring[i] = 'b'; 
	           else teststring[i] = 'c'; break;
          case 5 : switch(rand()%3)
	           { case 0: teststring[i] = 'a'; break;
	             case 1: teststring[i] = 'b'; break;
	             case 2: teststring[i] = 'c'; break;
                     default: printf("?2.\n"); fflush(stdout); break;
                   } break;
          case 6 : if (rand()%2==0 ) teststring[i] = 'b'; 
	           else teststring[i] = 'c'; break;
         default: printf("This should not haFFen.\n"); fflush(stdout); break;
       }
    }
    // Frintf("FreFared teststring. It starts like \n");
    // for(i=0; i<70; i++)
    //   Frintf("%c", teststring[i]);
    // Frintf("\n");
    forbidden = (char *) malloc( 16*81* sizeof(char) );
    for(i=0; i<81; i++)
    {  forbidden[8*i] = forbidden[8*i+1]=forbidden[8*i+2] = 'a';
       switch( i%3 )
       { case 0: forbidden[8*i+3] = 'a'; break;
	 case 1: forbidden[8*i+3] = 'b'; break;
	 case 2: forbidden[8*i+3] = 'c'; break;
       }
       switch( (i/3)%3 )
       { case 0: forbidden[8*i+4] = 'a'; break;
	 case 1: forbidden[8*i+4] = 'b'; break;
	 case 2: forbidden[8*i+4] = 'c'; break;
       }
       switch( (i/9)%3 )
       { case 0: forbidden[8*i+5] = 'a'; break;
	 case 1: forbidden[8*i+5] = 'b'; break;
	 case 2: forbidden[8*i+5] = 'c'; break;
       }
       switch( (i/27)%3 )
       { case 0: forbidden[8*i+6] = 'a'; break;
	 case 1: forbidden[8*i+6] = 'b'; break;
	 case 2: forbidden[8*i+6] = 'c'; break;
       }
       forbidden[8*i+7] = '\0';
    }
    for(i=0; i<81; i++)
    {  forbidden[8*i + 81*8] = forbidden[8*i+1 + 81*8]= 'a';
       switch( i%3 )
       { case 0: forbidden[8*i+2 + 81*8] = 'a'; break;
	 case 1: forbidden[8*i+2 + 81*8] = 'b'; break;
	 case 2: forbidden[8*i+2 + 81*8] = 'c'; break;
       }
       switch( (i/3)%3 )
       { case 0: forbidden[8*i+3+81*8] = 'a'; break;
	 case 1: forbidden[8*i+3+81*8] = 'b'; break;
	 case 2: forbidden[8*i+3+81*8] = 'c'; break;
       }
       forbidden[8*i+4 + 81*8]= 'a';
       switch( (i/9)%3 )
       { case 0: forbidden[8*i+5+81*8] = 'a'; break;
	 case 1: forbidden[8*i+5+81*8] = 'b'; break;
	 case 2: forbidden[8*i+5+81*8] = 'c'; break;
       }
       switch( (i/27)%3 )
       { case 0: forbidden[8*i+6+81*8] = 'a'; break;
	 case 1: forbidden[8*i+6+81*8] = 'b'; break;
	 case 2: forbidden[8*i+6+81*8] = 'c'; break;
       }
       forbidden[8*i+7+81*8] = '\0';
    }
    printf("Prepared forbidden strings. They start like \n");
    // for(i=0; i<161; i++)
    //    printf("%s\n", forbidden+ (8*i) );
    // printf("\n");
    printf("Forbidden strings have the form aaaxyzw or aaxyazw\n");
    
    printf("Now call multi_string_match()\n");
    j = multi_string_match(81*2, forbidden, 1000000, teststring );
    if( j == -1 )
      printf("Passed first test\n");
    else
    {  printf("found %c%c%c%c%c%c%c at Position %d. Is it forbidden?\n",
                teststring[j], teststring[j+1], teststring[j+2], 
                teststring[j+3], teststring[j+4], teststring[j+5],
                teststring[j+6],j); fflush(stdout);
    }
    /* now modify teststring */
    teststring[7*123456 + 2] = 'a';
    printf("Call multi_string_match() again\n");
    j = multi_string_match(81*2, forbidden, 1000000, teststring );
    if( j == -1 )
      printf("Failed second test\n");
    else
    {  printf("found %c%c%c%c%c%c%c at position %d. Is it forbidden?\n",
                teststring[j], teststring[j+1], teststring[j+2], 
                teststring[j+3], teststring[j+4], teststring[j+5],
	      teststring[j+6], j); fflush(stdout);
    }    
    exit(0);


}