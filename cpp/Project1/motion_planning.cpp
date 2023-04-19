//Author: Milton Palaguachi 
//Project: Implementation of the BFS Algorithm in 2D plane
//Language: C/C++
 //run this command in terminal 
 //Step 1 g++ motion_planning.cpp -o motion_planning -lX11 -lm -L/usr/X11R6/lib
 //Step 2 ./motion_planning data.txt

 /*
// #define N 100  
// #define ROW 500// for coundry check
// #define COL 500 //for boundry check
// #define ANGLE 36
//matrix[N][N][ANGLE]
 */
 #include<iostream>
#include <stdio.h> 
#include <stdlib.h> 
#include <limits.h> 
#include <math.h>
#include<vector>
#include<queue>
#include <unistd.h> //sleep();
#include <X11/Xlib.h>
struct Point { //point x,y and angle k for rotation
	int x,y,k; 
}; 
 
 struct Triangle_{//Triangle points a,b c .points[0],points[1],points[2]
     Point points[3];
 };
struct Triangle{// this struct will be use to return points after rotation
    int x0,y0,x1,y1,x2,y2;
};

// check boundries 
bool isValid(Point p) { 
    int row= p.y,col=p.x;
    int ROW=500,COL =500;
	// return true if row number and column number is in range 
	return ((row >= 0) && (row < ROW) && (col >= 0) && (col < COL)); 
} 

