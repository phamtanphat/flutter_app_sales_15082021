import 'dart:async';

import 'package:flutter_app_sales_15082021/base/base_bloc.dart';
import 'package:flutter_app_sales_15082021/base/base_event.dart';
import 'package:flutter_app_sales_15082021/model/cart_model.dart';
import 'package:flutter_app_sales_15082021/repository/order_repository.dart';
import 'package:flutter_app_sales_15082021/view/page/cart/cart_event.dart';

class CartBloc extends BaseBloc{
  late OrderRepository _repository;

  StreamController<CartModel> cartController = StreamController();

  void updateOrderRepo(OrderRepository repository){
    _repository = repository;
  }

  @override
  void dispatch(BaseEvent event) {
    if(event is CartEventOrderDetail){
      handleOrderDetail(event);
    }
  }
  @override
  void dispose() {
    cartController.close();
    super.dispose();
  }

  void handleOrderDetail(CartEventOrderDetail event) async{
    loadingSink.add(true);
    try {
      CartModel cartModel = await _repository.getOrderDetail();
      print(cartModel.toString());
      cartController.sink.add(cartModel);
    } catch (e) {
      cartController.sink.addError(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }

}