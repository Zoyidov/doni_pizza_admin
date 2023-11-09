import 'package:doni_pizza_admin/business_logic/model/category_model.dart';
import 'package:doni_pizza_admin/presentation/utils/uid.dart';

class FoodItem {
  String? id;

  String name;

  String description;

  double price;

  @override
  String toString() {
    return 'FoodItem{id: $id, name: $name, description: $description, price: $price, imageUrl: $imageUrl, category: $category}';
  }

  String imageUrl;

  CategoryModel category;

  FoodItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      category: CategoryModel.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? UidGenerator.generateUID(),
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category.toJson(),
    };
  }

  FoodItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    CategoryModel? category,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }
}
