import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Databasehelper {
  static final _databasename = "addtocart.db";
  static final _databaseversion = 1;
  static final table = "my_table";

  static final columnID = 'id';
  // static final columnItemNo = 'itemno';
  static final columnDesc = 'desc';
  static final columnQuantity = 'quantity';
  static final columnUom = 'uom';

  static Database? _database;
  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''

    CREATE TABLE $table(
      $columnID INTEGER PRIMARY KEY,
      $columnDesc TEXT NOT NULL,
      $columnQuantity INTEGER NOT NULL,
      $columnUom TEXT NOT NULL,
      
    )

      ''');
  }

  // INSERT FUNCTION
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  //SHOW ALL DATA
  Future<List<Map<String, dynamic>>> showData() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  //SHOW SPECIFIC DATA
  Future<List<Map<String, dynamic>>> queryspecific(int age) async {
    Database? db = await instance.database;
    //var res = await db!.query(table, where: "age >?", whereArgs: [age]);
    var res = await db!.rawQuery('SELECT * FROM my_table WHERE age > ?', [age]);
    return res;
  }

  // DELETE SPECIFIC ROW
  Future<int> deletedata(int id) async {
    Database? db = await instance.database;
    var res = await db!.delete(table, where: "id=?", whereArgs: [id]);
    return res;
  }

  // UPDATE RECORD
  Future<int> update(int id) async {
    Database? db = await instance.database;
    var res = await db!.update(table, {"name": "Prashant Ainkar", "age": "22"},
        where: "id=?", whereArgs: [id]);
    return res;
  }
}
