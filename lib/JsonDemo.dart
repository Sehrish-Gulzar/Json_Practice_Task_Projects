import 'dart:convert';

// void main() {
//   String persoData =
//       '{ "name":"Sehrish", "age":24,"hobbies":["reading","games","writing"]}';
//   print(persoData.runtimeType);
//   Map myJsonData = jsonDecode(persoData);
//   print(myJsonData.runtimeType);
//   print(myJsonData["name"]);
//   print(myJsonData["age"]);
//   print(myJsonData["hobbies"]);
// }
//

void main() {
  String persoData =
      '[{ "name":"Sehrish", "age":22,"hobbies":["reading","games","writing"]}, {"name":"Lareb", "age":21,"hobbies":["reading","games","writing"]}]';
  print(persoData.runtimeType);
  List myJsonData = jsonDecode(persoData);
  print(myJsonData.runtimeType);
  print(myJsonData[1]["name"]);
  print(myJsonData[1]["age"]);
  print(myJsonData[1]["hobbies"][0]);
}
