#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define Length 100

typedef long *array;
array A;
long cpt=0;

void TriParSelection(long t[], long n){

 long min,tmp;
 for(long i=0;i<n-1;i++){
 min=i;
 for(long j=i+1;j<n;j++)
 if(t[j]<t[min])
 min=j;
 if(min!=i)
 {
 //échanger t[i] et t[min]
 tmp=t[i];
 t[i]=t[min];
 t[min]=tmp;
 }
 }
}

void TriParInsertion(long t[], long n)
{
 long a,i,j;
 for(i=0;i<=n-1;i++){
  a=t[i];
  j=i;
  while(j>0 && t[j-1]>a){
    t[j]=t[j-1];
    j=j-1;}
  t[j]=a;
     }
}

void TriABulle(long t[], long n){
    long i,j,tmp;
    long changement;
    for(i=0; i<n-1; i++){
        changement=0;
        for(j=0; j<n-i-1; j++){
           if( t[j] > t[j+1]){
                tmp = t[j];
                t[j] = t[j+1];
                t[j+1] = tmp;
                changement = 1;
           }
        }
        if(changement==0){
           break;
        }
     }
}

void trirapide_p(long arr[],long first,long last){

long i, j, pivot, temp;

if(first<last){

pivot=first;

i=first;

j=last;

while(i<j){

while(arr[i]<=arr[pivot]&&i<last){

i++;                                        cpt++;

}
                                            cpt++;
while(arr[j]>arr[pivot]){

j--;                                        cpt++;

}
                                            cpt++;
if(i<j){

temp=arr[i];

arr[i]=arr[j];

arr[j]=temp;

}

}

temp=arr[pivot];

arr[pivot]=arr[j];

arr[j]=temp;

trirapide_p(arr,first,j-1);

trirapide_p(arr,j+1,last);


}
}

void trirapide_m(long arr[],long first,long last){

long i, j, pivot, temp;

if(first<last){

pivot=(first+last)/2;

i=first;

j=last;

while(i<j){


while(arr[i]<=arr[pivot]&&i<last){

i++;                                        cpt++;

}
                                            cpt++;
while(arr[j]>arr[pivot]){

j--;                                        cpt++;

}
                                            cpt++;

if(i<j){

temp=arr[i];

arr[i]=arr[j];

arr[j]=temp;

}

}

temp=arr[pivot];

arr[pivot]=arr[j];

arr[j]=temp;

trirapide_m(arr,first,j-1);

trirapide_m(arr,j+1,last);

}
}

void trirapide_d(long arr[],long first,long last){

long i, j, pivot, temp;

if(first<last){

pivot=last;

i=first;

j=last;

while(i<j){

while(arr[i]<=arr[pivot]&&i<last){

i++;                                        cpt++;

}
                                            cpt++;
while(arr[j]>arr[pivot]){

j--;                                        cpt++;

}
                                            cpt++;

if(i<j){

temp=arr[i];

arr[i]=arr[j];

arr[j]=temp;

}

}

temp=arr[pivot];

arr[pivot]=arr[j];

arr[j]=temp;

trirapide_d(arr,first,j-1);

trirapide_d(arr,j+1,last);

}
}

/*********** Procedure fusion ************/
void fusion(long arr[], long debut,long centre,long fin){
    long i,j,k;
    long n1 = centre - debut + 1 ;
    long n2 = fin - centre;
    long L[n1], R[n2];

    for(i=0; i<n1; i++)
        L[i] = arr[debut + i];
    for(j=0;j<n2;j++)
        R[j] = arr[centre + 1 + j];
    i=0; j=0; k=debut;
    while(i<n1 && j<n2) {
        if(L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        }
        else {
            arr[k] = R[j];
            j++;
        }
                                                cpt++;
        k++;
    }
    while(i<n1){
        arr[k] = L[i];
        i++;
        k++;
    }
    while(j<n2){
        arr[k] = R[j];
        j++;
        k++;
    }
}

