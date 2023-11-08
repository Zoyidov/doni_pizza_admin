import 'package:doni_pizza_admin/business_logic/model/food_model.dart';
import 'package:doni_pizza_admin/business_logic/repositories/food_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodCubit extends Cubit<List<FoodItem>> {
  final FoodItemRepository foodItemRepository;

  FoodCubit(this.foodItemRepository) : super([]) {
    fetchFoodItems();
  }

  Future<void> fetchFoodItems() async {
    try {
      final foods = await foodItemRepository.getAllFoodItems();
      emit(foods);
    } catch (e) {
      if (kDebugMode) {
        print("Error load all foods:$e");
      }
    }
  }

  Future<void> getFoodItemsInCategory(String categoryId) async {
    try {
      final foodsByCategory = await foodItemRepository.getFoodItemsInCategory(categoryId);
      emit(foodsByCategory);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (kDebugMode) {
        print("Error load foods by category");
      }
    }
  }

  Future<void> searchFoodItems(String query) async {
    try {
      final foodsByCategory = await foodItemRepository.searchFoodItems(query);
      emit(foodsByCategory);
    } catch (e) {
      if (kDebugMode) {
        print("Error load foods using search:$e");
      }
    }
  }
}
