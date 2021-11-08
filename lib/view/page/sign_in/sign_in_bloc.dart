import 'dart:async';

import 'package:flutter_app_sales_15082021/base/base_bloc.dart';
import 'package:flutter_app_sales_15082021/base/base_event.dart';
import 'package:flutter_app_sales_15082021/model/user_model.dart';

class SignInBloc extends BaseBloc{

  StreamController<UserModel> userController = StreamController();

  @override
  void dispatch(BaseEvent event) {
    // TODO: implement dispatch
  }

  @override
  void dispose() {
    super.dispose();
    userController.close();
  }

}