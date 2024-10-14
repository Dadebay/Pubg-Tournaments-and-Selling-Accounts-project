// ignore_for_file: non_constant_identifier_names

class GiftsMOdel {
  final int id;
  final int count;
  final int count_left;
  final String descTM;
  final String descRU;
  final String createdDate;
  final String nameTm;
  final String nameRu;
  final Map<String, dynamic> image;
  final double price;
  final String cat;

  GiftsMOdel({
    required this.id,
    required this.count,
    required this.count_left,
    required this.descTM,
    required this.descRU,
    required this.createdDate,
    required this.nameTm,
    required this.nameRu,
    required this.image,
    required this.price,
    required this.cat,
  });

  factory GiftsMOdel.fromJson(Map<String, dynamic> json) {
    return GiftsMOdel(
      id: json['id'] as int,
      cat: json['cat'] as String,
      nameTm: json['name_tm'] as String,
      nameRu: json['name_ru'] as String,
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      count: json['count'] as int,
      count_left: json['count_left'] as int,
      descTM: json['description_tm'] as String,
      descRU: json['description_ru'] as String,
      createdDate: json['created_date'] as String,
    );
  }
}
