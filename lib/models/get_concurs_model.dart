class GEtConcursModel {
  final int? id;
  final String nameTm;
  final String nameRu;
  final String image;
  final int places;
  final DateTime createdDate;
  final DateTime finishedDate;
  final String finishedTime;
  final int cat;

  GEtConcursModel({
    required this.id,
    required this.nameTm,
    required this.nameRu,
    required this.image,
    required this.places,
    required this.createdDate,
    required this.finishedDate,
    required this.finishedTime,
    required this.cat,
  });

  factory GEtConcursModel.fromJson(Map<String, dynamic> json) {
    return GEtConcursModel(
      id: json['id'] ?? 0,
      nameTm: json['name_tm'] ?? "",
      nameRu: json['name_ru'] ?? "",
      image: json['image'] ?? "",
      places: json['places'] ?? 0,
      createdDate: DateTime.parse(json['created_date'] ?? 0),
      finishedDate: DateTime.parse(json['finished_date'] ?? 0),
      finishedTime: json['finished_time'] ?? "",
      cat: json['cat'] ?? 0,
    );
  }
}
