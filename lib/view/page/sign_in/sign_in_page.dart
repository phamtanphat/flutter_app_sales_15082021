import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sales_15082021/base/base_widget.dart';
import 'package:flutter_app_sales_15082021/repository/authentication_repository.dart';
import 'package:flutter_app_sales_15082021/request/authentication_request.dart';
import 'package:flutter_app_sales_15082021/view/page/sign_in/sign_in_bloc.dart';
import 'package:flutter_app_sales_15082021/view/page/sign_in/sign_in_event.dart';
import 'package:flutter_app_sales_15082021/view/widget/button_widget.dart';
import 'package:flutter_app_sales_15082021/view/widget/container_listener_widget.dart';
import 'package:flutter_app_sales_15082021/view/widget/loading_widget.dart';
import 'package:provider/provider.dart';
class SignInPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return PageContainer(
      providers: [
        Provider(create: (context) => AuthenticationRequest()),
        ProxyProvider<AuthenticationRequest,AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
          update: (context, request , repository){
            repository!.updateAuthenticationRequest(request);
            return repository;
          },
        ),
        ChangeNotifierProxyProvider<AuthenticationRepository,SignInBloc>(
          create: (context) => SignInBloc(),
          update: (context, repository , bloc){
            bloc!.updateAuthenticationRepo(repository);
            return bloc;
          },
        )
      ],
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      child: SignInContainer(),
    );
  }
}


class SignInContainer extends StatefulWidget {
  @override
  _SignInContainerState createState() => _SignInContainerState();
}

class _SignInContainerState extends State<SignInContainer> {
  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  var isPassVisible = true;

  late SignInBloc bloc;
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerListenerWidget<SignInBloc>(
      callback: (event){
        if (event is SignInEventSuccess){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Thanh cong")));
        }else{
          var message = (event as SignInEventFail).message;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
        }
      },
      child: LoadingWidget(
        bloc: bloc,
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                    flex: 2, child: Image.asset("assets/images/ic_hello_food.png")),
                Expanded(
                  flex: 4,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPhoneTextField(),
                        _buildPasswordTextField(),
                        _buildButtonSignIn(),
                      ],
                    ),
                  ),
                ),
                Expanded(child: _buildTextSignUp())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextSignUp() {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account!"),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text("Sign Up",
                  style: TextStyle(
                      color: Colors.red, decoration: TextDecoration.underline)),
            )
          ],
        ));
  }

  Widget _buildPhoneTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "Email",
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          prefixIcon: Icon(Icons.email, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        maxLines: 1,
        controller: _passController,
        obscureText: isPassVisible,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          fillColor: Colors.black12,
          filled: true,
          hintText: "PassWord",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0, color: Colors.black12)),
          labelStyle: TextStyle(color: Colors.blue),
          prefixIcon: Icon(Icons.lock, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildButtonSignIn() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: ButtonWidget(
          title: "Sign In",
          onPress: () {
            var email = _emailController.text.toString();
            var password = _passController.text.toString();
            bloc.eventSink.add(SignInEvent(email: email, password: password));
          },
        ));
  }

}

