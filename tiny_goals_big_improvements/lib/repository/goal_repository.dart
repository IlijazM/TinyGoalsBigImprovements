import 'package:logging/logging.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tiny_goals_big_improvements/domain/accomplishment.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/domain/repeat_type.dart';
import 'package:tiny_goals_big_improvements/repository/accomplishment_repository.dart';
import 'package:tiny_goals_big_improvements/repository/category_repository.dart';

import 'database.dart';

class GoalRepository {
  static final GoalRepository instance = GoalRepository();

  static final _log = Logger('GoalRepository');

  Future<void> save(final Goal entity) async {
    Database database = await getDatabase();

    if (entity.id == null) {
      _log.fine('Inserting Goal: ${toMap(entity)}.');

      DateTime dateTimeBefore = DateTime.now();

      int id = await database.insert(Goal.tableName, toMap(entity));
      entity.id = id;

      DateTime dateTimeAfter = DateTime.now();
      _log.fine(
          'Inserted Goal successfully. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
      _log.finer('Inserted Goal successfully. Got id $id.');
    } else {
      _log.fine('Updating Goal: ${toMap(entity)}.');

      DateTime dateTimeBefore = DateTime.now();

      int id = await database.update(Goal.tableName, toMap(entity),
          where: 'id = ?', whereArgs: [entity.id]);

      DateTime dateTimeAfter = DateTime.now();
      _log.fine(
          'Inserted Goal successfully. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
      _log.finer('Updated Goal successfully.');
    }
  }

  Future<List<Goal>> findWhere({
    String? where,
    List<Object?>? whereArgs,
  }) async {
    List<Goal> result = [];

    Database database = await getDatabase();

    _log.fine('Querying all Goals.');

    DateTime dateTimeBefore = DateTime.now();

    List<Map<String, Object?>> queryResult = await database.query(
      Goal.tableName,
      where: where,
      whereArgs: whereArgs,
    );

    DateTime dateTimeAfter = DateTime.now();

    _log.fine(
        'Successfully queried all Goals ${queryResult.length}. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');

    for (Map<String, Object?> e in queryResult) {
      result.add(await fromMap(e));
    }

    return result;
  }

  Future<List<Goal>> findAll() async => await findWhere();
  Future<Goal> findById(int id) async =>
      (await findWhere(where: "id = ?", whereArgs: [id])).first;

  Future<List<Goal>> findAllByCategory(Category category) async =>
      await findWhere(where: "category_id = ?", whereArgs: [category.id]);

  Future<void> delete(int id) async {
    Database database = await getDatabase();

    _log.fine('Deleting the Goal with the id $id.');

    await AccomplishmentRepository.instance.deleteByGoalId(id);

    DateTime dateTimeBefore = DateTime.now();

    await database.delete(Goal.tableName, where: 'id = ?', whereArgs: [id]);

    DateTime dateTimeAfter = DateTime.now();

    _log.fine(
        'Successfully deleted the Goal with the id $id. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
  }

  Future<void> deleteByCategoryId(int id) async {
    List<Goal> goals =
        await findWhere(where: 'category_id = ?', whereArgs: [id]);

    for (Goal goal in goals) {
      await delete(goal.id!);
    }
  }

  Map<String, dynamic> toMap(Goal goal) => {
        'id': goal.id,
        'activity': goal.activity,
        'description': goal.description,
        'amount': goal.amount,
        'repeat_count': goal.repeatCount,
        'repeat_type': goal.repeatType.toString(),
        'category_id': goal.category.id,
      };

  Future<Goal> fromMap(Map<String, dynamic> map) async {
    Database database = await getDatabase();

    _log.fine('Parses $map to Goal.');

    assert(map.containsKey('activity'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "activity"');
    assert(map.containsKey('amount'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "amount"');
    assert(map.containsKey('repeat_count'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "repeat_count"');
    assert(map.containsKey('repeat_type'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "repeat_type"');
    assert(map.containsKey('category_id'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "category"');

    Category category =
        await CategoryRepository.instance.findById(map['category_id']);

    return Goal(
      id: map['id'],
      activity: map['activity'],
      description: map['description'],
      amount: map['amount'],
      repeatCount: map['repeat_count'],
      repeatType: RepeatType.values
          .firstWhere((element) => element.toString() == map['repeat_type']),
      category: category,
    );
  }
}
