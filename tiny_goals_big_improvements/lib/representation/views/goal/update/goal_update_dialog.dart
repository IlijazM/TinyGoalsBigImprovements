import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiny_goals_big_improvements/core/internationalization_util.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';
import 'package:tiny_goals_big_improvements/domain/repeat_type.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_button.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_dialog.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_drop_down.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_text_area.dart';
import 'package:tiny_goals_big_improvements/representation/components/custom_text_field.dart';
import 'package:tiny_goals_big_improvements/representation/views/goal/goal_controller.dart';

class GoalUpdateDialog extends StatefulWidget {
  final GoalController goalController;

  /// If a goal is passed that means that you try to update an goal.
  final Goal? goal;

  GoalUpdateDialog({
    Key? key,
    required this.goalController,
    this.goal,
  }) : super(key: key);

  @override
  _GoalUpdateDialogState createState() =>
      _GoalUpdateDialogState(goal, goalController.selectedCategory);
}

class _GoalUpdateDialogState extends State<GoalUpdateDialog> {
  Goal goal;
  bool _update;
  bool _nameNotSet;

  bool _showAmount = false;

  final _formKey = GlobalKey<FormState>();

  _GoalUpdateDialogState(Goal? _goal, Category selectedCategory)
      : _update = _goal != null,
        _nameNotSet = _goal == null,
        goal = _goal ??
            Goal(
              // We need the build context for internationalization so we set the name later.
              activity: '',
              amount: 1,
              repeatCount: 1,
              repeatType: RepeatType.day,
              category: selectedCategory,
            );

  @override
  Widget build(BuildContext context) {
    // Set the default name.
    // We need the build context for internationalization.
    if (_nameNotSet) {
      goal.activity = l10n(context)
          .entity_new
          .replaceFirst('{}', l10n(context).entity_goal);
      _nameNotSet = false;
    }

    return CustomDialog(
      title: _update
          ? l10n(context)
              .entity_update
              .replaceFirst('{}', l10n(context).entity_goal)
          : l10n(context)
              .entity_create
              .replaceFirst('{}', l10n(context).entity_goal),
      children: [
        _buildForm(),
      ],
    );
  }

  Widget _buildForm() => SizedBox(
        // must get included else rendering exception get thrown.
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            // must get included else rendering exception get thrown.
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildActivityTextField(),
              _buildDescriptionTextField(),
              _buildRepeatOption(),
              // _buildAmountOption(),
              _buildFormControllButtons(),
            ],
          ),
        ),
      );

  Widget _buildActivityTextField() => CustomTextField(
        labelText: l10n(context).entity_goal_activity,
        validator: _activityValidator,
        initialValue: goal.activity,
        onChange: (value) => goal.activity = value,
      );

  Widget _buildDescriptionTextField() => CustomTextArea(
        labelText: l10n(context).entity_goal_description,
        validator: _descriptionValidator,
        initialValue: goal.description,
        onChange: (value) => goal.description = value,
      );

  Widget _buildRepeatOption() => IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CustomTextField(
                labelText: l10n(context).entity_goal_repeatCount,
                keyboardType: TextInputType.number,
                initialValue: goal.repeatCount.toString(),
                onChange: (value) => goal.repeatCount = int.parse(value),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 6.0, 0, 0),
              height: 61,
              child: CustomDropDown(
                value: goal.repeatType.toString(),
                items: RepeatType.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.toString(),
                        child: Text(_repeatTypeToString(e, context)),
                      ),
                    )
                    .toList(),
                onChanged: (value) => goal.repeatType = RepeatType.values
                    .firstWhere((element) => element.toString() == value),
              ),
            ),
          ],
        ),
      );

  Widget _buildAmountOption() => Column(
        children: [
          const Divider(),
          CheckboxListTile(
            value: _showAmount,
            onChanged: (value) => setState(() => _showAmount = value ?? false),
            title: const Text('Goal is to reach an amount of something.'),
          ),
          ...(_showAmount
              ? [
                  CustomTextField(
                    labelText: l10n(context).entity_goal_amount,
                    initialValue: goal.amount.toString(),
                    onChange: (value) => goal.amount = int.parse(value),
                    keyboardType: TextInputType.number,
                  ),
                ]
              : []),
          const Divider(),
        ],
      );

  Widget _buildFormControllButtons() => Row(
        children: [
          const Spacer(),
          CustomElevatedButton(
            label: l10n(context).action_save,
            onPressed: _submitFunction,
          ),
          CustomTextButton(
            label: l10n(context).action_cancel,
            onPressed: _cancelFunction,
          ),
        ],
      );

  void _submitFunction() {
    if (_formKey.currentState!.validate()) {
      widget.goalController.save(goal);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n(context)
                .entity_saved_successfully
                .replaceFirst('{}', l10n(context).entity_goal),
          ),
        ),
      );
      Navigator.pop(context, true);
    }
  }

  void _cancelFunction() {
    Navigator.pop(context, true);
  }

  String? _activityValidator(String? value) {
    if (value == null || value.isEmpty) {
      return l10n(context).validation_blank;
    }
    return null;
  }

  String? _descriptionValidator(String? value) {
    return null;
  }

  String _repeatTypeToString(RepeatType repeatType, BuildContext context) {
    switch (repeatType) {
      case RepeatType.day:
        {
          return l10n(context).entity_goal_times_a_day;
        }
      case RepeatType.week:
        {
          return l10n(context).entity_goal_times_a_week;
        }
      case RepeatType.month:
        {
          return l10n(context).entity_goal_times_a_month;
        }
      case RepeatType.year:
        {
          return l10n(context).entity_goal_times_a_year;
        }
    }
  }
}
