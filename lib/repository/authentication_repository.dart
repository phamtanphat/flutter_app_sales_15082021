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
      if(response.statusCode == 200){
        ResponseModel<UserModel> responseModel = ResponseModel.fromJson(response.data,UserModel.fromJsonModel);
        completer.complete(responseModel);
      }
    }on DioError catch(dioError){
      completer.completeError(dioError.response?.data["message"]);
    }catch (error){
      completer.completeError(error.toString());
    }
    return completer.future;
  }

  Future<ResponseModel<UserModel>> signUp(String fullName,String email,String phone,String password,String address) async{
    Completer<ResponseModel<UserModel>> completer = Completer<ResponseModel<UserModel>>();
    try{
      Response response = await request.signUp(fullName, email, phone, password, address);
      if (response.statusCode == 200){
        ResponseModel<UserModel> data = ResponseModel.fromJson(response.data, UserModel.fromJsonModel);
        completer.complete(data);
      }
    } on DioError catch (dioError){
      completer.completeError(dioError.response?.data["message"]);
    }
    catch(e){
      completer.completeError(e.toString());
    }
    return completer.future;
  }


}