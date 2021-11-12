import 'package:dio/dio.dart';
import 'package:flutter_app_sales_15082021/api/client/dio_client.dart';

class FoodRequest{
  late Dio _dio;

  FoodRequest(){
    _dio = DioClient.instance.dio;
  }

  Future fetchListFood(){
    //end point
    return _dio.get('food/list/0/10');
  }
}