/*
//********** Procedure partition ************

int partition(long arr[], long debut, long fin)
{
  long i, j, pivot, tmp;
  i = debut;
  j = fin;
  pivot = arr[(debut+fin)/2];
  while(1)
  {
   while(arr[i] < pivot && arr[i] != pivot)
   { i++;}
   while(arr[j] > pivot && arr[j] != pivot)
   {j--;}
   if(i < j)
   {
    tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
   }
   else
   {
    return j;
   }
  }
}

//*********** Procedure quick sort ************
void trirapide(long arr[], long debut, long fin)
{
  if(debut < fin)
  {
    long centre = partition(arr, debut, fin);
    trirapide(arr, debut, centre-1);
    trirapide(arr, centre+1, fin);
  }
}

*/

/*********** Procedure tri fusion ************/

// debut est pour l'index la plus a gauche, fin est pour l'index la plus a droite du sous-tableau du arr qui on veut trier
void TriFusion(long arr[], long debut, long fin)
{
    if (debut<fin) {
    long centre = debut + (fin-debut)/2;
    centre = (debut+fin)/2;
    TriFusion(arr,debut,centre);
    TriFusion(arr,centre+1,fin);
    fusion(arr,debut,centre,fin);
    }
}



/*********** Procedure heapify ************/
void heapify(array a, long i, long heapsize)
{
  long l, r, largest, tmp;
  l = 2*i;
  r = 2*i + 1;
  if(l <= heapsize && a[l] > a[i]){
    largest = l;
  }
  else{
    largest = i;
  }
                                                cpt++;
  if( r <= heapsize && a[r] > a[largest]){
    largest = r;
  }
                                                cpt++;
  if(largest != i){
    tmp = a[i];
    a[i] = a[largest];
    a[largest] = tmp;
    heapify(a, largest, heapsize);
  }
}

/*********** Procedure build heap ************/
void buildHeap(array a, long length){
  long i, heapsize;
  heapsize = length - 1;
  for( i=(length/2); i >= 0; i--)
  {
    heapify(a, i, heapsize);
  }
}

/*********** Procedure heap sort ************/
void heapSort(array a, long length)
{
  buildHeap(a, length);
  long heapsize, i, tmp;
  heapsize = length - 1;
  for( i=heapsize; i >= 0; i--)
  {
    tmp = a[0];
    a[0] = a[heapsize];
    a[heapsize] = tmp;
    heapsize--;
    heapify(a, 0, heapsize);
  }
}


