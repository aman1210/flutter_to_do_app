import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class TodoDBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'todo.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_todo(id TEXT PRIMARY KEY, job TEXT, isCompleted INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await TodoDBHelper.database();
    await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> update(
      String table, String job, String id, int isCompleted) async {
    final db = await TodoDBHelper.database();
    await db.update(
      table,
      {'id': id, 'job': job, 'isCompleted': isCompleted},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> delete(String table, String id) async {
    final db = await TodoDBHelper.database();
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await TodoDBHelper.database();
    return db.query(table);
  }
}
