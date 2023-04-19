// Milton Palaguachi
// The implementation of Kernighan-Lim Algorithm with array pointer..
/*
Function BinarySearch, bubblesort and swap; use to make sure j is not repeated after getting  random j
Function print graph: to print graph
Function: graph_part: compute kernighan-lin-algorithm and return a linklist as result.

*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h> 
#include <iostream>
#include <vector>
struct v_l { int v; struct v_l * next; } ;
typedef struct v_l vertex_list;
vertex_list * graph_part( int n, int k, vertex_list * edges[], int r );
bool binarySearch(std::vector<int> a, int x)
{
    int n = a.size();
   int low=0, mid, high=n-1;
   while(low <= high)
   {
        mid = (low + high) / 2;
        if (x < a[mid])
            high = mid - 1;
        else if (x > a[mid])
         low = mid + 1;
       else
         return true;
   }
   return false;
}
void swap_p(int &p1,int &p2){
    int temp = p1;
    p1 = p2;
    p2 = temp;
}

void bubbleSort(std::vector<int> &points){
    int i,j,n = points.size();
    for (i=0; i< n-1;i++){
        //last i element are already in place
        for(j= 0; j< n-i-1; j++){
            if(points[j] > points[j+1])
                swap_p(points[j],points[j+1]);
        }
    } 
}

void print_graph( int n,vertex_list * B[]){
size_t i;
vertex_list *tp;
    for (i = 0; i < n; i++)
    {
        tp = B[i];
        printf("node[%lu]",i);
        while(tp!= NULL)
        {   
            printf("%d->",tp->v);
            tp = tp->next;
        }
        printf("\n");
    }
}
int main()
{   vertex_list * graph[1000], *result, *e, *tmp;
    int i,j, cross;
    int partition[1000];
      srand(time(0));

    /* make empty graph */    
    e = (vertex_list *) malloc( 10000* sizeof(vertex_list) );
    for(i=0; i<1000; i++)
      graph[i] = NULL;
    printf("Test 1: A cycle with 1000 vertices\n");
    /* now fill it as a cycle */
    for(i=0,j=0; i<1000; i++)
      {  graph[i] = e+j; j+=1; /*next available edge node */
	(graph[i])->v = (i+999)%1000;
        (graph[i])->next = e+j; j+=1; /*next available edge node */
        (graph[i])->next->v = (i+1)%1000;
        (graph[i])->next->next = NULL;
      }
    printf("Made a cycle, now try to partition it\n"); fflush(stdout);
    // print_graph(20,graph);
    result=graph_part(1000, 500, graph, 200);
    printf("black in main\n");
    for(i=0; i<1000; i++)
       partition[i]=0;
    for( i=0, tmp=result; tmp != NULL; tmp=tmp->next )
    {   partition[tmp->v]=1; i+=1; }
    if( i != 500 )
      printf("the partition has %d vertices, not 500\n", i);fflush(stdout);
    for(i=0, cross = 0; i< 1000; i++)
    {  for( tmp = graph[i]; tmp != NULL; tmp = tmp-> next )  
       {  j = tmp->v;
	  if(partition[i] != partition[j])
             cross +=1;
       }
    }
    printf("Partition has %d crossing edges\n\n", cross/2); fflush(stdout);
    printf("Test 2: 300 cycles with 3 vertices each\n");
    /* now fill the graph*/
    for(i=0,j=0; i<300; i++)
    {    graph[3*i] = e+j; j+=1; /*next available edge node */
	(graph[3*i])->v = 3*i+1;
        (graph[3*i])->next = e+j; j+=1; /*next available edge node */
        (graph[3*i])->next->v = 3*i+2;
        (graph[3*i])->next->next = NULL;
         graph[3*i+1] = e+j; j+=1; /*next available edge node */
	(graph[3*i+1])->v = 3*i;
        (graph[3*i+1])->next = e+j; j+=1; /*next available edge node */
        (graph[3*i+1])->next->v = 3*i+2;
        (graph[3*i+1])->next->next = NULL;
         graph[3*i+2] = e+j; j+=1; /*next available edge node */
	(graph[3*i+2])->v = 3*i;
        (graph[3*i+2])->next = e+j; j+=1; /*next available edge node */
        (graph[3*i+2])->next->v = 3*i+1;
        (graph[3*i+2])->next->next = NULL;
    }
    printf("Made 300 K_, now try to partition it\n"); fflush(stdout);
    result=graph_part(900, 300, graph, 100);
    for(i=0; i<900; i++)
       partition[i]=0;
    for( i=0, tmp=result; tmp != NULL; tmp=tmp->next )
    {   partition[tmp->v]=1; i+=1; }
    if( i != 300 )
      printf("the partition has %d vertices, not 300\n", i);fflush(stdout);
    for(i=0, cross = 0; i< 900; i++)
    {  for( tmp = graph[i]; tmp != NULL; tmp = tmp-> next )  
       {  j = tmp->v;
	  if(partition[i] != partition[j])
             cross +=1;
       }
    }
    printf("Partition has %d crossing edges\n", cross/2); fflush(stdout);

    exit(0);
} 
vertex_list * graph_part( int n, int k, vertex_list * edges[], int r ){
     size_t i,j;
     vertex_list *result=NULL,*tmp;
     char partition[n];
     bool visited[n];
     int Da[n],Db[n],max_right_gain,max_left_gain,best_right_i,best_left_i,gain[n];//right(a) cound left(b) count
    std::vector<int> vec_r;
    printf("k:%d,r:%d\n",k,r);    
     for ( i = 0; i < n; i++){
         partition[i]='l';
         visited[i]=false;
     }
    j = rand()%(1000);
    vec_r.push_back(j);
    partition[j]= 'r';

    for (i= 1; i < r; i++)
    {
        bubbleSort(vec_r);
        while(binarySearch(vec_r,j))// if j is the same as before get a new j
            j = rand()%(1000-i);
        partition[j]='r';   
        vec_r.push_back(j);
    }  
    int count=0;
    while( count < r)
    {  
        count++;
        max_left_gain = max_right_gain = -100;
        best_left_i = best_right_i = -1;
        for ( i = 0; i < n; i++){
            Da[i]=0;
            Db[i]=0;
            }
         //  partition [1000] had 'l' or 'r'
        for(i = 0 ;i < n; i++)
        {    tmp = edges[i];
            // printf("node: %d\n",tmp->v);
            while( tmp !=NULL )
            {  if( partition[i] == partition[tmp->v] )
                Da[i]++; /* edge from i to neighbor in the same class */
            else
                Db[i]++; /* edge from i to neighbor in the other class */
            tmp = tmp->next;
            }
        }
        //compute gain
        for (i = 0; i < n; i++)
        {
            gain[i] = (Db[i] - Da[i]);
            // printf("%d = %d - %d\n",gain[i],Db[i],Da[i]);
        }
    //Find the max gain over the side of partition,
    //max gain over the other side of partition if sum > 0 exchange and  not mmel safe

    //Step 3:Find the largest gain of left and right that are not neibors
        for ( i = 0; i < n; i++){
            tmp= edges[i];

            if(partition[i] == 'l'){
                if(gain[i] > max_left_gain && (partition[tmp->v] != 'r' && partition[tmp->next->v] != 'r')){
                    max_left_gain = gain[i];
                    best_left_i = i;
                }
            }
            else
            // partition[i] == 'r'
            {
                if (gain[i] > max_right_gain && (partition[tmp->v] != 'l' && partition[tmp->next->v] != 'l')){
                    max_right_gain = gain[i];
                    best_right_i = i;
                }       
            } 
        }
        //check neibors:
        if(max_right_gain + max_left_gain > 0 && (visited[best_right_i] == false && visited[best_left_i] == false) ){

            //mark visited nodes
            visited[best_right_i] = true; 
            visited[best_left_i] = true;
            partition[best_left_i] = 'r';
            partition[best_right_i]= 'l';
        
            }
        }
    int u=0,last_u=-1;
    bool inwhile= false;
    for (int l = 0; l < k; l++)
    {
         /* 1. allocate node */
    vertex_list* new_node = (vertex_list*) malloc(sizeof(vertex_list)); 
   while(partition[u] == 'r'){
       if(u == l && inwhile == false) u = last_u;
       u++;
       inwhile= true;
        } 
        // printf("l: %c,u: %d\n",partition[u],u);
    if(inwhile == false){
        /* 2. put in the data  */
        new_node->v  = l; 
        /* 3. Make next of new node as head */
        new_node->next = (result); 
        /* 4. move the head to point to the new node */
        (result) = new_node;
        u = l;
    }
    else
    {
        last_u = u;
        /* 2. put in the data  */
        new_node->v  = u; 
        /* 3. Make next of new node as head */
        new_node->next = (result); 
        /* 4. move the head to point to the new node */
        (result) = new_node;
        //reset winwhile after been in while
        inwhile = false;
    }
    }
    return result;

}