import 'package:flutter_app_sales_15082021/base/base_event.dart';

abstract class SignInEventBase extends BaseEvent{

}

class SignInEvent extends SignInEventBase{
  late String userName;
  late String password;

  SignInEvent({required this.userName , required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [userName,password];
}