import 'package:flutter/material.dart';
import 'package:flutter_app_sales_15082021/view/page/sign_in/sign_in_page.dart';
import 'package:flutter_app_sales_15082021/view/page/sign_up/sign_up_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/sign-in" : (context) => SignInPage(),
        "/sign-up" : (context) => SignUpPage(),
      },
      initialRoute: "/sign-in",
    );
  }
}
