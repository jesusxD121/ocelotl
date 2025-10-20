import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'ocelotl.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT UNIQUE,
            password TEXT
          )
        ''');
      },
    );
  }

  static Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await initDB();
    return await db.insert('users', user);
  }

  static Future<bool> emailExists(String email) async {
    final db = await initDB();
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty;
  }

  static Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await initDB();
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) return result.first;
    return null;
  }
}
