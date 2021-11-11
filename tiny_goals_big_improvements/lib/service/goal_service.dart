import 'package:logging/logging.dart';
import 'package:tiny_goals_big_improvements/domain/accomplishment.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/domain/repeat_type.dart';
import 'package:tiny_goals_big_improvements/repository/accomplishment_repository.dart';
import 'package:tiny_goals_big_improvements/repository/goal_repository.dart';

class GoalService {
  static final _log = Logger('GoalService');

  final GoalRepository _goalRepository;

  final AccomplishmentRepository _accomplishmentRepository;

  GoalService()
      : _goalRepository = GoalRepository(),
        _accomplishmentRepository = AccomplishmentRepository();

  Future<void> createNewGoal(Goal goal) async {
    _log.info("Request to create or update a Goal.");

    await _goalRepository.save(goal);
  }

  Future<List<Goal>> getAllGoalsByCategory(Category? category) async {
    _log.info("Request all Goals by category $category.");

    List<Goal> result;

    if (category == null) {
      result = await _goalRepository.findAll();
    } else {
      result = await _goalRepository.findAllByCategory(category);
    }

    for (Goal goal in result) {
      await _parseGoal(goal);
    }

    _log.info("Successfully got all Goals. Got ${result.length} in total.");

    return result;
  }

  Future<void> deleteGoal(int id) async {
    _log.info("Request to delete Goal with the id $id.");

    _goalRepository.delete(id);
  }

  Future<void> _parseGoal(Goal goal) async {
    List<Accomplishment> accomplishments = [];

    if (goal.id != null) {
      switch (goal.repeatType) {
        case RepeatType.day:
          accomplishments =
              await _accomplishmentRepository.findAllThisDay(goal.id!);
          break;
        case RepeatType.week:
          accomplishments =
              await _accomplishmentRepository.findAllThisWeek(goal.id!);
          break;
        case RepeatType.month:
          accomplishments =
              await _accomplishmentRepository.findAllThisMonth(goal.id!);
          break;
        case RepeatType.year:
          accomplishments =
              await _accomplishmentRepository.findAllThisYear(goal.id!);
          break;
      }
    }

    goal.accomplishments = accomplishments.length;

    goal.status = '${goal.accomplishments} / ${goal.repeatCount}';
  }
}
