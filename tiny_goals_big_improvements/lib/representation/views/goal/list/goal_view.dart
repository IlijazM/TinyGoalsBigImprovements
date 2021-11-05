import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/representation/views/goal/goal_controller.dart';
import 'package:tiny_goals_big_improvements/representation/views/goal/list/goal_item_view.dart';

class GoalView extends StatefulWidget {
  final GoalController goalController;

  final Category selectedCategory;

  GoalView({Key? key, required this.selectedCategory})
      : goalController = GoalController(selectedCategory: selectedCategory),
        super(key: key);

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  @override
  void initState() {
    super.initState();
    widget.goalController.subscribeToGoals(() => setState(() {}));
    widget.goalController.query();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.selectedCategory.name),
          backgroundColor: Color(widget.selectedCategory.color),
          foregroundColor:
              Color(widget.selectedCategory.color).computeLuminance() > 0.5
                  ? Colors.white
                  : Colors.black,
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          // child: GoalView(),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: _buildGoalList(context),
          ),
        ),
      );

  Widget _buildGoalList(BuildContext context) => Column(
        children: [
          Row(
            children: [
              const Text(
                // TODO: translate
                'Goals',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => widget.goalController.requestCreate(context),
                icon: const Icon(Icons.add_circle),
              ),
            ],
          ),
          _buildListView(),
        ],
      );

  Widget _buildListView() {
    if (widget.goalController.goals == null) {
      return const CircularProgressIndicator();
    }
    return ListView(
      shrinkWrap: true,
      children: widget.goalController.goals!
          .map((goal) => GoalItemView(
                goal: goal,
                selectCallback: () {},
                editCallback: () {
                  widget.goalController.requestEdit(context, goal);
                },
                deleteCallback: () {
                  widget.goalController.requestDelete(context, goal);
                },
              ))
          .toList(),
    );
  }
}
