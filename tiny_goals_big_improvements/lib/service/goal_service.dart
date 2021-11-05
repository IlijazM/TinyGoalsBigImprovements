import 'package:logging/logging.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/repository/category_repository.dart';
import 'package:tiny_goals_big_improvements/repository/goal_repository.dart';

class GoalService {
  static final _log = Logger('GoalService');

  final GoalRepository _goalRepository;

  GoalService() : _goalRepository = GoalRepository();

  void createNewGoal(Goal goal) {
    _log.info("Request to create or update a Goal.");

    _goalRepository.save(goal);
  }

  Future<List<Goal>> getAllGoalsByCategory(Category category) async {
    _log.info("Request all Goals by category $category.");

    List<Goal> result = await _goalRepository.findAllByCategory(category);

    _log.info("Successfully got all Goals. Got ${result.length} in total.");

    return result;
  }

  void deleteGoal(int id) {
    _log.info("Request to delete Goal with the id $id.");

    _goalRepository.delete(id);
  }
}