// check boundries 
bool isValid(int row, int col,int phi) { 
     int ROW=100,COL =100,ANGLE=36;
	// return true if N number and column number is in range 
	return (row >= 0) && (row < ROW) && (col >= 0) && (col < COL)&& (phi < ANGLE)&& (phi >= 0); 
} 
// if sign is > 0 then is clockwize other wise is counter clock wise
float sign (Point p1, Point p2, Point p3){
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}
// bool pointInTriangle( Point a,  Point b,  Point c,  Point p)
//check if point is in triagle
bool pointInTriangle(Triangle_ A, Triangle_ B){ // if triagle B in A or A and B
//     A={a1,a2,a3}
//     B={b1,b2,b3} 
         // if Aa in B{Ba,Bb.Bc}
        if(!(((sign(A.points[0], B.points[0], B.points[1]) < 0) || (sign(A.points[0], B.points[1], B.points[2]) < 0) || (sign(A.points[0], B.points[2], B.points[0]) < 0)) &&
             ((sign(A.points[0], B.points[0], B.points[1]) > 0) || (sign(A.points[0], B.points[1], B.points[2]) > 0) || (sign(A.points[0], B.points[2], B.points[0]) > 0))) )
            return true;
            // if Ab in B{Ba,Bb.Bc}
        if(!(((sign(A.points[1], B.points[0], B.points[1]) < 0) || (sign(A.points[1], B.points[1], B.points[2]) < 0) || (sign(A.points[1], B.points[2], B.points[0]) < 0)) &&
             ((sign(A.points[1], B.points[0], B.points[1]) > 0) || (sign(A.points[1], B.points[1], B.points[2]) > 0) || (sign(A.points[1], B.points[2], B.points[0]) > 0))) )
            return true;
              // if Ac in B{Ba,Bb.Bc}
        if(!(((sign(A.points[2], B.points[0], B.points[1]) < 0) || (sign(A.points[2], B.points[1], B.points[2]) < 0) || (sign(A.points[2], B.points[2], B.points[0]) < 0)) &&
             ((sign(A.points[2], B.points[0], B.points[1]) > 0) || (sign(A.points[2], B.points[1], B.points[2]) > 0) || (sign(A.points[2], B.points[2], B.points[0]) > 0))) )
            return true;
            // if Ba in A{Aa,Ab,Ac}
        if(!(((sign(B.points[0], A.points[0], A.points[1]) < 0) || (sign(B.points[0], A.points[1], A.points[2]) < 0) || (sign(B.points[0], A.points[2], A.points[0]) < 0)) &&
             ((sign(B.points[0], A.points[0], A.points[1]) > 0) || (sign(B.points[0], A.points[1], A.points[2]) > 0) || (sign(B.points[0], A.points[2], A.points[0]) > 0))) )
            return true;
               // if Bb in A{Aa,Ab,Ac}
        if(!(((sign(B.points[1], A.points[0], A.points[1]) < 0) || (sign(B.points[1], A.points[1], A.points[2]) < 0) || (sign(B.points[1], A.points[2], A.points[0]) < 0)) &&
             ((sign(B.points[1], A.points[0], A.points[1]) > 0) || (sign(B.points[1], A.points[1], A.points[2]) > 0) || (sign(B.points[1], A.points[2], A.points[0]) > 0))) )
            return true;
               // if Bc in A{Aa,Ab,Ac}
        if(!(((sign(B.points[2], A.points[0], A.points[1]) < 0) || (sign(B.points[2], A.points[1], A.points[2]) < 0) || (sign(B.points[2], A.points[2], A.points[0]) < 0)) &&
             ((sign(B.points[2], A.points[0], A.points[1]) > 0) || (sign(B.points[2], A.points[1], A.points[2]) > 0) || (sign(B.points[2], A.points[2], A.points[0]) > 0))) )
            return true;

    return false;
}
//check: if there an tersection of triangle edges
bool TriangleIntersect( Triangle_ A, Triangle_ B){
    
    bool checkIntersection = false;
        //ab intersect xy
    if((sign( A.points[0], A.points[1], B.points[0] )*sign( A.points[0], A.points[1], B.points[1] ) < 0) 
    && (sign( B.points[0], B.points[1], A.points[0] )*sign( B.points[0], B.points[1], A.points[1] ))< 0)
            checkIntersection = true;
        //ac intersect xy
     if((sign( A.points[0], A.points[2], B.points[0] )*sign( A.points[0], A.points[2], B.points[1] ) < 0) 
     && (sign( B.points[0], B.points[1], A.points[0] )*sign( B.points[0], B.points[1], A.points[2] )) < 0)
            checkIntersection = true;
               //bc intersect xy
    if((sign( A.points[1], A.points[2], B.points[0] )*sign( A.points[1], A.points[2], B.points[1] ) < 0) 
    && (sign( B.points[1], B.points[1], A.points[1] )*sign( B.points[0], B.points[1], A.points[2] )) < 0)
            checkIntersection = true;        
        //ab intersect yz
    if((sign( A.points[0], A.points[1], B.points[1] )*sign( A.points[0], A.points[1], B.points[2] ) < 0) 
    && (sign( B.points[1], B.points[2], A.points[0] )*sign( B.points[1], B.points[2], A.points[1] ))< 0)
            checkIntersection = true;
        //ac intersetc yz
     if((sign( A.points[0], A.points[2], B.points[1] )*sign( A.points[0], A.points[2], B.points[2] ) < 0) 
     && (sign( B.points[1], B.points[2], A.points[0] )*sign( B.points[1], B.points[2], A.points[2] )) < 0)
            checkIntersection = true;
        //bc intersect yz
    if((sign( A.points[1], A.points[2], B.points[1] )*sign( A.points[1], A.points[2], B.points[2] ) < 0) 
    && (sign( B.points[1], B.points[2], A.points[1] )*sign( B.points[1], B.points[2], A.points[2] )) < 0)
            checkIntersection = true;
            //ab interset xz
    if((sign( A.points[0], A.points[1], B.points[0] )*sign( A.points[0], A.points[1], B.points[2] ) < 0) 
    && (sign( B.points[0], B.points[2], A.points[0] )*sign( B.points[0], B.points[2], A.points[1] ))< 0)
            checkIntersection = true;
        //ac intersect xz
     if((sign( A.points[0], A.points[2], B.points[0] )*sign( A.points[0], A.points[2], B.points[2] ) < 0) 
     && (sign( B.points[0], B.points[2], A.points[0] )*sign( B.points[0], B.points[2], A.points[2] )) < 0)
            checkIntersection = true;
               //bc intersect xz
    if((sign( A.points[1], A.points[2], B.points[0] )*sign( A.points[1], A.points[2], B.points[2] ) < 0) 
    && (sign( B.points[0], B.points[2], A.points[1] )*sign( B.points[0], B.points[2], A.points[2] )) < 0)
            checkIntersection = true;
    return checkIntersection;
}
//Trianble rotation
Triangle rotate_triangle(Triangle_ abc,int thetha)
{
    Triangle t;
    float radians = (M_PI/180.0)*thetha;
    float  sinTheta=sin(radians),cosTheta=cos(radians);
    float tp;

    tp = (abc.points[0].x*cosTheta - abc.points[0].y*sinTheta); t.x0 = tp;
    tp = (abc.points[0].x*sinTheta + abc.points[0].y*cosTheta); t.y0 = tp;  
    tp = (abc.points[1].x*cosTheta - abc.points[1].y*sinTheta); t.x1 = tp;
    tp = (abc.points[1].x*sinTheta + abc.points[1].y*cosTheta); t.y1 = tp; 
    tp = (abc.points[2].x*cosTheta - abc.points[2].y*sinTheta); t.x2 = tp;
    tp = (abc.points[2].x*sinTheta + abc.points[2].y*cosTheta); t.y2 = tp;
    
    return t;
}
// update point triangle to point p. curr*5 becuase steps of 5 in SCREEN(500,500)
void update_location(XPoint * V, XPoint * position,int curr_x,int curr_y){
     for (int i=0; i< 3; i++){
          position[i].x = (V[i].x + curr_x*5);
          position[i].y = (V[i].y + curr_y*5);
          }

}
// takes points of triangle, new pointes, than and the new value is stored in the new_points after rotation
 void rotate(XPoint *points,XPoint *new_points,float thetha){
     XPoint t[3];
     //times 10 because  the agle is muliples of 10 and the number passed will be from 0 to 35
     float radians = (M_PI/180.0)*(thetha*10);
     float sinTheta=sin(radians),cosTheta=cos(radians);
     float tp;// float is use so the interger presion is not lost after multiplication with cos(thetha) and sin(thetha)
    for (int i=0; i< 3; i++){

    tp = (points[i].x*cosTheta - points[i].y*sinTheta); t[i].x = tp;
    tp = (points[i].x*sinTheta + points[i].y*cosTheta); t[i].y = tp;  
    }
    new_points[0].x = t[0].x; new_points[0].y = t[0].y; new_points[1].x = t[1].x; new_points[1].y = t[1].y; new_points[2].x = t[2].x; new_points[2].y = t[2].y;
}
// fill the 3D matrix at initial time
void fillMatrix(std::vector < std::vector < std::vector <unsigned long int> > >&M,struct Triangle_ V,struct Triangle_ O[30],struct Point S,struct Point T,int startphi,int targetphi,int number_O)
{ 
    Point p,a,b,c;
    Triangle rV;
    int POINT_IN_TRIANGLE = 1,N =100;
    Triangle_ Av,Bo,newV;
    // std::vector < std::vector <std::vector <int> > >M;
    for(int row = 0; row< N; row++){
        M.push_back(std::vector < std::vector <unsigned long int > >());
        for(int col = 0; col< N; col++){
            M[row].push_back(std:: vector <unsigned long int>());
            for(int k =0; k< 36; k++){
                p.x = row*5; p.y = col*5;//point in matrix

                rV = rotate_triangle(V,k*10);
                Av.points[0].x = (rV.x0 + p.x); Av.points[0].y = (rV.y0 + p.y);
                Av.points[1].x = (rV.x1 + p.x); Av.points[1].y = (rV.y1 + p.y);
                Av.points[2].x = (rV.x2 + p.x); Av.points[2].y = (rV.y2 + p.y);
                for(int z = 0; z<number_O; z++){//iterate all obstacles
                   // check if Triangle points is in any of the obstible or etersects with obsticles
                   // if any intersection set ZER)
                    if(pointInTriangle(Av,O[z]) || TriangleIntersect(Av,O[z])) POINT_IN_TRIANGLE = 0;
                }
                // if no intersection on any points of Triable in any Obstibles triangle  or no boundry colletion: push_back(1)
                if(isValid(Av.points[0]) && isValid(Av.points[1]) && isValid(Av.points[2]) && POINT_IN_TRIANGLE) 
                    M[row][col].push_back(1);
                else
                    M[row][col].push_back(0);
                POINT_IN_TRIANGLE = 1;

            }
        }
    }
}
//Implementation of The Breath First Search(BFS) Algorithm in in 2D but becuase of angle, x,y will in 3D
//These arrays are used to get N and column 
// numbers of 4 neighbours of a given cell 

