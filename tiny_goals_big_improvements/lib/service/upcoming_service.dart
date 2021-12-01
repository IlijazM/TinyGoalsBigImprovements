import 'package:logging/logging.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/service/goal_service.dart';

class UpcomingService {
  static final _log = Logger('UpcomingService');

  GoalService _goalService;

  UpcomingService() : _goalService = GoalService();

  Future<List<Goal>> getUpcoming(Category? category) async {
    List<Goal> result =
        await _goalService.getAllGoalsByOptionalCategory(category);

    // sort the goals by priority and remove all finished goals.
    result
      ..sort((a, b) => (b.calculatedPrio ?? 0) - (a.calculatedPrio ?? 0))
      ..removeWhere((goal) => (goal.accomplishments ?? 0) >= goal.repeatCount);

    _log.info("Successfully got all Goals. Got ${result.length} in total.");

    return result;
  }
}
