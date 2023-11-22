// ignore_for_file: avoid_print

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/index.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'product_manager.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

// Use parameterized query to prevent SQL injection in all the queries
  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY,
        name TEXT,
        quantity INTEGER,
        costPrice REAL,
        sellingPrice REAL,
        imageData BLOB
      )
    ''');
  }

  // Insert a product into the database
  Future<int> insertProduct(Product product) async {
    final db = await database;
    try {
      int result = await db.insert('products', product.toMap());
      return result;
    } catch (e) {
      print('Error inserting product: $e');
      return -1; // You can return an error code or throw an exception
    }
  }

  // Get all products from the database
  Future<List<Product>> getProducts() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('products');
      return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
    } catch (e) {
      print('Error querying products: $e');
      return []; // You can return an empty list or throw an exception
    }
  }

  // Delete a product by ID
  Future<int> deleteProduct(int id) async {
    final db = await database;
    try {
      var result =
          await db.delete('products', where: 'id = ?', whereArgs: [id]);

      return result;
    } catch (e) {
      print('Error deleting : $e');
      return -1; //;
    }
  }

  // Update a product
  Future<int> updateProduct(Product product) async {
    final db = await database;
    try {
      print(product);
      int result = await db.update('products', product.toMap(),
          where: 'id = ?', whereArgs: [product.id]);
      return result;
    } catch (e) {
      print('Error updating : $e');
      return -1; // You can return an error code or throw an exception
    }
  }

  // Get a product by ID
  Future<Product?> getProductById(int id) async {
    final db = await database;
    try {
      List<Map<String, dynamic>> maps =
          await db.query('products', where: 'id = ?', whereArgs: [id]);

      if (maps.isNotEmpty) {
        return Product.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      print('Error querying product by ID: $e');
      return null;
    }
  }
}
