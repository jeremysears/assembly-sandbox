#include<stdio.h>

long int maximum(long int x, long int y){
  return x > y ? x : y;
}

int main (){

  long int max = maximum(2,3);

  printf("max: %lu\n", max);

  return 0;
}
