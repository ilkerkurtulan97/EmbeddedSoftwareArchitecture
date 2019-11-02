#include<stdio.h>
#define L 40

int main()
{
   
    int myArray[] = { 34, 201, 190, 154,   8, 194,   2,   6,
                              114, 88,   45,  76, 123,  87,  25,  23,
                              200, 122, 150, 90,   92,  87, 177, 244,
                              201,   6,  12,  60,   8,   2,   5,  67,
                                7,  87, 250, 230,  99,   3, 100,  90};
    int i,position,d;
   
    int temp,swap,median;
   
   

    for (i = 0; i < (L - 1); i++)
  {
    position = i;
   
    for (d = i + 1; d < L; d++)
    {
      if (myArray[position] > myArray[d])
     
        position = d;
    }
    if (position != i)
    {
      swap = myArray[i];
      myArray[i] = myArray[position];
      myArray[position] = swap;
    }
  }

   
    printf("The sorted list is \n ");
     printf("sorted list : \n");
   
    for(i=0; i<L; i++)
    {
     printf("%d \n",myArray[i]);
    }


   
   
   
   
    
   
   
}



