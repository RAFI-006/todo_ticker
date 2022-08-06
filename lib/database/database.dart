
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper
{

  static DataBaseHelper? _instance;
  Database? db;

  factory DataBaseHelper.instance()
  {
    return DataBaseHelper._internal();
  }

  DataBaseHelper._internal()
  {
    db =  initDb();
  }


  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "todo_ticker.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }


  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE task(id INTEGER PRIMARY KEY, title TEXT, description TEXT, duration  INTEGER, status TEXT )");
    print("Created tables");
  }
}