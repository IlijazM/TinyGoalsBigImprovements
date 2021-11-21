import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tiny_goals_big_improvements/core/date_util.dart';
import 'package:tiny_goals_big_improvements/core/logger_util.dart';
import 'package:tiny_goals_big_improvements/domain/accomplishment.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/domain/repeat_type.dart';
import 'package:tiny_goals_big_improvements/service/accomplishment_service.dart';
import 'package:tiny_goals_big_improvements/service/category_service.dart';
import 'package:tiny_goals_big_improvements/service/goal_service.dart';

@GenerateMocks([DateTime])
void main() {
  initLogger();

  CategoryService categoryService = CategoryService();
  GoalService goalService = GoalService();
  AccomplishmentService accomplishmentService = AccomplishmentService();

  test('Goals per day', () async {
    Category category = Category(
      color: 0,
      icon: '0',
      name: 'test',
    );

    await categoryService.createNewCategory(category);

    Goal goal = Goal(
      activity: 'day',
      category: category,
      amount: 0,
      repeatCount: 10,
      repeatType: RepeatType.day,
    );

    await goalService.createNewGoal(goal);

    dateTimeNowMock = () => DateTime(2020, 0, 1, 1, 0, 0, 0, 0);

    Accomplishment accomplishment1 = Accomplishment(
      amount: 0,
      date: DateTime(2020, 1, 0, 0, 0, 0, 0, 0),
      goal: goal,
    );

    goal = (await goalService.getAllGoalsByOptionalCategory(category)).first;
    print(goal.accomplishments);

    await accomplishmentService.createAccomplishmentNow(accomplishment1);

    goal = (await goalService.getAllGoalsByOptionalCategory(category)).first;
    print(goal.accomplishments);
  });
}
