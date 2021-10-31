import 'package:logging/logging.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tiny_goals_big_improvements/core/optional.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';

import 'database.dart';

class CategoryRepository {
  static final _log = Logger('CategoryRepository');

  void save(final Category entity) async {
    Database database = await getDatabase();

    if (entity.id == null) {
      _log.fine('Inserting Category: ${entity.toMap()}.');

      DateTime dateTimeBefore = DateTime.now();

      int id = await database.insert(Category.tableName, entity.toMap());
      entity.id = id;

      DateTime dateTimeAfter = DateTime.now();
      _log.fine(
          'Inserted Category successfully. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
      _log.finer('Inserted Category successfully. Got id $id.');
    } else {
      _log.fine('Updating Category: ${entity.toMap()}.');

      DateTime dateTimeBefore = DateTime.now();

      int id = await database.update(Category.tableName, entity.toMap(),
          where: 'id = ?', whereArgs: [entity.id]);

      DateTime dateTimeAfter = DateTime.now();
      _log.fine(
          'Inserted Category successfully. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
      _log.finer('Updated Category successfully.');
    }
  }

  Future<List<Category>> findAll() async {
    List<Category> result = [];

    Database database = await getDatabase();

    _log.fine('Querying all Categories.');

    DateTime dateTimeBefore = DateTime.now();

    List<Map<String, Object?>> queryResult =
        await database.query(Category.tableName);

    DateTime dateTimeAfter = DateTime.now();

    _log.fine(
        'Successfully queried all Categories. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');

    result = queryResult.map((e) => Category.fromMap(e)).toList();

    return result;
  }

  void delete(int id) async {
    Database database = await getDatabase();

    _log.fine('Deleting the Category with the id $id.');

    DateTime dateTimeBefore = DateTime.now();

    int result = await database
        .delete(Category.tableName, where: 'id = ?', whereArgs: [id]);

    DateTime dateTimeAfter = DateTime.now();

    _log.fine(
        'Successfully deleted the Category with the id $id. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
  }
}
