import 'package:logging/logging.dart';
import 'package:tiny_goals_big_improvements/domain/category.dart';
import 'package:tiny_goals_big_improvements/repository/category_repository.dart';

class CategoryService {
  static final _log = Logger('CategoryService');

  CategoryRepository _categoryRepository;

  CategoryService() : _categoryRepository = CategoryRepository();

  void createNewCategory(Category category) {
    _log.info("Request to create or update a category.");

    _categoryRepository.save(category);
  }

  Future<List<Category>> getAllCategories() async {
    _log.info("Request all categories.");

    List<Category> result = await _categoryRepository.findAll();

    _log.info(
        "Successfully got all categories. Got ${result.length} in total.");

    return result;
  }

  void deleteCategory(int id) {
    _log.info("Request to delete category with the id $id.");

    _categoryRepository.delete(id);
  }
}
