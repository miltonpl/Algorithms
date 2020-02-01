// run this in the command window
// g++ convex_hull_rings.cpp -o file -ljson-c -lX11 -lm -L/usr/X11R6/lib
// ./file input.json
// #include<iostream>
#include <stdio.h> 
#include <stdlib.h> 
#include <limits.h> 
#include <math.h>
#include<json-c/json.h>
#include<vector>
// #include<queue>
#include <unistd.h> //sleep();
// #include <fstream>
#include <X11/Xlib.h>
#include <string>
// boundry limmints
std::vector<XPoint> boundry_limits(std::vector<XPoint> p,int w_width,int w_height) 
{
    std::vector<XPoint> pp;
    XPoint point;
    float max_x, max_y, min_x, min_y;

    min_x = p[0].x; //let, first element is the smallest one of X
    max_x = p[0].x; //also let, first element is the biggest one X
    min_y = p[0].y; //let, first element is the smallest one of Y
    max_y = p[0].y; //also let, first element is the biggest one Y
    for(int i = 1; i < p.size(); i++)  //start iterating from the second element
    {
        if(p[i].x < min_x) min_x = p[i].x;
        if(p[i].x > max_x) max_x = p[i].x;
        if(p[i].y < min_y) min_y = p[i].y;
        if(p[i].y > max_y) max_y = p[i].y;
        
    }
    
    max_x += 200; max_y += 200;
    min_x -= 200; min_y -= 200;
    float x_scalarfactor = float(w_width)/(max_x - min_x);
    float y_scalarfactor = float(w_height)/(max_y - min_y);
    printf("MaxX %f,MinX %f,MaxY %f,MinY%f,X %f,Y %f\n",max_x, min_x, max_y, min_y, x_scalarfactor,y_scalarfactor);
    // int point_x= x_scalarfactor(x-min_x);
    // int point_y= y_scalarfactor(y-min_y);
    for (size_t i = 0; i < p.size(); i++)
    {
        point.x = x_scalarfactor*(p[i].x - min_x);   
        point.y = y_scalarfactor*(p[i].y - min_y);
        pp.push_back(point);
    }

return  pp;
}
struct Edge{
    //edge: p.a----q.b
    XPoint a,b;
};
int search_index(std::vector<XPoint> v, XPoint item){
    size_t cnt = 0;
    size_t size= v.size();
    while (cnt < size){
        if (item.x == v[cnt].x && item.y == v[cnt].y)
            return (cnt);
        cnt++;
    }
    // We reach here when element is not 
        // present in array
    return -1;
}
void swap_p(XPoint *p1,XPoint *p2){
    XPoint temp = *p1;
    *p1 = *p2;
    *p2 = temp;
}
// void bubbleSort(XPoint points[],int n){
//     int i,j;
//     for (i=0; i< n-1;i++){
//         //last i element are already in place
//         for(j= 0; j< n-i-1; j++){
//             if(points[j].x > points[j+1].x)
//                 swap_p(&points[j],&points[j+1]);
//         }
//     } 
// }
void bubbleSort(std::vector<XPoint> &points,int n){
    int i,j;
    for (i=0; i< n-1;i++){
        //last i element are already in place
        for(j= 0; j< n-i-1; j++){
            if(points[j].x > points[j+1].x)
                swap_p(&points[j],&points[j+1]);
        }
    } 
}

// Orientation ABO: two vectors OA and OB 
// returns positive for counter clockwise 
// turn and negative for clockwise turn 
float orientation(XPoint O, XPoint A, XPoint B) 
{ 
	return (A.x - O.x) * (B.y - O.y) - (A.y - O.y) * (B.x - O.x); 
} 

