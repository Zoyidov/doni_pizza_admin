import 'package:doni_pizza_admin/business_logic/model/category_model.dart';
import 'package:doni_pizza_admin/business_logic/repositories/category_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<List<CategoryModel>> {
  final CategoryRepository categoryRepository;

  CategoryCubit(this.categoryRepository) : super([]) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final categories = await categoryRepository.getAllCategories();
      emit(categories);
    } catch (e) {
      print("Error loading all categories: $e");
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      await categoryRepository.addCategory(category);
      fetchCategories(); // Refresh the list of categories after adding a new one
    } catch (e) {
      print("Error adding category: $e");
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    try {
      await categoryRepository.updateCategory(category);
      fetchCategories(); // Refresh the list of categories after updating one
    } catch (e) {
      print("Error updating category: $e");
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await categoryRepository.deleteCategory(categoryId);
      fetchCategories(); // Refresh the list of categories after deleting one
    } catch (e) {
      print("Error deleting category: $e");
    }
  }
}
