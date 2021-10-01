// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static const _dbName = 'myDatabase.db';
  static const _dbVersion = 1;
  static const _tableName = 'myTable';

  static const colId = '_id';
  static const colName = 'name';

  // making singleton class || to call the instance of class, then call its contructor
  DBHelper._privateContrucutor();
  static final DBHelper instance = DBHelper._privateContrucutor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database =
        await _initiate_Database(); // it takes time to execute thats why await keyword is used
    return _database;
  }

  Future _initiate_Database() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    db.execute('''
      CREATE TABLE $_tableName(
      $colId INTEGER PRIMARY KEY,
      $colName TEXT NOT NULL)
      ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database? db = await instance.database;
    return await db!.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[colId];
    return await db!
        .update(_tableName, row, where: '$colId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(_tableName, where: '$colId = ?', whereArgs: [id]);
  }
}
