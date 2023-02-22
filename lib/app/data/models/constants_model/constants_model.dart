class ConstantsModel {
  final int? id;
  final String? priceForVip;
  final String? priceForNotVip;
  final int? videoLimit;
  final String? priceForRef;
  final String? phoneOne;
  final String? phoneTwo;
  final String? text;
  final String? rublePrice;
  final String? dollarPrice;
  final String? liraPrice;
  final String? bestPlayersText;
  ConstantsModel({this.id, this.priceForNotVip, this.bestPlayersText, this.dollarPrice, this.liraPrice, this.phoneOne, this.phoneTwo, this.priceForRef, this.priceForVip, this.rublePrice, this.text, this.videoLimit});

  factory ConstantsModel.fromJson(Map<dynamic, dynamic> json) {
    return ConstantsModel(
      id: json['id'] ?? 0,
      priceForNotVip: json['price_for_vip'] ?? '',
      priceForVip: json['price_for_not_vip'] ?? '',
      videoLimit: json['video_limit'] ?? 0,
      priceForRef: json['price_for_ref'] ?? '',
      phoneOne: json['phone_one'] ?? '',
      phoneTwo: json['phone_two'] ?? '',
      text: json['text'] ?? '',
      rublePrice: json['ruble_perc'] ?? '',
      dollarPrice: json['dollar_perc'] ?? '',
      liraPrice: json['lira_perc'] ?? '',
      bestPlayersText: json['best_players_text'] ?? '',
    );
  }
}
