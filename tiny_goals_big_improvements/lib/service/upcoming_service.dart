import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/service/dto/upcoming_dto.dart';
import 'package:tiny_goals_big_improvements/service/goal_service.dart';

class UpcomingService {
  GoalService _goalService;

  UpcomingService() : _goalService = GoalService();

  Future<UpcomingDto> getUpcoming() async {
    UpcomingDto result;

    List<Goal> goals = await _goalService.getAllGoalsByOptionalCategory(null);

    List<UpcomingGroupDto> upcomingGroupDto = [];
    result = UpcomingDto(groups: []);

    for (Goal goal in goals) {
      UpcomingGroupDto? group = result.getGroup(
        repeatType: goal.repeatType,
        repeatCount: goal.repeatCount,
      );

      if (group == null) {
        group = UpcomingGroupDto(
          repeatType: goal.repeatType,
          repeatCount: goal.repeatCount,
          goals: [],
        );
        result.groups.add(group);
      }

      group.goals.add(goal);
    }

    return result;
  }
}
