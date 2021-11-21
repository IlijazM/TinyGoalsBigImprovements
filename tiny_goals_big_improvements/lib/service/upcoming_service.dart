import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/service/goal_service.dart';

class UpcomingService {
  GoalService _goalService;

  UpcomingService() : _goalService = GoalService();

  Future<List<Goal>> getUpcoming(Category? category) async {
    List<Goal> result = await _goalService.getAllGoalsByPriority(category);

    return result;
  }
}
