import 'package:flutter_app_sales_15082021/base/base_event.dart';

abstract class SignInEventBase extends BaseEvent{

}

class SignInEvent extends SignInEventBase{
  late String email;
  late String password;

  SignInEvent({required this.email , required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
}

class SignInEventSuccess extends SignInEventBase{

  SignInEventSuccess();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SignInEventFail extends SignInEventBase{

  late String message;

  SignInEventFail({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}