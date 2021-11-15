import 'package:flutter/material.dart';
import 'package:flutter_app_sales_15082021/base/base_widget.dart';
import 'package:flutter_app_sales_15082021/common/share_pref.dart';
import 'package:lottie/lottie.dart';
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: SplashPageContainer(),
      providers: [],
    );
  }
}

class SplashPageContainer extends StatefulWidget {
  const SplashPageContainer({Key? key}) : super(key: key);

  @override
  _SplashPageContainerState createState() => _SplashPageContainerState();
}

class _SplashPageContainerState extends State<SplashPageContainer> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // SPref.instance.clearSPref();
    Future.delayed(Duration(seconds: 3 ) , () async{
      var token = await SPref.instance.get("token");
      if (token != null){
        Navigator.pushReplacementNamed(context, "/home");
      }else{
        Navigator.pushReplacementNamed(context, "/sign-in");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset('assets/animations/animation_splash.json',
                animate: true, repeat: true),
            Text("Welcome",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white))
          ],
        ));
  }
}