import 'package:sqflite/sqflite.dart';

import '../model/restaurant.dart';

class SqliteService {
  static const String _databaseName = 'my_restaurant.db';
  static const String _tableName = 'restaurants';
  static const int _version = 1;

  Future<Database> _initializeDb() async {
    return openDatabase(_databaseName, version: _version,
        onCreate: (database, version) async {
      await createTables(database);
    });
  }

  Future<void> createTables(Database database) async {
    await database.execute('''
    CREATE TABLE $_tableName(
      id TEXT PRIMARY KEY NOT NULL,
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      pictureId TEXT NOT NULL,
      city TEXT NOT NULL,
      rating REAL NOT NULL
    );
    ''');
  }

  Future<int> insert(Restaurant restaurant) async {
    final db = await _initializeDb();
    final data = restaurant.toJson();
    final id = await db.insert(_tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  Future<List<Restaurant>> getRestaurants() async {
    final db = await _initializeDb();
    final List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((result) => Restaurant.fromJson(result)).toList();
  }

  Future<int> delete(String id) async {
    final db = await _initializeDb();
    final result =
        await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}