int main()
{
 /*int T[10]={600, 3 , -2 , 5 , 1 , 0 , 10 , -240 , 8 , -600};
 TriFusion(T,10);
 for (int i=0 ; i< 10 ; i++){
 printf("%d ",T[i]);}
    return 0; */


    clock_t start, end;
    double time;
    int i;


    //Allocation
    A =(long *)malloc(Length*sizeof(long));

    //init du tableau
    for(i=0;i<Length;i++){
        A[i]=Length-i;
    }

                                                                        // TRI PAR SELECTION

    printf("\n                  ************************TRI SELECTION*************************\n\n");

    //Display the unsorted array
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    start=clock();

    TriParSelection(A,Length); //call of the sorting function

    end=clock();

    time=(double)(end-start)/CLOCKS_PER_SEC; //calculation of runtime

    // Display the sorted array
    printf("\n\n");
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    printf("\n\n                            Runtime TRI PAR SELECTION =  %f\n\n", time); //Display runtime

    // FIN TRI PAR SELECTION

    printf("\n\n\n\n");

                                                                        // TRI PAR INSERTION

    //init du tableau
    for(i=0;i<Length;i++){
        A[i]=Length-i;
    }

    printf("\n                  ************************TRI INSERTION*************************\n\n");

    //Display the unsorted array
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    start=clock();

    TriParInsertion(A,Length); //call of the sorting function

    end=clock();

    time=(double)(end-start)/CLOCKS_PER_SEC; //calculation of runtime

    // Display the sorted array
    printf("\n\n");
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    printf("\n\n                            Runtime TRI PAR INSERTION =  %f\n\n", time); //Display runtime

    // FIN TRI PAR INSERTION

    printf("\n\n\n\n");

                                                                            // TRI A BULLE

    //init du tableau
    for(i=0;i<Length;i++){
        A[i]=Length-i;
    }
    printf("\n                  ************************TRI A BULLE*************************\n\n");

    //Display the unsorted array
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    start=clock();

    TriABulle(A,Length); //call of the sorting function

    end=clock();

    time=(double)(end-start)/CLOCKS_PER_SEC; //calculation of runtime

    // Display the sorted array
    printf("\n\n");
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    printf("\n\n                            Runtime TRI A BULLE =  %f\n\n", time); //Display runtime

    // FIN TRI A BULLE

    printf("\n\n\n\n");

                                                                            // TRI RAPIDE PIVOT GAUCHE

    //init du tableau
    for(i=0;i<Length;i++){
        A[i]=Length-i;
    }
    printf("\n                  ************************TRI RAPIDE GAUCHE*************************\n\n");

    //Display the unsorted array
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    start=clock();

    trirapide_p(A,0,Length-1); //call of the sorting function
    end=clock();
    printf("\n************************************COUNTER = %ld",cpt);
    cpt = 0;

    time=(double)(end-start)/CLOCKS_PER_SEC; //calculation of runtime

    // Display the sorted array
    printf("\n\n");
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    printf("\n\n                            Runtime TRI RAPIDE GAUCHE =  %f\n\n", time); //Display runtime

    // FIN TRI RAPIDE PIVOT GAUCHE

    printf("\n\n\n\n");

                                                                                // TRI RAPIDE PIVOT MILIEU

    //init du tableau
    for(i=0;i<Length;i++){
        A[i]=Length-i;
    }
    printf("\n                  ************************TRI RAPIDE MILIEU*************************\n\n");

    //Display the unsorted array
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    start=clock();

    trirapide_m(A,0,Length-1); //call of the sorting function
    printf("\n************************************COUNTER = %ld",cpt);
    cpt = 0;

    end=clock();

    time=(double)(end-start)/CLOCKS_PER_SEC; //calculation of runtime

    // Display the sorted array
    printf("\n\n");
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    printf("\n\n                             Runtime TRI RAPIDE MILIEU =  %f\n\n", time); //Display runtime

    // FIN TRI RAPIDE PIVOT MILIEU

    printf("\n\n\n\n");

                                                                                // TRI RAPIDE PIVOT DROITE

    //init du tableau
    for(i=0;i<Length;i++){
        A[i]=Length-i;
    }
    printf("\n                  ************************TRI RAPIDE DROTE*************************\n\n");

    //Display the unsorted array
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    start=clock();

    trirapide_d(A,0,Length-1); //call of the sorting function
    printf("\n************************************COUNTER = %ld",cpt);
    cpt = 0;

    end=clock();

    time=(double)(end-start)/CLOCKS_PER_SEC; //calculation of runtime

    // Display the sorted array
    printf("\n\n");
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    printf("\n\n                            Runtime TRI RAPIDE DRIOTE=  %f\n\n", time); //Display runtime

    // FIN TRI RAPIDE PIVOT DROITE

    printf("\n\n\n\n");

                                                                                // TRI FUSION

    //init du tableau
    for(i=0;i<Length;i++){
        A[i]=Length-i;
    }
    printf("\n                  ************************TRI FUSION*************************\n\n");

    //Display the unsorted array
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    start=clock();

    TriFusion(A,0,Length-1); //call of the sorting function
    printf("\n************************************COUNTER = %ld",cpt);
    cpt = 0;

    end=clock();

    time=(double)(end-start)/CLOCKS_PER_SEC; //calculation of runtime

    // Display the sorted array
    printf("\n\n");
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    printf("\n\n                            Runtime TRI FUSION =  %f\n\n", time); //Display runtime

    // FIN TRI FUSION

    printf("\n\n\n\n");

                                                                                // TRI PAR TAS

    //init du tableau
    for(i=0;i<Length;i++){
        A[i]=Length-i;
    }
    printf("\n                  ************************TRI PAR TAS*************************\n\n");

    //Display the unsorted array
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    start=clock();

    heapSort(A,Length); //call of the sorting function
    printf("\n************************************COUNTER = %ld",cpt);
    cpt = 0;

    end=clock();

    time=(double)(end-start)/CLOCKS_PER_SEC; //calculation of runtime

    // Display the sorted array
    printf("\n\n");
    for(i=0;i<Length;i++){
        printf("%ld ",A[i]);
    }

    printf("\n\n                            Runtime TRI PAR TAS =  %f\n\n", time); //Display runtime

    // FIN TRI PAR TAS
    printf("%ld\n",cpt);
    cpt++;
    printf("%ld\n",cpt);
    cpt = 0;
    printf("%ld",cpt);
    printf("\n\n\n\n");

    return 0;
}
