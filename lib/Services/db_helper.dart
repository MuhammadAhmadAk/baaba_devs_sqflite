import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //variables
  static const dbName = "myDatabase.db";
  static const dbVersion = 1;
  static const dbTable = "myTable";
  static const columnId = "Id";
  static const columnName = "Name";
  //constructor
  static final DatabaseHelper instance = DatabaseHelper();

  //Database initialize
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
    // if (_database != null) return _database;
    // _database = await initDB();
    // return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    db.execute('''
       create table $dbTable(
        $columnId integer primary key,
        $columnName text not null
       )

      ''');
  }

//insert data
  insertRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;

    return await db!.insert(dbTable, row);
  }

//read
  Future<List<Map<String, dynamic>>> queryDatabase() async {
    Database? db = await instance.database;

    return await db!.query(dbTable);
  }

//Update
  Future<int> updateRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(dbTable, row, where: '$columnId=?', whereArgs: [id]);
  }

  //Delete
  Future<int> deleteRecord(int id) async {
    Database? db = await instance.database;
    return await db!.delete(dbTable, where: '$columnId=?', whereArgs: [id]);
  }
}
