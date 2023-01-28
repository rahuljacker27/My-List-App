import 'package:flutter/material.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage ({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is 1st time ever opening the app
    if(_myBox.get("TODOLIST") == null){
      db.createInitialData();
    }else{
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // checkboc change
  void checkBoxChanged(bool? value, int index){
  setState(() {
    db.toDoList[index][1] = !db.toDoList[index][1];
  });
  db.updateDataBase();
  }
// save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([ _controller.text, false]);
      _controller.clear();
      Navigator.of(context).pop();
    });
    db.updateDataBase();
  }
  // create new task
  void createNewTask(){
    showDialog(
        context: context,
        builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      );
    });
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        // Center(child: new Text(widget.title, textAlign: TextAlign.center)),
        title: Center(child: Text('My List' , textAlign: TextAlign.center)),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 24),
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
                taskName: db.toDoList[index][0],
                taskCompleted: db.toDoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFun: (context) => deleteTask(index),
            );
          },
      ),
    );
  }
}
