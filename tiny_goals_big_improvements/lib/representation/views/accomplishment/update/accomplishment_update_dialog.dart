import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/core/date_util.dart';
import 'package:tiny_goals_big_improvements/domain/accomplishment.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/representation/views/accomplishment/accomplshment_controller.dart';

class AccomplishmentUpdateDialog extends StatefulWidget {
  final Goal goal;
  final AccomplishmentController accomplishmentController;
  final Function onSave;

  AccomplishmentUpdateDialog({
    Key? key,
    required this.goal,
    required this.onSave,
  })  : accomplishmentController = AccomplishmentController(goal),
        super(key: key);

  @override
  _AccomplishmentUpdateDialogState createState() =>
      _AccomplishmentUpdateDialogState(goal);
}

class _AccomplishmentUpdateDialogState
    extends State<AccomplishmentUpdateDialog> {
  Accomplishment accomplishment;

  _AccomplishmentUpdateDialogState(Goal goal)
      : accomplishment = Accomplishment(
          goal: goal,
          amount: 0,
          date: timeNow(),
        );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Accomplishment'),
      content: Text(
        'Did you reach your goal?\n\n${accomplishment.goal.activity}',
      ),
      actions: [
        ElevatedButton(
          child: const Text('Yes'),
          onPressed: () {
            widget.accomplishmentController.create(accomplishment);
            widget.onSave();
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
  }
}
