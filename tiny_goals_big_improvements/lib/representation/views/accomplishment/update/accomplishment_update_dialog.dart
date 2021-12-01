import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/core/date_util.dart';
import 'package:tiny_goals_big_improvements/core/internationalization_util.dart';
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
      title: Text(l10n(context).entity_accomplishment),
      content: Text(
        l10n(context)
            .entity_accomplishment_reached_goal_question
            .replaceFirst('{}', accomplishment.goal.activity),
      ),
      actions: [
        ElevatedButton(
          child: Text(l10n(context).core_yes),
          onPressed: () {
            widget.accomplishmentController.create(accomplishment);
            widget.onSave();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(l10n(context).core_no),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
