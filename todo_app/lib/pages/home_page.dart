import 'package:flutter/material.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/utilities/reminder_box.dart';
import 'package:todo_app/utilities/send_notification.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../utilities/dialog_box.dart';
import '../utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {

    // if this is the first opening the app, then create default data
    if(_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]); // _controller is the new task. .text converts it to the string.
      _controller.clear();
    });
    Navigator.of(context).pop();
     db.updateDatabase();
  }

  // creating a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            _controller.clear(); // TextField içindeki metni sil
            Navigator.of(context).pop(); // dialog kutusunu kapat
          }
        );
      },
    );
  }

  // deleting the task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
      db.updateDatabase();
  }


  // reminding the task
  void remindTask(int index) {
    showDialog(
      context: context, 
      builder: (context){
        return ReminderBox(
          taskName: db.toDoList[index][0], // taskName değerini geçir
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        title: Text("TO DO"),
        titleTextStyle: TextStyle(fontSize: 32),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[300],
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
            reminderFunction: (context) => remindTask(index),
          );
        },
      ),
    );
  }
}