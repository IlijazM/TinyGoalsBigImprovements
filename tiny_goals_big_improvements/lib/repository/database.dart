import 'package:sqflite/sqflite.dart';

import '../core/optional.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

Optional<Database> _databaseSingleton = Optional.absent();

Future<Database> getDatabase() async {
  if (_databaseSingleton.isEmpty) {
    await _lazyInitDatabase();
  }
  return _databaseSingleton.value;
}

Future<void> _lazyInitDatabase() async {
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'database.db'),
    // When the database is first created, create a table to store entities.
    onCreate: _onCreate,
  );
}

void _onCreate(Database database, int version) {}
