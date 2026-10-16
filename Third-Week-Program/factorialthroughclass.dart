import 'dart:io';

class calculator{
  late int _result;     //Data-Member Private
  late int _num;

  calculator(){
    this._result=1;
    this._num=0;
  }

  set setNum(int num){       //Setter
    this._num = num;
  }
  void factorial() {
    for (int i = 1; i <= _num; i++) {
      _result = _result * i;
    }
    }
  int get getResult{        //Getter
    return _result;
  }
}
void main(){
  int num;
  stdout.write("Enter Number: ");
  num = int.parse(stdin.readLineSync()!);

  calculator cal = new calculator();

  cal.setNum = num;
  cal.factorial();
  print("Factorial of $num : ${cal.getResult}");
}