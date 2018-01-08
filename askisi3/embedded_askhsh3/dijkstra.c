#include <stdio.h>
#include <stdlib.h>


#define NUM_NODES                          100
#define NONE                               9999

// DDTR 1
#if defined(SLL)
#include "../synch_implementations/cdsl_queue.h"
#elif defined(DLL)
#include "../synch_implementations/cdsl_deque.h"
#endif
#if defined(DYN_ARR)
#include "../synch_implementations/cdsl_dyn_array.h"
#endif


#if defined (SLL)
	cdsl_sll *clientList;
    iterator_cdsl_sll it, end;
#elif defined(DLL)
	cdsl_dll *clientList;
    iterator_cdsl_dll it, end;
#elif defined(DYN_ARR)
	cdsl_dyn_array *clientList;
    iterator_cdsl_dyn_array it, end;
#endif



struct _NODE
{
  int iDist;
  int iPrev;
};
typedef struct _NODE NODE;

struct _QITEM
{
  int iNode;
  int iDist;
  int iPrev;
  struct _QITEM *qNext;

};
typedef struct _QITEM QITEM;

//QITEM *qHead = NULL;
             
int AdjMatrix[NUM_NODES][NUM_NODES];

int g_qCount = 0;
NODE rgnNodes[NUM_NODES];
int ch;
int iPrev, iNode;
int i, iCost, iDist;


void print_path (NODE *rgnNodes, int chNode) {
    if (rgnNodes[chNode].iPrev != NONE) {
      print_path(rgnNodes, rgnNodes[chNode].iPrev);
    }
    printf (" %d", chNode);
    fflush(stdout);
}


int qcount (void)
{
  return(g_qCount);
}

void dijkstra(int chStart, int chEnd)  {
  for (ch = 0; ch < NUM_NODES; ch++) {
      rgnNodes[ch].iDist = NONE;
      rgnNodes[ch].iPrev = NONE;
  }

  if (chStart == chEnd) {
      printf("Shortest path is 0 in cost. Just stay where you are.\n");
  }
  else {
      rgnNodes[chStart].iDist = 0;
      rgnNodes[chStart].iPrev = NONE;
// initialize queue 
      QITEM *qNew = (QITEM *) malloc(sizeof(QITEM));
      qNew->iNode = chStart;
      qNew->iDist = 0;
      qNew->iPrev = NONE;
      qNew->qNext = NULL;
      clientList -> enqueue(0, clientList, (void *)qNew);
      g_qCount++;

     while (qcount() > 0) {
        QITEM *q = clientList -> dequeue(0, clientList);
        iNode = q->iNode;
        iDist = q->iDist;
        iPrev = q->iPrev;
        g_qCount--;
	  for (i = 0; i < NUM_NODES; i++) {
	      if ((iCost = AdjMatrix[iNode][i]) != NONE) {
		    if ((NONE == rgnNodes[i].iDist) || 
		        (rgnNodes[i].iDist > (iCost + iDist))) {
		            rgnNodes[i].iDist = iDist + iCost;
		            rgnNodes[i].iPrev = iNode;

                    /* 
                     * enqueue operation for library's 
                     * enqueue function (interface)  
                     * */ 
                    QITEM *q = (QITEM *) malloc(sizeof(QITEM));
                    q->iNode = i;
                    q->iDist = iDist + iCost;
                    q->iPrev = iNode;
                    q->qNext = NULL;
                    clientList -> enqueue(0, clientList, (void *)q);
                    g_qCount++;
		    }
		}
	  }
    }
      
      printf("Shortest path is %d in cost. ", rgnNodes[chEnd].iDist);
      printf("Path is: ");
      print_path(rgnNodes, chEnd);
      printf("\n");
    }
}

int main(int argc, char *argv[]) {
  int i,j,k;
  FILE *fp;

/* Initialization of data structures  */ 
#if defined (SLL)
    clientList = cdsl_sll_init();
    it = clientList->iter_begin(clientList);
    end = clientList->iter_end(clientList);
#elif defined (DLL)
    clientList = cdsl_dll_init();
    it = clientList->iter_begin(clientList);
    end = clientList->iter_end(clientList);
#elif defined (DYN_ARR)
    clientList = cdsl_dyn_array_init(); 
    it = clientList->iter_begin(clientList);
    end = clientList->iter_end(clientList);
#endif
 
  if (argc<2) {
    fprintf(stderr, "Usage: dijkstra <filename>\n");
    fprintf(stderr, "Only supports matrix size is #define'd.\n");
  }

  /* open the adjacency matrix file */
  fp = fopen (argv[1],"r");

  /* make a fully connected matrix */
  for (i=0;i<NUM_NODES;i++) {
    for (j=0;j<NUM_NODES;j++) {
      /* make it more sparce */
      fscanf(fp,"%d",&k);
	AdjMatrix[i][j]= k;
    }
  }

  /* finds 10 shortest paths between nodes */
  for (i=0,j=NUM_NODES/2;i<20;i++,j++) {
			j=j%NUM_NODES;
      dijkstra(i,j);
  }
  exit(0);
  return 0;
}
