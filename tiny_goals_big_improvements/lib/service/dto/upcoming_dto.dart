import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/domain/repeat_type.dart';

class UpcomingDto {
  List<UpcomingGroupDto> groups;

  UpcomingDto({required this.groups});

  UpcomingGroupDto? getGroup({
    required RepeatType repeatType,
    required int repeatCount,
  }) =>
      groups.firstWhere((element) =>
          element.repeatType == repeatType &&
          element.repeatCount == repeatCount);
  }

  int _repeatTypeToInt(RepeatType repeatType) {
    switch (repeatType) {
      case RepeatType.day:
        return 1;
      case RepeatType.week:
        return 2;
      case RepeatType.month:
        return 3;
      case RepeatType.year:
        return 4;
    }
  }
}

class UpcomingGroupDto {
  RepeatType repeatType;
  int repeatCount;
  List<Goal> goals;

  UpcomingGroupDto({
    required this.repeatCount,
    required this.repeatType,
    required this.goals,
  });
}
