import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/word.dart';

class DbHelper {
  Database _db;

  Future<Database> get db async {
    /// db yap

    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "etrade.db");

    /// path
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    /// table
    await db.execute(
        "Create table words(id integer primary key, word text, description text)");
  }

  Future<List<Word>> getWords() async {
    Database db = await this.db;
    var result = await db.query("words");
    return List.generate(result.length, (i) {
      return Word.fromObject(result[i]);
    });
  }

  Future<int> insert(Word word) async {

    Database db = await this.db;

    var result = await db.insert("words", word.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;

    var result = await db.rawDelete("delete from words where id=$id");
    return result;
  }

  Future<int> update(Word word) async {
    Database db = await this.db;
    var result = await db
        .update("words", word.toMap(), where: "id=?", whereArgs: [word]);
    return result;
  }


}
