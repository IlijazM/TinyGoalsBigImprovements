import 'package:logging/logging.dart';
import 'package:tiny_goals_big_improvements/domain/goal.dart';

/// The accomplishments an user did on goals.
class Accomplishment {
  static const tableName = 'accomplishments';

  static final _log = Logger('Accomplishment');

  int? id;
  late DateTime date;
  late int amount;

  late Goal goal;

  Accomplishment({
    this.id,
    required this.date,
    required this.amount,
    required this.goal,
  });

  @override
  String toString() {
    return 'Goal{' +
        '"id": ${id.toString()}, ' +
        '"date": ${date.toString()}, ' +
        '"amount": ${amount.toString()}, ' +
        '"goal": ${goal.toString()}, ' +
        '}';
  }
}
