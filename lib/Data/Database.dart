import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

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
          id STRING PRIMARY KEY, name TEXT, date TEXT, time TEXT, pageID INTEGER FOREIGN KEY, location TEXT
        );
        CREATE TABLE pages (
          id STRING PRIMARY KEY, name TEXT, icon TEXT
        );
        ''');
    }, version: 1);
  }

  Future<List<Task_Data>> getTasks() async {
    // Get a reference to the database.
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task_Data(
          id: maps[i]['id'],
          name: maps[i]['name'],
          date: maps[i]['age'],
          time: maps[i]['time'],
          pageID: maps[i]['pageID']);
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

  Future<void> deleteTask(int id) async {
    final Database db = await database;
    await db.delete('pages', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Page>> getPages() async {
    // Get a reference to the database.
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('pages');

    return List.generate(maps.length, (i) {
      return Page(id: maps[i]['id'], name: maps[i]['name']);
    });
  }

  Future<void> insertPage(Page page) async {
    // Get a reference to the database.
    final Database db = await database;

    await db.insert(
      'pages',
      page.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deletePage(int id) async {
    final Database db = await database;
    await db.delete('pages', where: 'id = ?', whereArgs: [id]);
  }
}

class Task_Data {
  final String id;
  final String name;
  final String date;
  final String time;
  final int pageID;

  Task_Data({this.id, this.name, this.date, this.time, this.pageID});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'date': date,
      'page': pageID,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Task{name: $name}';
  }
}

class Page {
  final int id;
  final String name;
  final String icon;
  Page({this.id, this.name, this.icon});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
