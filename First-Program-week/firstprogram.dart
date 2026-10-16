import 'dart:io';

void main(){
  int SAPid;
  String? name;
  double cgpa;

  print("Enter SAPID : ");
  SAPid = int.parse(stdin.readLineSync()!);

  print("Enter your Name : ");
  name = stdin.readLineSync();

  print("Enter CGPA : ");
  cgpa = double.parse(stdin.readLineSync()!);

  print("SAPID : $SAPid , NAME : $name , CGPA : $cgpa");
}