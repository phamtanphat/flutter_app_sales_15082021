import 'package:flutter_app_sales_15082021/model/food_model.dart';

class CartModel{
  int? total;
  List<FoodModel>? items;

  CartModel.fromJson(Map<String,dynamic> json){
    total = json['total'];
    items = FoodModel.pareJsonModelToList(json['items']);
  }

  static CartModel fromJsonModel(json) => CartModel.fromJson(json);
}