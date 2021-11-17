import 'package:dio/dio.dart';
import 'package:flutter_app_sales_15082021/api/client/dio_client.dart';

class OrderRequest{
  late Dio _dio;

  OrderRequest(){
    _dio = DioClient.instance.dio;
  }

  Future addCart(String foodId){
    return _dio.post("order/add-to-cart" , data: {
      "foodId" : foodId
    });
  }
  Future getTotalCountCart(){
    return _dio.get("order/count/shopping-cart");
  }

  Future getDetailOrder(){
    return _dio.get("order/shopping-cart");
  }

  Future updateOrder(String orderId , String foodId , int quantity){
    return _dio.post("order/update" , data: {
      "orderId": orderId,
      "foodId": foodId,
      "quantity": quantity
    });
  }

  Future deleteItemOrder(String foodId){
    return _dio.delete("order/delete" , data: {
      "foodId": foodId,
    });
  }
}