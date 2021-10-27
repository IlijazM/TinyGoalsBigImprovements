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

  Goal(
      {required this.activity,
      this.description,
      required this.amount,
      required this.repeatCount,
      required this.repeatType,
      required this.category});

  Goal.fromMap(final Map<String, dynamic> map) {
    fromMap(map);
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'activity': activity,
        'description': description,
        'amount': amount,
        'repeatCount': repeatCount,
        'repeatType': repeatType,
        'category': category,
      };

  void fromMap(final Map<String, dynamic> map) {
    _log.fine('Parses $map to Goal.');

    assert(map.containsKey('id'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "id"');
    assert(map.containsKey('activity'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "activity"');
    assert(map.containsKey('description'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "description"');
    assert(map.containsKey('amount'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "amount"');
    assert(map.containsKey('repeatCount'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "repeatCount"');
    assert(map.containsKey('repeatType'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "repeatType"');
    assert(map.containsKey('category'),
        'Failed parsing map to domain model "Goal": The inputted map doesn\'t contain the field "category"');

    id = map['id'];
    activity = map['activity'];
    description = map['description'];
    amount = map['amount'];
    repeatCount = map['repeatCount'];
    repeatType = map['repeatType'];
    category = map['category'];
  }

  @override
  String toString() {
    return 'Goal{' +
        '"id": ${id.toString()}' +
        '"activity": ${activity.toString()}' +
        '"description": ${description.toString()}' +
        '"amount": ${amount.toString()}' +
        '"repeatCount": ${repeatCount.toString()}' +
        '"repeatType": ${repeatType.toString()}' +
        '"category": ${category.toString()}' +
        '}';
  }
}
