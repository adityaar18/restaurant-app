import 'package:fundamental2/data/model/favorite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ??= DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  static const String _tableName = 'favorite';

  Future<Database> _initDatabase() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'favorite.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
            id TEXT PRIMARY KEY,
            pictureId TEXT,
            name TEXT,
            city TEXT
            )''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<int> addFavorite(Favorite favorite) async {
    final Database db = await database;
    return await db.insert(_tableName, favorite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Favorite>> getFavorites() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((fav) => Favorite.fromMap(fav)).toList();
  }

  Future<bool> getFavoriteById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> removeFavorite(String id) async {
    final Database db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
