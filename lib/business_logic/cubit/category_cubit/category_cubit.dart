import 'dart:io';

import 'package:doni_pizza_admin/business_logic/model/category_model.dart';
import 'package:doni_pizza_admin/business_logic/repositories/category_repo.dart';
import 'package:doni_pizza_admin/presentation/utils/firebase_helper.dart';
import 'package:flutter/foundation.dart';
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
      if (kDebugMode) {
        print("Error loading all categories: $e");
      }
    }
  }

  Future<void> addCategory(CategoryModel category) async {
    try {
      await categoryRepository.addCategory(category);
      fetchCategories();
    } catch (e) {
      if (kDebugMode) {
        print("Error adding category: $e");
      }
    }
  }

  Future<void> updateCategory(CategoryModel category,File? image) async {
    try {
      if (image != null) {
        final url = await TFirebaseHelper.uploadImage(image, 'images/categories/${image.uri.pathSegments.last}');
        await categoryRepository.updateCategory(category.copyWith(imageUrl: url));
      }
      else {
        await categoryRepository.updateCategory(category);
      }
      fetchCategories();
    } catch (e) {
      if (kDebugMode) {
        print("Error updating category: $e");
      }
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await categoryRepository.deleteCategory(categoryId);
      fetchCategories();
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting category: $e");
      }
    }
  }
}
