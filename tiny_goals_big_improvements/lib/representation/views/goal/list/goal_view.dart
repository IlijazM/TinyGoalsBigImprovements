import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/representation/views/goal/goal_controller.dart';
import 'package:tiny_goals_big_improvements/representation/views/goal/list/goal_item_view.dart';

class GoalView extends StatefulWidget {
  final GoalController goalController;

  GoalView({Key? key})
      : goalController = GoalController(),
        super(key: key);

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  @override
  void initState() {
    super.initState();
    widget.goalController.subscribeToCategories(() => setState(() {}));
    widget.goalController.subscribeToGoals(() => setState(() {}));
    widget.goalController.queryAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (widget.goalController.selectedCategory == null) {
      if (widget.goalController.categories == null) {
        child = const CircularProgressIndicator();
      } else {
        child = _buildCategoryChooser();
      }
    } else {
      child = _buildGoalList(context);
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: child,
    );
  }

  Widget _buildCategoryChooser() => Column(
        children: [
          const Text(
            // TODO: translate
            'Chose a category',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: widget.goalController.categories!
                .map((e) => _buildCategoryButton(e))
                .toList(),
          ),
        ],
      );

  Widget _buildCategoryButton(Category category) => ElevatedButton(
        onPressed: () => _selectCategory(category),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Icon(
                IconData(
                  int.parse(category.icon),
                  fontFamily: 'MaterialIcons',
                ),
              ),
              Text(category.name),
            ],
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(category.color)),
        ),
      );

  Widget _buildGoalList(BuildContext context) => Column(
        children: [
          ElevatedButton(
            // TODO: translate
            child: const Text('Select category'),
            onPressed: _deselectCategory,
          ),
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

  _selectCategory(Category category) {
    setState(() => widget.goalController.selectedCategory = category);
    widget.goalController.query();
  }

  _deselectCategory() {
    setState(() => widget.goalController.selectedCategory = null);
  }

  Widget _buildListView() {
    if (widget.goalController.goals == null) {
      return const CircularProgressIndicator();
    }
    return ListView(
      shrinkWrap: true,
      children: widget.goalController.goals!
          .map((goal) => GoalItemView(
                goal: goal,
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
