import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'orders.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_name TEXT,
            items TEXT,
            total REAL
          )
        ''');

        await db.execute('''
          CREATE TABLE products(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            price REAL NOT NULL
          )
        ''');
      },
    );
  }

  static Future<void> seedDatabase() async {
    final db = await database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM products'),
    );

    if (count == 0) {
      final products = [
        {'name': 'X-Burger', 'price': 5.00},
        {'name': 'X-Egg', 'price': 4.50},
        {'name': 'X-Bacon', 'price': 7.00},
        {'name': 'Batata frita', 'price': 2.00},
        {'name': 'Refrigerante', 'price': 2.50},
      ];

      for (var product in products) {
        await db.insert('products', product);
      }
    }
  }
}