import 'dart:io';
import 'dart:math';

abstract class Shape {
  double area();
  double circumference();
}

class Circle extends Shape {
  double _radius;
  Circle(this._radius) : super();

  double get radius {
    return _radius;
  }
  set radius(double value) {
    _radius = value;
  }
  double area() {
    return pi * radius * radius;
  }
  double circumference() {
    return 2 * pi * radius;
  }
}
void main() {
  stdout.write("Enter radius: ");
  double r = double.parse(stdin.readLineSync()!);

  Circle circle = Circle(r);

  print("Area: ${circle.area()}");
  print("Circumference: ${circle.circumference()}");
}