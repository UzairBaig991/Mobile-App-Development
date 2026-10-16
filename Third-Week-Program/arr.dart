List display()
{
  List arr = List.filled(5, null, growable: true);
  arr[0] = "Muhammad";
  arr[1] = "Uzair";
  arr[2] = "Usman";
  arr[3] = "Unaib";
  arr[4] = "Uzain";

  arr.add("Aamir");
  return arr;
}
void main(){
  print(display());
}