/*Parallel Hierarchical One-Dimensional Search for motion estimation*/
/*Initial algorithm - Used for simulation and profiling             */

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <unistd.h>

#define N 144     /*Frame dimension for QCIF format*/
#define M 176     /*Frame dimension for QCIF format*/
#define p 7       /*Search space. Restricted in a [-p,p] region around the original location of the block.*/

/* Global Variables */
int B;
int NdiaB, MdiaB; 
int bigInt;

void read_sequence(int current[N][M], int previous[N][M])
{
	FILE *picture0, *picture1;
	int i, j;

	if((picture0=fopen("akiyo0.y","rb")) == NULL)
	{
		printf("Previous frame doesn't exist.\n");
		exit(-1);
	}

	if((picture1=fopen("akiyo1.y","rb")) == NULL)
	{
		printf("Current frame doesn't exist.\n");
		exit(-1);
	}

  /*Input for the previous frame*/
  for(i=0; i<N; i++)
  {
    for(j=0; j<M; j++)
    {
      previous[i][j] = fgetc(picture0);
    }
  }

	/*Input for the current frame*/
	for(i=0; i<N; i++)
  {
		for(j=0; j<M; j++)
    {
			current[i][j] = fgetc(picture1);
    }
  }

	fclose(picture0);
	fclose(picture1);
}


void phods_motion_estimation(int current[N][M], int previous[N][M],
    int vectors_x[NdiaB][MdiaB],int vectors_y[NdiaB][MdiaB])
{
  int x, y, i, j, k, l, p1, p2, q2, distx, disty, S, min1, min2, bestx, besty, m;
  int  vecBxK, vecByL, vecBxKi, vecByLi;

  distx = 0;
  disty = 0;

  /*Initialize the vector motion matrices*/

  /*For all blocks in the current frame*/
  for(x=0; x<NdiaB; x++)
  {
    for(y=0; y<MdiaB; y++)
    {
      // calculate once and store
      S = 4; 
      min1 = bigInt;
      min2 = min1;
      vectors_x[x][y] = 0;
      vectors_y[x][y] = 0; 
      int vector_x = vectors_x[x][y]; 
      int vector_y = vectors_y[x][y];
      int Bx = B*x;
      int By = B*y;
      int vector_Bx = vector_x + Bx;
      int vector_By = vector_y + By;

      for(m=0; m<3; m++) // better performance than while loop
      {
        /*For all candidate blocks in X and Y dimension*/
        for(i=-S; i<S+1; i+=S)
        {
          distx = 0;
          disty = 0;
          
          /* Merge X and Y loops */
          /*For all pixels in the block*/
          for(k=0; k<B; k++)
          {
            vecBxK = vector_Bx + k; // calculate and store for next iterations
            for(l=0; l<B; l++)
            {
              vecByL = vector_By + l; // calculate and store for next iterations
              vecByLi = vecByL + i;   //
              vecBxKi = vecBxK + i;   //
              p1 = current[Bx+k][By+l];
              if((vecBxKi) < 0 ||
                  (vecBxKi) > (N-1) ||
                  (vecByL) < 0 ||
                  (vecByL) > (M-1))
              {
                p2 = 0;
              } else {
                p2 = previous[vecBxKi][vecByL];
              }
              distx += abs(p1-p2);

              if((vecBxK) <0 ||
                  (vecBxK) > (N-1) ||
                  (vecByLi) < 0 ||
                  (vecByLi) > (M-1))
              {
                q2 = 0;
              } else {
                q2 = previous[vecBxK][vecByLi];
              }
              disty += abs(p1-q2);
            }
          }

          if(distx < min1)
          {
            min1 = distx;
            bestx = i;
          }
          if(disty < min2)
          {
            min2 = disty;
            besty = i;
          }
        }
        S = S/2;
        vector_Bx += bestx;
        vector_By += besty;
      }
      vectors_x[x][y] = vector_Bx - Bx;
      vectors_y[x][y] = vector_By - By;
    }
  }
}

int main(int argc, char **argv)
{
  B = atoi(argv[1]); // B as input
  NdiaB = N/B;  // extract time consuming calculations
  MdiaB = M/B; 
  bigInt = 255*B*B;
  int current[N][M], previous[N][M], motion_vectors_x[NdiaB][MdiaB],
      motion_vectors_y[NdiaB][MdiaB], i, j;
  double time; // variables for timing
  struct timeval ts, tf;

	read_sequence(current,previous);

  gettimeofday(&ts, NULL);
  phods_motion_estimation(current,previous,motion_vectors_x,motion_vectors_y);
  gettimeofday(&tf, NULL);

  time = (tf.tv_sec - ts.tv_sec) + (tf.tv_usec - ts.tv_usec)*0.000001;

  printf("Time %lf\n", time);

  return 0;
}
