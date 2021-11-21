import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/core/internationalization_util.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/representation/views/goal/goal_controller.dart';
import 'package:tiny_goals_big_improvements/representation/views/goal/list/goal_item_view.dart';
import 'package:tiny_goals_big_improvements/representation/views/layout/drawer.dart';

class UpcomingView extends StatefulWidget {
  GoalController goalController;

  UpcomingView({Key? key})
      : goalController = GoalController(),
        super(key: key);

  @override
  _UpcomingViewState createState() => _UpcomingViewState();
}

class _UpcomingViewState extends State<UpcomingView> {
  List<Goal>? goals;

  @override
  void initState() {
    widget.goalController.queryUpcoming();
    widget.goalController.subscribeToGoals(
      () => setState(
        () => {
          goals = widget.goalController.goals,
        },
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(l10n(context).entity_goal_upcoming_title),
        ),
        drawer: getGlobalDrawer(context),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              ..._buildList(context),
            ],
          ),
        ),
      );

  List<Widget> _buildList(BuildContext context) => goals == null
      ? []
      : goals!
          .map(
            (goal) => GoalItemView(
              goal: goal,
              selectCallback: () =>
                  widget.goalController.requestSelect(context, goal),
              editCallback: () =>
                  widget.goalController.requestEdit(context, goal),
              deleteCallback: () =>
                  widget.goalController.requestDelete(context, goal),
            ),
          )
          .toList();
}
