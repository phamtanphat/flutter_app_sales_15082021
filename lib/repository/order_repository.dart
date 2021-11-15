import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_sales_15082021/model/cart_model.dart';
import 'package:flutter_app_sales_15082021/model/order_model.dart';
import 'package:flutter_app_sales_15082021/model/response_model.dart';
import 'package:flutter_app_sales_15082021/request/order_request.dart';

class OrderRepository{
  late OrderRequest _orderRequest;

  OrderRepository();

  void updateOrderRequest(OrderRequest orderRequest){
    _orderRequest = orderRequest;
  }



  Future<OrderModel> addFoodToCart(String foodId) async{
    Completer<OrderModel> completer = Completer();
    try{
      Response response = await _orderRequest.addCart(foodId);
      if (response.statusCode == 200){
        ResponseModel<OrderModel> responseModel = ResponseModel.fromJson(response.data,OrderModel.fromJsonModel);
        completer.complete(responseModel.data);
      }
    }on DioError catch (dioError){
      completer.completeError(dioError.response?.data["message"]);
    } catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<OrderModel> getTotalCount() async{
    Completer<OrderModel> completer = Completer();
    try{
      Response response = await _orderRequest.getTotalCountCart();
      if (response.statusCode == 200){
        ResponseModel<OrderModel> responseModel = ResponseModel.fromJson(response.data,OrderModel.fromJsonModel);
        completer.complete(responseModel.data);
      }
    }on DioError catch (dioError){
      completer.completeError(dioError.response?.data["message"]);
    } catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }

  Future<CartModel> getOrderDetail() async{
    Completer<CartModel> completer = Completer();
    try{
      Response response = await _orderRequest.getDetailOrder();
      if (response.statusCode == 200){
        ResponseModel<CartModel> responseModel = ResponseModel.fromJson(response.data,CartModel.fromJsonModel);
        completer.complete(responseModel.data);
      }
    }on DioError catch (dioError){
      completer.completeError(dioError.response?.data["message"]);
    } catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }

}