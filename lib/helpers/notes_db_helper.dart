import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class NotesDBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE user_notes(id TEXT PRIMARY KEY,title TEXT,notes TEXT,createdDate TEXT)');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await NotesDBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> update(String table, String id, String title,
      String notes, String createdDate) async {
    final db = await NotesDBHelper.database();
    await db.update(
      table,
      {
        'id': id,
        'title': title,
        'notes': notes,
        'createdDate': createdDate,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> delete(String table, String id) async {
    final db = await NotesDBHelper.database();
    await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await NotesDBHelper.database();
    return db.query(table);
  }
}
