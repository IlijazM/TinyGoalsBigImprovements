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

  Accomplishment(
      {required this.date, required this.amount, required this.goal});

  Accomplishment.fromMap(final Map<String, dynamic> map) {
    fromMap(map);
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date,
        'amount': amount,
        'goal': goal,
      };

  void fromMap(final Map<String, dynamic> map) {
    _log.fine('Parses $map to Accomplishment.');

    assert(map.containsKey('id'),
        'Failed parsing map to domain model "Accomplishment": The inputted map doesn\'t contain the field "id"');
    assert(map.containsKey('date'),
        'Failed parsing map to domain model "Accomplishment": The inputted map doesn\'t contain the field "date"');
    assert(map.containsKey('amount'),
        'Failed parsing map to domain model "Accomplishment": The inputted map doesn\'t contain the field "amount"');
    assert(map.containsKey('goal'),
        'Failed parsing map to domain model "Accomplishment": The inputted map doesn\'t contain the field "goal"');

    id = map['id'];
    date = map['date'];
    amount = map['amount'];
    goal = map['goal'];
  }

  @override
  String toString() {
    return 'Goal{' +
        '"id": ${id.toString()}' +
        '"date": ${date.toString()}' +
        '"amount": ${amount.toString()}' +
        '"goal": ${goal.toString()}' +
        '}';
  }
}
