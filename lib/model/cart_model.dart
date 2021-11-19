import 'package:flutter_app_sales_15082021/model/food_model.dart';

class CartModel{
  int? total;
  List<FoodModel>? items;

  CartModel.fromJson(Map<String,dynamic> json){
    if(json != null){
      total = json['total'] ?? null;
      items = FoodModel.pareJsonModelToList(json['items'] ?? null);
    }else{
      total = 0;
      items = [];
    }
  }


  @override
  String toString() {
    return 'CartModel{total: $total, items: $items}';
  }

  static CartModel fromJsonModel(json) => CartModel.fromJson(json);
}