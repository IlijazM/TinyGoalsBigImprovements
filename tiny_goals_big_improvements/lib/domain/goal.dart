import 'package:logging/logging.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/domain/repeat_type.dart';

/// A goal someone sets.
class Goal {
  static const tableName = 'goals';

  static final _log = Logger('Goal');

  int? id;
  late String activity;
  String? description;
  late int amount;
  late int repeatCount;
  late RepeatType repeatType;

  late Category category;

  // DTO fields.
  int? accomplishments;
  String? status;

  Goal({
    this.id,
    required this.activity,
    this.description,
    required this.amount,
    required this.repeatCount,
    required this.repeatType,
    required this.category,
  });

  @override
  String toString() {
    return 'Goal{' +
        '"id": ${id.toString()}, ' +
        '"activity": ${activity.toString()}, ' +
        '"description": ${description.toString()}, ' +
        '"amount": ${amount.toString()}, ' +
        '"repeatCount": ${repeatCount.toString()}, ' +
        '"repeatType": ${repeatType.toString()}, ' +
        '"category": ${category.toString()}, ' +
        '}';
  }
}
