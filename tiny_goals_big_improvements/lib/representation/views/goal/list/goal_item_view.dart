import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
            child: Flex(
              mainAxisSize: MainAxisSize.max,
              direction: Axis.vertical,
              children: [
                Row(
                  children: [
                    _buildIcon(),
                    _buildText(),
                    // const Spacer(),
                    ..._buildActionButtons(),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0, 0),
                  child: _buildStatus(),
                ),
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
            IconData(
              int.parse(goal.category.icon),
              fontFamily: 'MaterialIcons',
            ),
          ),
        ),
      );

  Widget _buildText() => Expanded(
        child: Container(
          padding: const EdgeInsets.only(right: 0.0),
          child: Text(
            goal.activity,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );

  Widget _buildStatus() => SizedBox(
        width: double.infinity,
        child: LinearPercentIndicator(
          lineHeight: 14.0,
          percent: (goal.accomplishments ?? 0) / goal.repeatCount,
          backgroundColor: Colors.blueGrey,
          progressColor: Color(goal.category.color),
          leading: Text('${goal.accomplishments} / ${goal.repeatCount}'),
        ),
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
