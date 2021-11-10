import 'package:flutter_app_sales_15082021/base/base_bloc.dart';
import 'package:flutter_app_sales_15082021/base/base_event.dart';
import 'package:flutter_app_sales_15082021/model/response_model.dart';
import 'package:flutter_app_sales_15082021/model/user_model.dart';
import 'package:flutter_app_sales_15082021/repository/authentication_repository.dart';
import 'package:flutter_app_sales_15082021/view/page/sign_up/sign_up_event.dart';

class SignUpBloc extends BaseBloc {
  late AuthenticationRepository _authenRepo;


  SignUpBloc();

  void updateAuthenticationRepository(
      AuthenticationRepository authenticationRepository) {
    this._authenRepo = authenticationRepository;
  }

  @override
  void dispatch(BaseEvent event) {
    switch (event.runtimeType) {
      case SignUpEvent:
        handleSignUp(event as SignUpEvent);
        break;
    }
  }

  void handleSignUp(SignUpEvent event)  {
    loadingSink.add(true);
    Future.delayed(Duration(seconds: 2) , () async{
      try {
        ResponseModel<UserModel> responseModel = await _authenRepo.signUp(
            event.fullName,
            event.email,
            event.phone,
            event.password,
            event.address);
        UserModel? userModel = responseModel.data;
        if (userModel != null){
          progressSink.add(SignUpSuccess());
        }
      } catch (e) {
        progressSink.add(SignUpFail(message: e.toString()));
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