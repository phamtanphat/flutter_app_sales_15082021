import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_app_sales_15082021/model/response_model.dart';
import 'package:flutter_app_sales_15082021/model/user_model.dart';
import 'package:flutter_app_sales_15082021/request/authentication_request.dart';

class AuthenticationRepository {
  late AuthenticationRequest request;

  AuthenticationRepository(){

  }
  void updateAuthenticationRequest(AuthenticationRequest request){
    this.request = request;
  }

  Future<ResponseModel<UserModel>> signIn(String email , String password) async{
    Completer<ResponseModel<UserModel>> completer = Completer();
    try{
      Response response = await request.signIn(email, password);
      print(response.data);
    }on DioError catch(dioError){
      print(dioError.response?.data["message"]);
    }catch (error){
      print(error.toString());
    }
    return completer.future;
  }

}