import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';

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
                _buildText(),
                const Spacer(),
                ..._buildActionButtons(),
              ],
            ),
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
