import 'package:logging/logging.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';

import 'database.dart';

class CategoryRepository {
  static final _log = Logger('CategoryRepository');

  Future<void> save(final Category entity) async {
    Database database = await getDatabase();

    if (entity.id == null) {
      _log.fine('Inserting Category: ${toMap(entity)}.');

      DateTime dateTimeBefore = DateTime.now();

      int id = await database.insert(Category.tableName, toMap(entity));
      entity.id = id;

      DateTime dateTimeAfter = DateTime.now();
      _log.fine(
          'Inserted Category successfully. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
      _log.finer('Inserted Category successfully. Got id $id.');
    } else {
      _log.fine('Updating Category: ${toMap(entity)}.');

      DateTime dateTimeBefore = DateTime.now();

      int id = await database.update(Category.tableName, toMap(entity),
          where: 'id = ?', whereArgs: [entity.id]);

      DateTime dateTimeAfter = DateTime.now();
      _log.fine(
          'Inserted Category successfully. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
      _log.finer('Updated Category successfully.');
    }
  }

  Future<List<Category>> findWhere({
    String? where,
    List<Object>? whereArgs,
  }) async {
    List<Category> result = [];

    Database database = await getDatabase();

    _log.fine('Querying all Categories.');

    DateTime dateTimeBefore = DateTime.now();

    List<Map<String, Object?>> queryResult = await database
        .query(Category.tableName, where: where, whereArgs: whereArgs);

    DateTime dateTimeAfter = DateTime.now();

    _log.fine(
        'Successfully queried all Categories. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');

    for (Map<String, Object?> map in queryResult) {
      result.add(await fromMap(map));
    }

    return result;
  }

  Future<List<Category>> findAll() async => await findWhere();
  Future<Category> findById(int id) async =>
      (await findWhere(where: 'id = ?', whereArgs: [id])).first;

  Future<void> delete(int id) async {
    Database database = await getDatabase();

    _log.fine('Deleting the Category with the id $id.');

    DateTime dateTimeBefore = DateTime.now();

    int result = await database
        .delete(Category.tableName, where: 'id = ?', whereArgs: [id]);

    DateTime dateTimeAfter = DateTime.now();

    _log.fine(
        'Successfully deleted the Category with the id $id. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
  }

  Map<String, dynamic> toMap(Category category) => {
        'id': category.id,
        'name': category.name,
        'description': category.description,
        'color': category.color,
        'icon': category.icon,
      };

  Future<Category> fromMap(Map<String, dynamic> map) async {
    _log.fine('Parses $map to Category.');

    assert(map.containsKey('id'),
        'Failed parsing map to domain model "Category": The inputted map doesn\'t contain the field "id"');
    assert(map.containsKey('name'),
        'Failed parsing map to domain model "Category": The inputted map doesn\'t contain the field "name"');
    assert(map.containsKey('description'),
        'Failed parsing map to domain model "Category": The inputted map doesn\'t contain the field "description"');
    assert(map.containsKey('color'),
        'Failed parsing map to domain model "Category": The inputted map doesn\'t contain the field "color"');
    assert(map.containsKey('icon'),
        'Failed parsing map to domain model "Category": The inputted map doesn\'t contain the field "icon"');

    return Category(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      color: map['color'],
      icon: map['icon'],
    );
  }
}
