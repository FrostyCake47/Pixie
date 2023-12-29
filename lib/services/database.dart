import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'diary.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE entries(id TEXT PRIMARY KEY, content TEXT)',
        );
      },
    );
  }

  Future<void> saveEntry(String id, String entry) async {
  final db = await database;
  await db.insert('entries', {'id': id, 'content': entry});
}

  Future<List<Map<String, dynamic>>> loadEntries() async {
    final db = await database;
    return db.query('entries');
  }
}