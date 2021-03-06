import 'package:logging/logging.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/repository/category_repository.dart';

class CategoryService {
  static final _log = Logger('CategoryService');

  final CategoryRepository _categoryRepository;

  CategoryService() : _categoryRepository = CategoryRepository();

  Future<void> createNewCategory(Category category) async {
    _log.info("Request to create or update a Category.");

    await _categoryRepository.save(category);
  }

  Future<List<Category>> getAllCategories() async {
    _log.info("Request all Categories.");

    List<Category> result = await _categoryRepository.findAll();

    _log.info(
        "Successfully got all Categories. Got ${result.length} in total.");

    return result;
  }

  Future<void> deleteCategory(int id) async {
    _log.info("Request to delete Goal with the id $id.");

    await _categoryRepository.delete(id);
  }
}
