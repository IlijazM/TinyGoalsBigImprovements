import 'dart:io';

import 'package:logging/logging.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Database? _databaseSingleton;

Logger _log = Logger("DatabaseFactory");

Future<Database> getDatabase() async {
  if (_databaseSingleton == null) {
    await _lazyInitDatabase();
  }
  return _databaseSingleton!;
}

Future<void> _lazyInitDatabase() async {
  if (Platform.isWindows || Platform.isLinux) {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  }
  // Open the database and store the reference.
  _databaseSingleton = await databaseFactory.openDatabase('/tmp/database.db');
  _log.info('Database was loaded successfully.');

  _initDb();
}

void _initDb() {
  String sql;

  sql = '''
  CREATE TABLE IF NOT EXISTS `categories` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `name` TEXT NOT NULL,
    `description` TEXT,
    `color` INTEGER NOT NULL,
    `icon` VARCHAR(255) NOT NULL
  );
  ''';
  _log.finest('executing:\n' + sql);
  _databaseSingleton!.execute(sql);

  sql = '''
  CREATE TABLE IF NOT EXISTS `goals` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `activity` TEXT NOT NULL,
    `description` TEXT,
    `amount` INTEGER NOT NULL,
    `repeat_count` INTEGER NOT NULL,
    `repeat_type` VARCHAR(255) NOT NULL,
    `category_id` INTEGER NOT NULL
  );
  ''';
  _log.finest('executing:\n' + sql);
  _databaseSingleton!.execute(sql);
}
