import 'dart:io';
void main() {
  String? name;
  stdout.write("Enter name:");
  name=stdin.readLineSync();
  print(name?.length);
}