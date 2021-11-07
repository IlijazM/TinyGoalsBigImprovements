import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/representation/views/goal/goal_controller.dart';

class GoalItemView extends StatelessWidget {
  final Goal goal;
  final Function selectCallback;
  final Function editCallback;
  final Function deleteCallback;

  GoalItemView({
    Key? key,
    required this.goal,
    required this.selectCallback,
    required this.editCallback,
    required this.deleteCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: () => selectCallback(),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildIcon(),
                _buildText(),
                _buildStatus(),
                const Spacer(),
                ..._buildActionButtons(),
              ],
            ),
          ),
        ),
      );
  Widget _buildIcon() => Container(
        margin: const EdgeInsets.fromLTRB(0, 4.0, 16.0, 4.0),
        child: CircleAvatar(
          backgroundColor: Color(goal.category.color),
          foregroundColor: Color(goal.category.color).computeLuminance() > 0.5
              ? Colors.black
              : Colors.white,
          child: Icon(
            IconData(int.parse(goal.category.icon),
                fontFamily: 'MaterialIcons'),
          ),
        ),
      );

  Widget _buildText() => Column(
        children: [
          Text(
            goal.activity,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          // Text(category.description ?? ''),
        ],
      );

  Widget _buildStatus() => Text(goal.status ?? '');

  List<Widget> _buildActionButtons() => [
        IconButton(
          onPressed: () => editCallback(),
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          onPressed: () => deleteCallback(),
          icon: const Icon(Icons.delete),
        ),
      ];
}
