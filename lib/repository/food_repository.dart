import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_sales_15082021/model/food_model.dart';
import 'package:flutter_app_sales_15082021/model/response_model.dart';
import 'package:flutter_app_sales_15082021/request/food_request.dart';

class FoodRepository{
  late FoodRequest _request;

  FoodRepository();

  void updateFoodRequest(FoodRequest request){
    _request = request;
  }

  Future<ResponseModel<List<FoodModel>>> fetchListFood() async{
    Completer<ResponseModel<List<FoodModel>>> completer = Completer();
    try{
      Response response = await _request.fetchListFood();
      if(response.statusCode == 200){
        ResponseModel<List<FoodModel>> responseModel = ResponseModel.fromJson(response.data,FoodModel.pareJsonModelToList);
        completer.complete(responseModel);
      }
    }on DioError catch(dioError){
      completer.completeError(dioError.response?.data["message"]);
    }catch (error){
      completer.completeError(error.toString());
    }
    return completer.future;
  }
}