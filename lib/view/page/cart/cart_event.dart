import 'package:flutter_app_sales_15082021/base/base_event.dart';

abstract class CartEventBase extends BaseEvent{

}

class CartEventOrderDetail extends CartEventBase{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class CartEventOrderUpdate extends CartEventBase{
  late String orderId;
  late String foodId;
  late int quantity;

  CartEventOrderUpdate({required this.orderId, required this.foodId, required this.quantity});

  @override
  // TODO: implement props
  List<Object?> get props => [orderId,foodId,quantity];

}

class CartEventOrderDeleteItem extends CartEventBase{
  late String foodId;

  CartEventOrderDeleteItem({required this.foodId});

  @override
  // TODO: implement props
  List<Object?> get props => [foodId];

}