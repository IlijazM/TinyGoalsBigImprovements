import 'package:logging/logging.dart';
import 'package:tiny_goals_big_improvements/domain/accomplishment.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/domain/repeat_type.dart';
import 'package:tiny_goals_big_improvements/repository/accomplishment_repository.dart';
import 'package:tiny_goals_big_improvements/repository/category_repository.dart';
import 'package:tiny_goals_big_improvements/repository/goal_repository.dart';

class GoalService {
  static final _log = Logger('GoalService');

  final GoalRepository _goalRepository;

  final AccomplishmentRepository _accomplishmentRepository;

  GoalService()
      : _goalRepository = GoalRepository(),
        _accomplishmentRepository = AccomplishmentRepository();

  void createNewGoal(Goal goal) {
    _log.info("Request to create or update a Goal.");

    _goalRepository.save(goal);
  }

  Future<List<Goal>> getAllGoalsByCategory(Category category) async {
    _log.info("Request all Goals by category $category.");

    List<Goal> result = await _goalRepository.findAllByCategory(category);

    for (Goal goal in result) {
      await _parseGoal(goal);
    }

    _log.info("Successfully got all Goals. Got ${result.length} in total.");

    return result;
  }

  void deleteGoal(int id) {
    _log.info("Request to delete Goal with the id $id.");

    _goalRepository.delete(id);
  }

  _parseGoal(Goal goal) async {
    List<Accomplishment> accomplishments = [];

    switch (goal.repeatType) {
      case RepeatType.day:
        accomplishments = await _accomplishmentRepository.findAllThisDay();
        break;
      case RepeatType.week:
        // TODO: Handle this case.
        break;
      case RepeatType.month:
        // TODO: Handle this case.
        break;
      case RepeatType.year:
        // TODO: Handle this case.
        break;
    }

    goal.accomplishments = accomplishments.length;

    goal.status = '${goal.accomplishments} / ${goal.repeatCount}';
  }
}
