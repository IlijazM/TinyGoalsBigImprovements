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
  String dbPath = 'database.db';
  if (Platform.isWindows) {
    dbPath = 'D:/database.db';
  }
  if (Platform.environment.containsKey('FLUTTER_TEST')) {
    dbPath = '/tmp/database.db';
    try {
      File(dbPath).deleteSync();
    } catch (_) {}
  }
  // Open the database and store the reference.
  _databaseSingleton = await databaseFactory.openDatabase(dbPath);
  _log.info('Database was loaded successfully.');

  await _initDb();
}

_initDb() async {
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

  sql = '''
  CREATE TABLE IF NOT EXISTS `accomplishments` (
    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
    `date` INTEGER NOT NULL,
    `amount` INTEGER NOT NULL,
    `goal_id` INTEGER NOT NULL
  );
  ''';
  _log.finest('executing:\n' + sql);
  _databaseSingleton!.execute(sql);
}
