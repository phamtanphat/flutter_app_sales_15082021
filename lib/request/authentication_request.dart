import 'package:dio/dio.dart';
import 'package:flutter_app_sales_15082021/api/client/dio_client.dart';


class AuthenticationRequest{
  late Dio _dio;

  AuthenticationRequest(){
    _dio = DioClient.instance.dio;
  }

  Future signIn(String email , String password){
    //end point
    return _dio.post('user/sign-in',data: {
      "email": email,
      "password": password
    });
  }

  Future signUp(String fullName, String email, String phone, String password, String address) {
    return _dio.post("user/sign-up", data: {
      "fullName": fullName,
      "email": email,
      "phone": phone,
      "password": password,
      "address": address
    });
  }
}