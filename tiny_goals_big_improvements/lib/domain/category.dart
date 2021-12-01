import 'package:logging/logging.dart';

/// A category groups goals together.
class Category {
  static const tableName = 'categories';

  static final _log = Logger('Category');

  int? id;

  /// The name of the category
  late String name;

  /// The description of the category.
  late String? description;

  /// The color in the category stored as hex colors (e.g. '0xff0000')
  late int color;

  /// The name of the icon of the category.
  late String icon;

  Category({
    this.id,
    required this.name,
    this.description,
    required this.color,
    required this.icon,
  });

  @override
  String toString() {
    return 'Category{' +
        '"id": ${id.toString()}' +
        '"name": ${name.toString()}' +
        '"description": ${description.toString()}' +
        '"color": ${color.toString()}' +
        '"icon": ${icon.toString()}' +
        '}';
  }
}
