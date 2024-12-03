class Category {
  int id;
  String name;
  bool isSelected;

  Category({
    required this.id,
    required this.name,
    required this.isSelected,
  });

  Category copyWith({int? id, String? name, bool? isSelected}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      isSelected: false,
    );
  }
}
