import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/representation/views/accomplishment/update/accomplishment_update_dialog.dart';
import 'package:tiny_goals_big_improvements/representation/views/goal/update/goal_update_dialog.dart';
import 'package:tiny_goals_big_improvements/service/goal_service.dart';

class GoalController {
  List<Goal>? goals;
  final Category selectedCategory;

  final GoalService _goalService;

  /// The list of all subscribers.
  final List<Function> _goalsSubscribers = [];

  GoalController({required this.selectedCategory})
      : _goalService = GoalService();

  query() async {
    goals = null;
    goals = await _goalService.getAllGoalsByCategory(selectedCategory);
    _notifyGoalsSubscribers();
  }

  save(final Goal goal) {
    _goalService.createNewGoal(goal);

    // Reload
    query();
  }

  delete(Goal goal) {
    // The id is ensure here because we only get list items for attached models.
    _goalService.deleteGoal(goal.id!);

    // Reload
    query();
  }

  /// Request editing a category. If the category is null that means that they will create a new
  /// one.
  requestEdit(BuildContext context, Goal? goal) {
    showDialog(
      context: context,
      builder: (context) => GoalUpdateDialog(
        goalController: this,
        goal: goal,
      ),
    );
  }

  requestCreate(final BuildContext context) {
    requestEdit(context, null);
  }

  requestDelete(BuildContext context, Goal goal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // TODO: translate
        return AlertDialog(
          title: Text("Delete goal"),
          content: Text(
            "Are you sure you want to delete the Goal '${goal.activity}'?",
          ),
          actions: [
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                delete(goal);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  subscribeToGoals(Function callback) => _goalsSubscribers.add(callback);

  _notifyGoalsSubscribers() =>
      _goalsSubscribers.forEach((element) => element());

  requestSelect(BuildContext context, Goal goal) => showDialog(
        context: context,
        builder: (context) => AccomplishmentUpdateDialog(
          goal: goal,
          onSave: () => query(),
        ),
      );
}