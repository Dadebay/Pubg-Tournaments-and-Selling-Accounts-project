class BestPlayersModel {
  final int? id;
  final String? pubgUsername;
  final String? image;
  final String? points;
  BestPlayersModel({
    this.id,
    this.pubgUsername,
    this.image,
    this.points,
  });

  factory BestPlayersModel.fromJson(Map<dynamic, dynamic> json) {
    return BestPlayersModel(id: json['id'], pubgUsername: json['pubg_username'], points: json['points_from_turnir'], image: json['image']);
  }
}
