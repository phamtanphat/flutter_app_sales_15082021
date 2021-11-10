import 'dart:async';

import 'package:flutter_app_sales_15082021/base/base_bloc.dart';
import 'package:flutter_app_sales_15082021/base/base_event.dart';
import 'package:flutter_app_sales_15082021/model/response_model.dart';
import 'package:flutter_app_sales_15082021/model/user_model.dart';
import 'package:flutter_app_sales_15082021/repository/authentication_repository.dart';
import 'package:flutter_app_sales_15082021/view/page/sign_in/sign_in_event.dart';

class SignInBloc extends BaseBloc{
  late AuthenticationRepository repository;

  SignInBloc();

  void updateAuthenticationRepo(AuthenticationRepository repository){
    this.repository = repository;
  }

  StreamController<UserModel> userController = StreamController();

  @override
  void dispatch(BaseEvent event) {
    if(event is SignInEvent){
      handleSignIn(event);
    }
  }

  void handleSignIn(SignInEvent event) async{
    try{
      ResponseModel<UserModel> response = await repository.signIn(event.email, event.password);
      userController.sink.add(response.data!);
    }catch(e){
      userController.sink.addError(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    userController.close();
  }

}