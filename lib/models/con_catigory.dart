class ConCatigory {
  final int id;
  final String nameTm;
  final String nameRu;
  final String image;

  ConCatigory({required this.id, required this.nameTm, required this.nameRu, required this.image});

  factory ConCatigory.fromJson(Map<String, dynamic> json) {
    return ConCatigory(
      id: json['id'] as int,
      nameTm: json['name_tm'] as String,
      nameRu: json['name_ru'] as String,
      image: json['image'] as String,
    );
  }
}
