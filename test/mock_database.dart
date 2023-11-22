// mock_database.dart
import 'package:flutter/foundation.dart';

class MockDatabase {
  final Map<String, List<Map<String, dynamic>>> _tables = {};

  Future<void> open() async {
    // Mock implementation for opening a database connection
    if (kDebugMode) {
      print('MockDatabase: Opening database connection');
    }
  }

  Future<void> insertProduct(String table, Map<String, dynamic> data) async {
    // Mock implementation for inserting data into the database
    if (kDebugMode) {
      print('MockDatabase: Inserting data into $table - $data');
    }

    _tables.putIfAbsent(table, () => []);
    _tables[table]!.add(data);
  }

  Future<void> updateProduct(String table, Map<String, dynamic> data) async {
    // Mock implementation for updating data in the database
    if (kDebugMode) {
      print('MockDatabase: Updating data in $table - $data');
    }

    if (_tables.containsKey(table)) {
      final index =
          _tables[table]!.indexWhere((item) => item['id'] == data['id']);
      if (index != -1) {
        _tables[table]![index] = data;
      }
    }
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    // Mock implementation for querying data from the database
    if (kDebugMode) {
      print('MockDatabase: Querying data from $table');
    }
    return _tables.containsKey(table) ? List.from(_tables[table]!) : [];
  }

  Future<void> deleteProduct(String table, String id) async {
    // Mock implementation for deleting data from the database
    if (kDebugMode) {
      print('MockDatabase: Deleting data from $table with ID $id');
    }

    if (_tables.containsKey(table)) {
      _tables[table]!.removeWhere((item) => item['id'] == id);
    }
  }

  Future<void> close() async {
    // Mock implementation for closing the database connection
    if (kDebugMode) {
      print('MockDatabase: Closing database connection');
    }
  }
}
