

class CategoryModel {
  final String id;

  final String name;

  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'CategoryModel{id: $id, name: $name, imageUrl: $imageUrl}';
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