// function to find the shortest back_path between 
// a given source cell to a destination cell. 
int BFS(std::vector< std::vector< std::vector<unsigned long int> > > mat,std::vector< Point >&vecBackWard, Point src, Point dest) 
{ 
	int NNum[] = {-1, 0, 0, 1}; 
    int colNum[] = {0, -1, 1, 0}; 
    int  N =100, ANGLE = 36; // N size fo matrix, ANGLE multiple of 10
	// check source and destination cell in matrix: 1 ther is: otherwise 0 no point is in matrix
	// of the matrix have value 1
	if (!mat[src.x][src.y][src.k] || !mat[dest.x][dest.y][dest.k]) {
         std::cout<<"src("<<src.x<<"," <<src.y<<") k: "<<src.k<<" m: "<<mat[src.x][src.y][src.k]<<'\n'; 
          std::cout<<"dest("<<dest.x<<"," <<dest.y<<") k: "<<dest.k<<" m: "<<mat[dest.x][dest.y][dest.k]<<'\n'; 
        return -1; 
    }
	bool visited[N][N][ANGLE]; 
	//Initialize 3D visited array to all false
    for(size_t i=0; i < N; i++)
        for(size_t j; j < N; j++)
            for(size_t g=0;j<ANGLE; g++)
                visited[i][j][g]= false;
	
	// Mark the source cell as visited 
	visited[(src.x)][(src.y)][src.k] = true; 

	// Create a queue for BFS 
	std::queue<Point> q;
    std::vector<Point> vec_back_paths;
	q.push(src); // Enqueue source cell 

	// Do a BFS starting from source cell 
	while (!q.empty()) 
	{ 
        //curr= current point, previous->neighbords, kptrack to back track tha shortest back_path.
		Point curr = q.front(),previous = q.front(),kptrack;
		// Otherwise dequeue the front cell in the queue 
		// and enqueue its adjacent cells 
        // If we have reached the destination cell, 
		// we are done 
		if (curr.x == dest.x && curr.y == dest.y && curr.k == dest.k){ 
            int len=vec_back_paths.size()-1;
            //if start from A->B is we are at point B is because therese is a point A that connect to B so we must have pair in a vector(vec_paths_back)
            
			for(int i=len ;i >= 0; i-=2 ){
                if((vec_back_paths[i-1].x== dest.x && vec_back_paths[i-1].y == dest.y) && vec_back_paths[i-1].k == dest.k){
                    vecBackWard.push_back(vec_back_paths[i-1]);
                    kptrack=vec_back_paths[i];
                }
                else if(vec_back_paths[i-1].x== kptrack.x && vec_back_paths[i-1].y == kptrack.y && vec_back_paths[i-1].k == kptrack.k){
                    vecBackWard.push_back(vec_back_paths[i-1]);
                    kptrack=vec_back_paths[i];
                }
                else;
            }

            vecBackWard.push_back(src);//add astart position to end of vector        
            return 1;
        }
		q.pop(); 
		for (int i = 0; i < 4; i++) //four neibords
		{ 
			int row = curr.x + NNum[i]; 
			int col = curr.y + colNum[i]; 
			
			// if adjacent cell is valid, has back_path and 
			// not visited yet, enqueue it. 
            for(int phi = 0; phi < ANGLE; phi++){

            	if (isValid(row, col, phi) && mat[row][col][phi] && !visited[row][col][phi]) { 
				// mark cell as visited and enqueue it 
					visited[row][col][phi] = true; 
					Point p ={row,col,phi};
					q.push(p);
                	vec_back_paths.push_back(p);//child_point
					vec_back_paths.push_back(previous);//to go back to parent_point from child_point
				} 
            }
		} 
	} 

	// Return -1 if destination cannot be reached 
	return -1; 
} 
// will use XQuarts in Mac to display on screen.
Display *display;
Window  window;
int border_width;
unsigned int win_width, win_height;
int win_x, win_y;

