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

  Category.fromMap(final Map<String, dynamic> map) {
    fromMap(map);
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'color': color,
        'icon': icon,
      };

  void fromMap(final Map<String, dynamic> map) {
    _log.fine('Parses $map to Category.');

    assert(map.containsKey('id'),
        'Failed parsing map to domain model "Category": The inputted map doesn\'t contain the field "id"');
    assert(map.containsKey('name'),
        'Failed parsing map to domain model "Category": The inputted map doesn\'t contain the field "name"');
    assert(map.containsKey('description'),
        'Failed parsing map to domain model "Category": The inputted map doesn\'t contain the field "description"');
    assert(map.containsKey('color'),
        'Failed parsing map to domain model "Category": The inputted map doesn\'t contain the field "color"');
    assert(map.containsKey('icon'),
        'Failed parsing map to domain model "Category": The inputted map doesn\'t contain the field "icon"');

    id = map['id'];
    name = map['name'];
    description = map['description'];
    color = map['color'];
    icon = map['icon'];
  }

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
