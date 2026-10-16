import 'dart:io';

int factorial(int num){
  int result = 1;
  for (int i = num ; i > 0 ; i--){
    result = result * i;
  }
  return result;
}
void main(){
  print(factorial(5));
}