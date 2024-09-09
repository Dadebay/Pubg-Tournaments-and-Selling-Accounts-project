class GiftsMOdel {
  final int id;
  final String nameTm;
  final String nameRu;
  final String image;
  final String ownerNumber;
  final double price;
  final bool satylanlygy;
  final int cat;

  GiftsMOdel({
    required this.id,
    required this.nameTm,
    required this.nameRu,
    required this.image,
    required this.ownerNumber,
    required this.price,
    required this.satylanlygy,
    required this.cat,
  });

  factory GiftsMOdel.fromJson(Map<String, dynamic> json) {
    return GiftsMOdel(
      id: json['id'] as int,
      nameTm: json['name_tm'] as String,
      nameRu: json['name_ru'] as String,
      image: json['image'] as String,
      ownerNumber: json['owner_number'] as String,
      price: (json['price'] as num).toDouble(),
      satylanlygy: json['satylanlygy'] as bool,
      cat: json['cat'] as int,
    );
  }
}
