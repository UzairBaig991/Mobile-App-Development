import 'dart:io';
String DecimalTOBinary(int decimal){
  return decimal.toRadixString(2);
}
void main(){

  print(DecimalTOBinary(10));
}