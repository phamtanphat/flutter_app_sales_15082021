class OrderModel {
  String? orderId;
  int? total;

  OrderModel({required this.orderId, required this.total});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    total = json['total'];
  }

  static OrderModel fromJsonModel(Map<String,dynamic> json) => OrderModel.fromJson(json);
}
