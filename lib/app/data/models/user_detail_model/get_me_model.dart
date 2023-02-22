class GetMeModel {
  GetMeModel({
    this.id,
    this.vip,
    this.bgImage,
    this.user,
    this.verified,
    this.forSale,
    this.bio,
    this.createdDate,
    this.email,
    this.firstName,
    this.image,
    this.lastName,
    this.nickname,
    this.phone,
    this.points,
    this.pointsFromTurnir,
    this.price,
    this.pubgId,
    this.updatedDate,
    this.blocked,
    this.blockedDate,this.blockedReason,this.refCode,this.usedRefCode
  });

  factory GetMeModel.fromJson(Map<dynamic, dynamic> json) {
    return GetMeModel(
      id: json['id']??0,
      nickname: json['pubg_username']??'',
      pubgId: json['pubg_id']??0,
      firstName: json['first_name']??'',
      lastName: json['last_name']??'',
      email: json['email']??'',
      phone: json['phone']??'',
      bio: json['bio']??'',
      points: json['points']??'',
      pointsFromTurnir: json['points_from_turnir']??'',
      image: json['image']??'',
      bgImage: json['bg_image']??'',
      verified: json['verified']??false,
      vip: json['vip']??false,
      blocked: json['blocked']??false,
      blockedReason: json['block_reason']??'',
      blockedDate: json['blocked_date']??'',
      refCode: json['ref_code']??'',
      usedRefCode: json['used_ref_code']??'',
      createdDate: json['created_date']??'',
      user: json['user']??0,
    );
  }

  final int? id;
  final int? user;
  final bool? verified;
  final bool? vip;
  final bool? forSale;
  final bool? blocked;
  final String? refCode;
  final String? usedRefCode;
  final String? blockedReason;
  final String? blockedDate;
  final String? bgImage;
  final String? bio;
  final String? createdDate;
  final String? email;
  final String? firstName;
  final String? image;
  final String? lastName;
  final String? nickname;
  final String? phone;
  final String? points;
  final String? pointsFromTurnir;
  final String? price;
  final String? pubgId;
  final String? updatedDate;
}
