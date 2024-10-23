// ignore_for_file: non_constant_identifier_names

class ThingsMODEL {
  final int id;
  final int cat;
  final String nameTm;
  final String nameRu;
  final String price;
  final int order;
  final String image;
  final String createdDate;

  final String asking;

  ThingsMODEL({
    required this.id,
    required this.order,
    required this.asking,
    required this.createdDate,
    required this.nameTm,
    required this.nameRu,
    required this.image,
    required this.price,
    required this.cat,
  });

  factory ThingsMODEL.fromJson(Map<dynamic, dynamic> json) {
    return ThingsMODEL(
      id: json['id'] ?? 0,
      nameTm: json['name_tm'] ?? '',
      nameRu: json['name_ru'] ?? '',
      price: json['price'].toString(),
      cat: json['cat'] ?? 0,
      order: json['order'] ?? 0,
      image: json['img'] ?? '',
      createdDate: json['created_at'] ?? '',
      asking: json['asking'] ?? '',
    );
  }
}

class GiftsMOdel {
  final int id;
  final String nameTm;
  final String nameRu;
  final String descTM;
  final String descRU;
  final String createdDate;
  final int count;
  final int count_left;
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
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      count: json['count'] as int,
      count_left: json['count_left'] as int,
      descTM: json['description_tm'] as String,
      descRU: json['description_ru'] as String,
      createdDate: json['created_date'] as String,
    );
  }
}
