#include <stdio.h>

extern int add(int x, int y); //a keyword "extern" indica que essa função está implementada em outro módulo/arquivo.

int main(){
  printf("Hello World.\n");
  
  int result = 0;
  result = add(3, 4); //result == 7
  printf("The value of result is: %d.\n", result);
  
  return 0;
}
