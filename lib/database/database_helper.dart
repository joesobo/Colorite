import 'dart:io';

import 'package:colorite/models/palette.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = 'dbPalette08.db';
  static final _databaseVersion = 1;

  static final table = 'my_table';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnJsonPalette = 'myColorList';

  //singleton class
  DatabaseHelper._prvateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._prvateConstructor();

  //returns instance of database, if empty calls initDatabase
  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _initDatabase();
    return _database;
  }

  //opens database and creates it if it doesnt exist
  _initDatabase() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    String path = join(docDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  //creates database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $table(
      $columnId INTEGER PRIMARY KEY, 
      $columnName TEXT NOT NULL,
      $columnJsonPalette TEXT NOT NULL)
    ''');
  }

  //inserts row into database and returns row id
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  //returns table as list of maps
  Future<List<Map<String, dynamic>>> getAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  //returns table as list of palettes
  Future<List<Palette>> getPalettes() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> list = await db.rawQuery('SELECT * FROM $table');
    List<Palette> palettes = [];
    for(int i = 0; i < list.length; i++){
      palettes.add(Palette.fromJson(list[i]));
    }
    return palettes;
  }

  //returns number of rows in table
  Future<int> getRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  //updates row in table
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  //deletes row in table
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
