import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:task_app/Pages/TaskPage.dart';
import 'package:task_app/Tasks/task.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'task_db.db'),
        onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE tasks (
          id STRING PRIMARY KEY, name TEXT, date TEXT, time TEXT, pageID STRING
        );''');
      await db.execute('''
        CREATE TABLE pages (
          id STRING PRIMARY KEY, name TEXT, iconval INTEGER
        );''');
    }, version: 1);
  }

  Future<List<Task>> getTasks() async {
    // Get a reference to the database.
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task(Task_Data(
          id: maps[i]['id'],
          name: maps[i]['name'],
          date: maps[i]['date'],
          time: maps[i]['time'],
          pageID: maps[i]['pageID']));
    });
  }

  Future<void> insertTask(Task_Data task) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTask(String id) async {
    final Database db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TaskPage>> getPages() async {
    // Get a reference to the database.
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('pages');

    return List.generate(maps.length, (i) {
      return TaskPage(
          Page_Data(
              id: maps[i]['id'],
              name: maps[i]['name'],
              iconval: maps[i]['iconval']),
          []);
    });
  }

  Future<void> insertPage(Page_Data page) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'pages',
      page.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deletePage(String id) async {
    final Database db = await database;
    await db.delete('pages', where: 'id = ?', whereArgs: [id]);
  }
}

class Task_Data {
  final String id;
  String name;
  String date;
  String time;
  String pageID;

  Task_Data({this.id, this.name, this.date, this.time, this.pageID});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'date': date,
      'pageID': pageID,
    };
  }

  @override
  String toString() {
    return 'Task{name: $name}';
  }
}

class Page_Data {
  final String id;
  String name;
  int iconval;
  Page_Data({this.id, this.name, this.iconval});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconval': iconval,
    };
  }
}
