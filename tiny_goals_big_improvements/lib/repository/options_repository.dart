import 'package:sqflite/sqlite_api.dart';
import 'package:tiny_goals_big_improvements/repository/database.dart';

class OptionsRepository {
  Future<String?> getLanguage() async {
    Database database = await getDatabase();

    List<Map<String, Object?>> result =
        await database.query('options', where: 'key = ?', whereArgs: ['lang']);

    if (result.isEmpty) {
      return null;
    }

    return result[0]['value'].toString();
  }

  Future<void> saveLanguage(String languageKey) async {
    Database database = await getDatabase();

    int count = await database.update(
      'options',
      {'key': 'lang', 'value': languageKey},
      where: 'key = ?',
      whereArgs: ['lang'],
    );

    if (count == 0) {
      await database.insert('options', {'key': 'lang', 'value': languageKey});
    }
  }
}
