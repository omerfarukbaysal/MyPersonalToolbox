import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'ToDoClass.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({Key key}) : super(key: key);
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ToDo> noteList;
  int count = 0;
  TextEditingController _textFieldController = TextEditingController();

  void navigateToDetail(ToDo note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return null;
    }));
    if (result == true) {
      updateListView();
    } else if (result == null) {
      Text("No Notes to Show");
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initalizeDatabase();
    dbFuture.then((database) {
      Future<List<ToDo>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

  insert(String title) async {
    ToDo todo = ToDo(title, false);
    await databaseHelper.insertNote(todo);
  }

  update(int id, String title, bool isChecked) async {
    ToDo todo = ToDo.withId(id, title, isChecked);
    await databaseHelper.updateNote(todo);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<ToDo>();
      updateListView();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("To Do List"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              _displayTextInputDialog(context);
            });
          },
        ),
        body: getNoteListView());
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.deepPurple,
          elevation: 4.0,
          child: ListTile(
            leading: Checkbox(
              value: this.noteList[position].isChecked,
              onChanged: (bool value) {
                setState(() {
                  this.noteList[position].isChecked = value;
                });
                update(
                    this.noteList[position].id,
                    this.noteList[position].title,
                    this.noteList[position].isChecked);
              },
            ),
            title: Text(
              this.noteList[position].title,
              style: TextStyle(
                  color: this.noteList[position].isChecked
                      ? Colors.red
                      : Colors.white,
                  decoration: this.noteList[position].isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
          ),
        );
      },
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    String valueText;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New Task'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Add a new task"),
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('Close'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('Add'),
                onPressed: () {
                  setState(() {
                    if (valueText.length > 0) {
                      insert(valueText);
                      updateListView();
                      _textFieldController.text = "";
                      valueText = "";
                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ],
          );
        });
  }
}
