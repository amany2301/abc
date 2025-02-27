class Subcategory {
  final int id;
  final String title;

  Subcategory({required this.id, required this.title});

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'],
      title: json['title'],
    );
  }
}
