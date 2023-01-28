import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList =  [];

  // reference our box
  final _myBox = Hive.box('mybox');

 // list of todo tasks
 void createInitialData(){
  toDoList = [
    ["Let's Start", false ],
    ["Add your daily task , See your Progress", false ],
  ];
 }
 // load the data from database
 void loadData() {
  toDoList = _myBox.get("TODOLIST");
 }

 // updata the database
 void updateDataBase() {
  _myBox.put("TODOLIST", toDoList);
 }


}