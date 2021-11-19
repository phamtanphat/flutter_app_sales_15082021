import 'dart:async';

import 'package:flutter_app_sales_15082021/base/base_bloc.dart';
import 'package:flutter_app_sales_15082021/base/base_event.dart';
import 'package:flutter_app_sales_15082021/model/cart_model.dart';
import 'package:flutter_app_sales_15082021/repository/order_repository.dart';
import 'package:flutter_app_sales_15082021/view/page/cart/cart_event.dart';

class CartBloc extends BaseBloc{
  late OrderRepository _repository;

  StreamController<CartModel> cartController = StreamController();
  StreamController<String> resultController = StreamController();

  void updateOrderRepo(OrderRepository repository){
    _repository = repository;
  }

  @override
  void dispatch(BaseEvent event) {
    if(event is CartEventOrderDetail){
      handleOrderDetail(event);
    }else if(event is CartEventOrderUpdate){
      handleOrderUpdate(event);
    }else if(event is CartEventOrderDeleteItem){
      handleOrderDeleteItem(event);
    }else if (event is CartEventSubmit){
      handleOrderSubmit(event);
    }
  }
  @override
  void dispose() {
    cartController.close();
    resultController.close();
    super.dispose();
  }

  void handleOrderDetail(CartEventOrderDetail event) async{
    loadingSink.add(true);
    try {
      CartModel cartModel = await _repository.getOrderDetail();
      cartController.sink.add(cartModel);
    } catch (e) {
      cartController.sink.addError(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }

  void handleOrderUpdate(CartEventOrderUpdate event) async{
    loadingSink.add(true);
    try {
      String result = await _repository.updateOrder(event.orderId, event.foodId, event.quantity);
      resultController.sink.add("Cap nhat thanh cong");
      eventSink.add(CartEventOrderDetail());
    } catch (e) {
      resultController.sink.addError(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }

  void handleOrderDeleteItem(CartEventOrderDeleteItem event) async{
    loadingSink.add(true);
    try {
      String result = await _repository.deleteItemOrder(event.foodId);
      resultController.sink.add("Xoa thanh cong");
      eventSink.add(CartEventOrderDetail());
    } catch (e) {
      resultController.sink.addError(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }

  void handleOrderSubmit(CartEventSubmit event) async {
    loadingSink.add(true);
    try {
      String result = await _repository.submit(event.orderId);
      resultController.sink.add("Mua hang thanh cong");
      progressSink.add(CartEventSubmitSuccess());
    } catch (e) {
      resultController.sink.addError(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }

}