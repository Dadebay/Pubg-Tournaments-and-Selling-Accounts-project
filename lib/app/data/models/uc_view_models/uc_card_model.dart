class UcCardModel {
  final int? id;
  final String? price;
  final String? liraPrice;
  final String? rublePrice;
  final String? title;
  final String? description_tm;
  final String? description_ru;
  final String? image;
  final String? created_date;
  UcCardModel({
    this.id,
    this.title,
    this.liraPrice,
    this.rublePrice,
    this.description_tm,
    this.description_ru,
    this.image,
    this.created_date,
    this.price,
  });

  factory UcCardModel.fromJson(Map<dynamic, dynamic> json) {
    return UcCardModel(
      id: json['id'],
      price: json['price'],
      rublePrice: json['ruble_price'],
      liraPrice: json['lira_price'],
      title: json['title'],
      image: json['image'],
      description_tm: json['description_tm'],
      description_ru: json['description_ru'],
      created_date: json['created_date'],
    );
  }

}
