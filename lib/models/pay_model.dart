class PayModel {
  final String formUrl;
  final String orderId;

  PayModel({
    required this.formUrl,
    required this.orderId,
  });

  factory PayModel.fromJson(Map<dynamic, dynamic> json) {
    return PayModel(
      formUrl: json['formUrl'] ?? "",
      orderId: json['orderId'] ?? "",
    );
  }
}
