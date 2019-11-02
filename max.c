#include <stdio.h>
#define L 40

int main()
{
   
    int i;
   
    int myArray[] = { 34, 201, 190, 154,   8, 194,   2,   6,
                              114, 88,   45,  76, 123,  87,  25,  23,
                              200, 122, 150, 90,   92,  87, 177, 244,
                              201,   6,  12,  60,   8,   2,   5,  67,
                                7,  87, 250, 230,  99,   3, 100,  90};
   
    int max = myArray[0];
   
     for(i=0; i<L; i++)
    {
     if(myArray[i] > max)
     {
      max = myArray[i];
     }
    }

    printf("%d \n",max);
   
    return 0;
   
}