XSetWindowAttributes attributes;
unsigned long valuemask = 0;
XGCValues gr_values,gc_yellow_values;
Colormap color_map;
XFontStruct *fontinfo;
XColor tmp_color1, tmp_color2;
GC gc_red,gc_yellow,gc_green;
Visual *visual;
int depth;
int screen;
XEvent event;
XColor    color, dummy;

int main(int argc,char *argv[]) {
     int startx,starty,startphi,targetx,targety,targetphi;
    int i,finished,number_O;
    Point S,T;
    Triangle_ car,Obstacle[30];
    FILE * inputfile;
     if(argc != 2){
          printf("need file name as command line argument.\n");fflush(stdout);
                 exit(0);
          }
     inputfile= fopen(argv[1],"r");
        
     if(fscanf(inputfile, "V (%d,%d) (%d,%d) (%d,%d)\n",
            &(car.points[0].x),&(car.points[0].y),&car.points[1].x,&(car.points[1].y),&(car.points[2].x),&(car.points[2].y)) != 6){
                    printf("Error in the first line.\n");fflush(stdout);
                    exit(0);
                }
     if(fscanf(inputfile, "S (%d,%d) %d\n",&S.x, &S.y, &startphi) != 3){
                    printf("Error in the Second line.\n");fflush(stdout);
                    exit(0);
                }            
     if(fscanf(inputfile, "T (%d,%d) %d\n",&T.x, &T.y, &targetphi) != 3){
                printf("Error in the third line.\n");fflush(stdout);
                    exit(0);
                }  
     i=0;finished=0;
     while(i<30 && !finished){          
          if(fscanf(inputfile, "O (%d,%d) (%d,%d) (%d,%d)\n",
           &(Obstacle[i].points[0].x), &(Obstacle[i].points[0].y), &(Obstacle[i].points[1].x), &(Obstacle[i].points[1].y), &(Obstacle[i].points[2].x), &(Obstacle[i].points[2].y)) != 6)
               finished =1;
          else i+=1;
     }
     number_O=i;
     printf("found %d Oicles. so far ok\n",i);
     //vector matrix for 3D[i][j][k]
     std::vector < std::vector < std::vector <unsigned long int> > >matrix;
     std::vector< Point >back_path;//return path from BFS
    
    fillMatrix(matrix,car,Obstacle,S,T,startphi,targetphi,number_O);
    //angle divides by 10 and target and start divides by 5 for matrix[100][100][36]: 
    S.k = (startphi/10);T.k = (targetphi/10);
     S.x = (S.x/5); S.y = (S.y/5);
     T.x = (T.x/5); T.y = (T.y/5);
    int val = BFS(matrix,back_path, S, T);
    std::vector<Point>vecpath(back_path.rbegin(),back_path.rend());//reversing the path
   
    XPoint newV[3],positon[3],V[]={{(short)car.points[0].x, (short)car.points[0].y},
                                   {(short)car.points[1].x, (short)car.points[1].y},
                                   {(short)car.points[2].x, (short)car.points[2].y}};
    int npoints= sizeof(V)/sizeof(XPoint);

    if((display = XOpenDisplay(NULL))== NULL){
          printf("Could not open display. \n"); exit(-1);}
     screen = DefaultScreen(display);
     visual = DefaultVisual(display,screen);
     depth  = DefaultDepth(display,screen);
     color_map= XDefaultColormap(display,screen);
      /* creating the window */
     border_width = 10;
     win_x = 0; win_y = 0;
     win_width= 500;
     win_height= 500;

     attributes.background_pixel = XWhitePixel(display,screen);

     window = XCreateWindow( display,XRootWindow(display,screen),
                            win_x, win_y, win_width, win_width, border_width,
                             depth,  InputOutput,
                            visual ,CWBackPixel, &attributes);
     XSelectInput(display,window,ExposureMask | KeyPressMask) ;
     fontinfo = XLoadQueryFont(display,"6x10");

     XAllocNamedColor(display, DefaultColormap(display, screen),"red",&color,&dummy);

     gr_values.font = fontinfo->fid;
     gr_values.foreground = color.pixel;
     gc_red=XCreateGC(display,window,GCFont+GCForeground, &gr_values);
     gc_yellow = XCreateGC( display, window, valuemask, &gc_yellow_values);
     if( XAllocNamedColor( display, color_map, "yellow", &tmp_color1, &tmp_color2 ) == 0 )
     {printf("failed to get color yellow\n"); exit(-1);} 
     else
     XSetForeground( display, gc_yellow, tmp_color1.pixel );

     gc_green = XCreateGC( display, window, valuemask, &gc_yellow_values);
     if( XAllocNamedColor( display, color_map, "green", &tmp_color1, &tmp_color2 ) == 0 )
     {printf("failed to get color yellow\n"); exit(-1);} 
     else
     XSetForeground( display, gc_green, tmp_color1.pixel );

     XFlush(display);
     XMapWindow(display,window);
     XFlush(display);

     while(1){
        XNextEvent(display,&event);

        switch(event.type){
        case Expose:
                 XFlush(display);
            //    XDrawLines(display, window, gc_green, startp,nstartp ,0);
               // XDrawLines(display, window, gc_green, targetp,nstartp ,0);
               for(int i=0; i< number_O; i++){
               XPoint opoints[3] = {{(short)Obstacle[i].points[0].x, (short)Obstacle[i].points[0].y},
                                    {(short)Obstacle[i].points[1].x, (short)Obstacle[i].points[1].y},
                                    {(short)Obstacle[i].points[2].x, (short)Obstacle[i].points[2].y}};
               int nopoints= sizeof(opoints)/sizeof(XPoint);
               XFlush(display);
               XFillPolygon(display,window, gc_yellow, opoints, nopoints, 2,0);
               XFlush(display);
               }
               printf("Shortest path b\n");
               for (size_t i = 0; i < vecpath.size(); i++){

                printf("n %lu(%d,%d,%d)\n",i, vecpath[i].x, vecpath[i].y, vecpath[i].k);
            
               XFlush(display);
               usleep(100000);
               rotate(V,newV,vecpath[i].k);
                XFlush(display);
                usleep(100000);
               update_location(newV,positon,vecpath[i].x, vecpath[i].y);
               usleep(100000);
               XFlush(display);
               XFillPolygon(display,window, gc_red,positon, npoints, 2,0);
               XFlush(display);
            }
             break;
        case KeyPress:
             XCloseDisplay(display);
             return 1;

        }
     
    }
 
	return 0; 
} 
