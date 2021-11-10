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

  @override
  void dispatch(BaseEvent event) {
    if(event is SignInEvent){
      handleSignIn(event);
    }
  }

  void handleSignIn(SignInEvent event) {
    loadingSink.add(true);
    Future.delayed(Duration(seconds: 2),() async{
      try{
        ResponseModel<UserModel> response = await repository.signIn(event.email, event.password);
        progressSink.add(SignInEventSuccess());
      }catch(e){
        progressSink.add(SignInEventFail(message: e.toString()));
      }finally{
        loadingSink.add(false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

}