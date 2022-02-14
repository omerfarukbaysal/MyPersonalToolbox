import 'ToDoClass.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String todoTable = 'todo_table';
  String colID = 'id';
  String colTitle = 'title';
  String colIsChecked = 'isChecked';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initalizeDatabase();
    }
    return _database;
  }

  Future<Database> initalizeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $todoTable($colID INTEGER PRIMARY KEY AUTOINCREMENT,  $colTitle TEXT, $colIsChecked INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    var result = await db.query(todoTable);
    return result;
  }

  Future<int> insertNote(ToDo note) async {
    Database db = await this.database;
    var result = await db.insert(todoTable, note.toMap());
    return result;
  }

  Future<int> updateNote(ToDo note) async {
    Database db = await this.database;
    var result = await db.update(todoTable, note.toMap(),
        where: '$colID = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result =
        await db.rawDelete('DELETE FROM $todoTable where $colID = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<ToDo>> getNoteList() async {
    var noteMapList = await getNoteMapList();

    int count = noteMapList.length;

    List<ToDo> noteList = List<ToDo>();
    for (int i = 0; i < count; i++) {
      noteList.add(ToDo.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }
}