// Returns a list of points on the convex hull 
// in counter-clockwise order 
std::vector<XPoint> convex_hull(std::vector<XPoint> A) 
{ 
	int n = A.size(), k = 0; 
    bubbleSort(A,n);
    // printf("sorted\n");
    // for(int i=0; i< n; i++)printf("%d ",A[i].x);
    // printf("\n");

	if (n <= 3) 
		return A; 

	std::vector<XPoint> hull(2 * n); 

	// Build lower hull 
	for (int i = 0; i < n; ++i) { 

		// If the point at K-1 position is not a part 
		// of hull as vector from hull[k-2] to hull[k-1] 
		// and hull[k-2] to A[i] has a clockwise turn 
		while (k >= 2 && orientation(hull[k - 2], hull[k - 1], A[i]) <= 0) 
			k--; 
		hull[k++] = A[i]; 
	} 

	// Build upper hull 
	for (size_t i = n - 1, t = k + 1; i > 0; --i) { 

		// If the point at K-1 position is not a part 
		// of hull as vector from hull[k-2] to hull[k-1] 
		// and hull[k-2] to A[i] has a clockwise turn 
		while (k >= t && orientation(hull[k - 2], hull[k - 1], A[i - 1]) <= 0) 
			k--; 
		hull[k++] = A[i - 1]; 
	} 

	// Resize the array to desired size 
	hull.resize(k - 1); 
   
	return hull; 
} 
void redure_points(std::vector<XPoint> hull,std::vector<XPoint>&points){
    size_t i,n= points.size();

     for(i=0; i< hull.size(); i++){
        int r= search_index(points,hull[i]);
        points[r]= points[n-i-1];
        points.pop_back();
    }

}
void reverse_order(std::vector<XPoint> &hull){
     //I need to reverse the order of hull
        hull.push_back(hull[0]); // so that h[0]== h[n]
        std::reverse(hull.begin(),hull.end());
        // printf("reverse_order\n");
        // for (int i = 0; i < hull.size(); i++) 
        // printf("%d ", hull[i].x) ;
        // printf("\n");

}
void oinion_peeler_hull(std::vector<XPoint> points,std::vector<std::vector <XPoint> > &rings,std::vector<Edge> &edges){
    
    std::vector<XPoint> q,p;
    // std::vector<std::vector <XPoint> > rings;
    // std::vector<Edge> edges;
    struct Edge ed;
    
    XPoint p0;
	// Find the convex hull 
    size_t m, n, i = 0,j = 0,k=0;
    p = convex_hull(points); //p is outer convex
    // In the reverse order function: we push the first point after the last point so that q0= qm
    reverse_order(p);
    rings.push_back(p);//first outer layer to my ring 2D vector

    while(points.size() > 3){
        printf("points size: %lu\n",points.size());
        int index_ed= edges.size();
            p = convex_hull(points); //p is outer convex
            redure_points(p, points);
            // In the reverse order function: we push the first point after the last point so that p0 = pn
            reverse_order(p);
            q = convex_hull(points); // q is inner convex
            // redure_points(q, points);
            // In the reverse order function: we push the first point after the last point so that q0= qm
            reverse_order(q);
            if(q.size() < 4) break;//max points{q0,q1,q2,q0} if less break;
            rings.push_back(q);//iner layer push back in ring 2D vec
            // size of  outer(p)->m and inner(q)->n convex
            m = p.size()-1;// outer
            n = q.size()-1;// inner
            j=0;i=0;
             // pi,qj
            // just add j=0---0i
            //insert edge p[i]q[j]::p.a----q.b
             printf("m:%lu,n:%lu\n",m,n);
            ed.a = p[i]; ed.b = q[j];
            edges.push_back(ed);
            while(1){
                // if n less than 2 I dont think we need to joint inner and outer points
                // not sure
                if(n <= 2 || m <= 2){
                    printf("break\n");
                    break;} 

                if(orientation(p[i],q[j],q[j+1]) > 0)
                {
                    printf("orientation:%f\n",orientation(p[i],q[j],q[j+1]));
                    printf("(p %d|q %d|q %d),j%lu\n",p[i].x,q[j].x,q[j+1].x,j);
                    j++;// j is for the inner convex
                    // leave some space i wrap around
                    if(j >=n){//inner convex n
                    //edge: p.a----q.b
                    /*
                            p0 is the point of the first edge in the vector
                            if orientation of p0,qn,qn-1,< pi do nothing just break
                            we know all the inner points are connected 
                            to at least one outer point and its angle < 180  
                    */
                        if(j==n )
                        {
                             while(orientation(q[j-1],q[j],p[i+k]) > 0 && i+k < m)
                        {      
                            printf("*while:orientation:%f\n",orientation(q[j-1],q[j],p[i+k]));
                            printf("(q %d|q %d|p %d),j%lu\n",q[j-1].x,q[j].x,p[i+k].x,j);

                            k = k+1;// k is for outer convex

                        }
                         // k-1 because in the while loop where k++ angle > then pi(or 180)

                        i = i + k-1;
                        printf("k %lu,i %lu\n",k,i);
                        //insert edge p[i]q[j]::p.a----q.b
                        ed.a = p[i]; ed.b = q[j];
                        edges.push_back(ed);
                        k=0;
                        if(m != i){
                            ed.a = p[m]; ed.b = q[j];
                            edges.push_back(ed);

                        }
                        break;

                        }
                        else// if j < n.. when of bound..
                            break;
                    }
                    
                    while(orientation(q[j-1],q[j],p[i+k]) > 0 && i+k < m)
                    {      
                        printf("**while:orientation:%f\n",orientation(q[j-1],q[j],p[i+k]));
                        printf("(q %d|q %d|p %d),j%lu\n",q[j-1].x,q[j].x,p[i+k].x,j);

                        k = k+1;// k is for outer convex

                    }
                        //leave some space i wrap around
                if(i + k >= m){//i+k== m(outer zise)
                              //insert edge p[i]q[j]:: p.a----q.b
                        size_t temp =i;
                        int t=0;
                        size_t i_one,i_two;
                        bool bool1 = true,bool2 = true;
                        i_one = i + k-1;
                        // printf("i+k==n:(%d,%d)\n",p[i].x, q[j].x);
                        // ed.a = p[i_one]; ed.b = q[j];
                        // edges.push_back(ed);
                        printf("i+k>= (%lui,%luj,%luk\n",i,j,k);
                        i_two = k + temp;
                        
                        k=0;
                        while(j < n ){
                            if(((orientation(p[i_one],q[j],q[j+1]) > 0) || (orientation(q[j-1],q[j],p[i_one]) > 0 )) && bool1 == true){
                                i = i_one;
                                printf("i_one: %lu\n",i);
                                // n-1 = j it won't come back in the while loop again.
                                // we want to check for  j=j-1 and the -->>orientation(p[i],q[j],q[j+1]) > 0 || orientation(q[j-1],q[j],p[i]) > 0
                                if(n-1 == j){
                                    t++;
                                    bool1= false;
                                }
                            }
                            else{
                                i = i_two; 
                                bool1=false;
                                t++;

                                 printf("i_two: %lu\n",i);
                            }
                                // will come only once here either when < if(n-1 == j) > or < else{} >
                            if(bool1== false && t == 1) j = j-1;
                            if(orientation(p[i],q[j],q[j+1]) > 0 || orientation(q[j-1],q[j],p[i]) > 0  ){
                                //insert edge p[i]q[j]::p.a----q.b
                                ed.a = p[i]; ed.b = q[j];
                                printf("%luj,%lui,%luk\n",j,i,k);
                                edges.push_back(ed);
                            }
                            printf("j++,: %luj,%lui\n",j,i);
                             j++;
                        }                   
                    }
                    
                    else{
                        // k-1 because in the while loop where k++ angle > then pi(or 180)
                        i = i + k-1;
                        printf("k %lu,i %lu\n",k,i);
                        //insert edge p[i]q[j]::p.a----q.b
                        ed.a = p[i]; ed.b = q[j];
                        edges.push_back(ed);
                        k=0;
                    }
                }
                else
                {
                    i++;
                    // insert edge p[i]q[j]: make sure is edge less than pi
                    // printf("else:(%d,%d)\n",p[i].x, q[j].x);
                    if(orientation(p[i],q[j],q[j+1]) > 0 && i < m){
                        //edge: p.a----q.b
                        ed.a = p[i];ed.b = q[j]; 
                        edges.push_back(ed);
                        printf("in else::%lui-%luj\n ",i,j);
                        printf("(%d,%d)-(%d,%d)\n",p[i].x,p[i].y,q[j].x,q[j].y);
                    }
                }   
        }
      
    }
    // for(int i=0; i < edges.size(); i++)
    //         printf("p.a(%d)--q.b(%d)\n",edges[i].a.x,edges[i].b.x);
}
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
int main(int argc, char *argv[])
{
   FILE *inputfile;
    if(argc != 2){
       printf("need file name as command line argument. \n");fflush(stdout);
       exit(0);
   }
   inputfile = fopen(argv[1],"r");//open file to read
   char buffer[10240];
   struct json_object *parsed_json;
   struct json_object *j_points;
   struct json_object *type;
   struct json_object *name;
   struct json_object *meta;
   struct json_object *comment;
   struct json_object *faces_in_triangulation;
   struct json_object *point,*x,*y;
   /*  for */
    size_t n_points;
    size_t i,j;
    XPoint p;
    std::vector<XPoint>points,inbound_points,ring;
    std::vector<std::vector <XPoint> > rings;
    std::vector<Edge> edges;

    fread(buffer,10240,1,inputfile);//store in buffer char array
    fclose(inputfile);//close file
    parsed_json = json_tokener_parse(buffer);
        
    json_object_object_get_ex(parsed_json, "points", &j_points);
    json_object_object_get_ex(parsed_json, "type", &type);
    json_object_object_get_ex(parsed_json, "name", &name);
    json_object_object_get_ex(parsed_json,"meta", &meta);
    n_points = json_object_array_length(j_points);
    //print info from json file
    printf("Found %lu points\n",n_points);
    printf("Type %s\n",json_object_get_string(type));
    printf("Name %s\n",json_object_get_string(name));
 
    comment = json_object_object_get(meta,"comment");
    faces_in_triangulation = json_object_object_get(meta,"faces_in_triangulation");
    printf("comment: %s\n",json_object_get_string(comment));
    printf("faces in triangulation: %d\n", json_object_get_int(faces_in_triangulation));
  //end
  //place points in vector points from json file
    for(i=0; i< n_points; i++){
        point = json_object_array_get_idx(j_points,i);
        x = json_object_object_get(point,"x"); 
        y = json_object_object_get(point,"y");
        p.x= (short)json_object_get_int(x); p.y = (short)json_object_get_int(y);
        points.push_back(p);
    }
    //end
    /// parameters for window..
     border_width = 10;
     win_x = 0; win_y = 0;
     win_width= 750;
     win_height= 750;

    //
    //inbound_points gets the max_x,max_y,min_x.. and puts in window 500 by 500
    inbound_points=boundry_limits(points,win_width,win_height);
    // for(i=0; i< inbound_points.size(); i++)printf("(%d,%d)\n",inbound_points[i].x,inbound_points[i].y);
     oinion_peeler_hull(inbound_points,rings,edges);
    int nseg_edges= edges.size();
    XSegment seg_edge[nseg_edges];//edges

     for(int i=0; i < nseg_edges; i++){//
        seg_edge[i].x1=edges[i].a.x; seg_edge[i].y1=edges[i].a.y;
        seg_edge[i].x2=edges[i].b.x; seg_edge[i].y2=edges[i].b.y;
        // printf("p.a(%d)--q.b(%d)\n",edges[i].a.x,edges[i].b.x);
     }

    printf("rings size:%lu\n",rings.size());
    for(int i=0; i < rings.size(); i++){
        ring=rings[i];
        for (size_t j = 0; j < ring.size(); j++) printf("%d {%d},",ring[j].x,ring[j].y);
        printf("\n");
        }

/////////////////////////////////////////////////////////////////

if((display = XOpenDisplay(NULL))== NULL){
          printf("Could not open display. \n"); exit(-1);}
     screen = DefaultScreen(display);
     visual = DefaultVisual(display,screen);
     depth  = DefaultDepth(display,screen);
     color_map= XDefaultColormap(display,screen);
      /* creating the window */

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
     int x_point,y_point,ring_size;

     while(1){
        XNextEvent(display,&event);

        switch(event.type){
        case Expose:

        //   XDrawPoints(display,window, gc_red, ppoints, n_ppoints,0);
        for (i = 0; i < inbound_points.size(); i++)
        {   // put an x in all the points in the creeen
            x_point= inbound_points[i].x; y_point= inbound_points[i].y;
             XFlush(display);
             XDrawString(display,window,gc_red,x_point,y_point,"x",1);
             XFlush(display);

        }
            for(i = 0; i< rings.size(); i++){// all layer_hulls
                ring= rings[i];//one layer_hull in vector ring
                ring_size= ring.size();
                XPoint points_ring[ring_size];//place in array to pass to XDrawLines
                for (j = 0; j < ring_size; j++) points_ring[j]= ring[j];
                XFlush(display);//draw layer one by one
                XDrawLines(display,window, gc_green, points_ring, ring_size,0);
                XFlush(display);
            }
            XFlush(display);//draw all edges
            XDrawSegments(display, window, gc_red, seg_edge, nseg_edges);
            XFlush(display);
            //    XDrawString(display,window,gc_red,7 ,7,"0",2);
            // XDrawString(display,window,gc_red,7 ,120,"1",2);
            // XFlush(display);
             break;
        case KeyPress:
             XCloseDisplay(display);
             return 1;

        }
     
    }
    
    return 0;
}