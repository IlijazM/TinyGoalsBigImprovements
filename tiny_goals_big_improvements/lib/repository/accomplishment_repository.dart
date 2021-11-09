import 'package:logging/logging.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tiny_goals_big_improvements/core/date_util.dart';
import 'package:tiny_goals_big_improvements/domain/accomplishment.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/repository/goal_repository.dart';

import 'database.dart';

class AccomplishmentRepository {
  static final _log = Logger('AccomplishmentRepository');

  GoalRepository goalRepository = GoalRepository();

  Future<void> save(final Accomplishment entity) async {
    Database database = await getDatabase();

    if (entity.id == null) {
      _log.fine('Inserting Accomplishment: ${toMap(entity)}.');

      DateTime dateTimeBefore = DateTime.now();

      int id = await database.insert(Accomplishment.tableName, toMap(entity));
      entity.id = id;

      DateTime dateTimeAfter = DateTime.now();
      _log.fine(
          'Inserted Accomplishment successfully. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
      _log.finer('Inserted Accomplishment successfully. Got id $id.');
    } else {
      _log.fine('Updating Accomplishment: ${toMap(entity)}.');

      DateTime dateTimeBefore = DateTime.now();

      int id = await database.update(Accomplishment.tableName, toMap(entity),
          where: 'id = ?', whereArgs: [entity.id]);

      DateTime dateTimeAfter = DateTime.now();
      _log.fine(
          'Inserted Accomplishment successfully. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
      _log.finer('Updated Accomplishment successfully.');
    }
  }

  Future<List<Accomplishment>> findWhere({
    String? where,
    List<Object?>? whereArgs,
  }) async {
    List<Accomplishment> result = [];

    Database database = await getDatabase();

    _log.fine('Querying all Accomplishments.');

    DateTime dateTimeBefore = DateTime.now();

    List<Map<String, Object?>> queryResult = await database.query(
      Accomplishment.tableName,
      where: where,
      whereArgs: whereArgs,
    );

    DateTime dateTimeAfter = DateTime.now();

    _log.fine(
        'Successfully queried all Accomplishment. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');

    for (Map<String, Object?> e in queryResult) {
      result.add(await fromMap(e));
    }

    return result;
  }

  Future<List<Accomplishment>> findAll() async => await findWhere();
  Future<Accomplishment> findById(int id) async =>
      (await findWhere(where: 'id = ?', whereArgs: [id])).first;
  Future<List<Accomplishment>> findAllByGoal(Goal goal) async =>
      await findWhere(where: 'goal_id = ?', whereArgs: [goal.id]);

  Future<List<Accomplishment>> findAllThisDay(int goalId) async =>
      await findWhere(
        where: 'goal_id = ? AND date >= ?',
        whereArgs: [goalId, '${getStartOfDay().millisecondsSinceEpoch}'],
      );

  Future<List<Accomplishment>> findAllThisWeek(int goalId) async =>
      await findWhere(
        where: 'goal_id = ? AND date >= ?',
        whereArgs: [goalId, '${getStartOfWeek().millisecondsSinceEpoch}'],
      );

  Future<List<Accomplishment>> findAllThisMonth(int goalId) async =>
      await findWhere(
        where: 'goal_id = ? AND date >= ?',
        whereArgs: [goalId, '${getStartOfMonth().millisecondsSinceEpoch}'],
      );

  Future<List<Accomplishment>> findAllThisYear(int goalId) async =>
      await findWhere(
        where: 'goal_id = ? AND date >= ?',
        whereArgs: [goalId, '${getStartOfYear().millisecondsSinceEpoch}'],
      );

  Future<void> delete(int id) async {
    Database database = await getDatabase();

    _log.fine('Deleting the Accomplishment with the id $id.');

    DateTime dateTimeBefore = DateTime.now();

    int result = await database
        .delete(Accomplishment.tableName, where: 'id = ?', whereArgs: [id]);

    DateTime dateTimeAfter = DateTime.now();

    _log.fine(
        'Successfully deleted the Accomplishment with the id $id. It took ${dateTimeAfter.difference(dateTimeBefore).inMicroseconds}µs');
  }

  Map<String, dynamic> toMap(Accomplishment accomplishment) => {
        'id': accomplishment.id,
        'date': accomplishment.date.millisecondsSinceEpoch,
        'amount': accomplishment.amount,
        'goal_id': accomplishment.goal.id,
      };

  Future<Accomplishment> fromMap(Map<String, dynamic> map) async {
    Database database = await getDatabase();

    _log.fine('Parses $map to Accomplishment.');

    assert(map.containsKey('date'),
        'Failed parsing map to domain model "Accomplishment": The inputted map doesn\'t contain the field "date"');
    assert(map.containsKey('date'),
        'Failed parsing map to domain model "Accomplishment": The inputted map doesn\'t contain the field "date"');
    assert(map.containsKey('amount'),
        'Failed parsing map to domain model "Accomplishment": The inputted map doesn\'t contain the field "amount"');
    assert(map.containsKey('goal_id'),
        'Failed parsing map to domain model "Accomplishment": The inputted map doesn\'t contain the field "goal"');

    Goal goal = await goalRepository.findById(map['goal_id']);

    return Accomplishment(
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      amount: map['amount'],
      goal: goal,
    );
  }
}
