class ReferalModel {
  final String bgImage;
  final String bio;
  final String createdDate;
  final String email;
  final String? firstName;
  final bool forSale;
  final int id;
  final String image;
  final String lastName;
  final int location;
  final String nickname;
  final String phone;
  final String points;
  final String pointsFromTurnir;
  final String price;
  final String pubgId;
  final int pubgType;
  final String updatedDate;
  final int user;
  final bool verified;
  final bool vip;
  final String ref_code;
  final String used_ref_code;
  final String pubg_username;

  ReferalModel(
      {required this.id,
      required this.pubgType,
      required this.vip,
      required this.bgImage,
      required this.location,
      required this.user,
      required this.verified,
      required this.forSale,
      required this.bio,
      required this.createdDate,
      required this.email,
      this.firstName,
      required this.image,
      required this.lastName,
      required this.nickname,
      required this.phone,
      required this.points,
      required this.pointsFromTurnir,
      required this.price,
      required this.pubgId,
      required this.updatedDate,
      required this.ref_code,
      required this.used_ref_code,
      required this.pubg_username});

  factory ReferalModel.fromJson(Map<dynamic, dynamic> json) {
    return ReferalModel(
      id: json['id'] ?? 0,
      pubgType: json['pubg_type'] ?? 0,
      pubg_username: json['pubg_username'] ?? '',
      lastName: json['last_name'] ?? 'null',
      verified: json['verified'] ?? false,
      forSale: json['for_sale'] ?? false,
      bgImage: json['bg_image'] ?? 'null',
      bio: json['bio'] ?? 'null',
      createdDate: json['created_date'] ?? 'null',
      email: json['email'] ?? 'null',
      vip: json['vip'] ?? false,
      user: json['user'] ?? 0,
      location: json['location'] ?? 0,
      firstName: json['first_name'] ?? 'null',
      image: json['image'] ?? 'null',
      nickname: json['pubg_username'] ?? 'null',
      phone: json['phone'] ?? 'null',
      points: json['points'] ?? 'null',
      used_ref_code: json['used_ref_code'] ?? '',
      ref_code: json['ref_code'] ?? '',
      pointsFromTurnir: json['points_from_turnir'] ?? 'null',
      price: json['price'] ?? 'null',
      pubgId: json['pubg_id'] ?? 'null',
      updatedDate: json['updated_date'] ?? 'null',
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'pubgType': pubgType,
        'pubg_username': pubg_username,
        'lastName': lastName,
        'verified': verified,
        'forSale': forSale,
        'bgImage': bgImage,
        'bio': bio,
        'createdDate': createdDate,
        'email': email,
        'vip': vip,
        'user': user,
        'location': location,
        'firstName': firstName,
        'image': image,
        'nickname': nickname,
        'phone': phone,
        'points': points,
        'used_ref_code': used_ref_code,
        'ref_code': ref_code,
        'pointsFromTurnir': pointsFromTurnir,
        'price': price,
        'pubgId': pubgId,
        'updatedDate': updatedDate,
      };
}
