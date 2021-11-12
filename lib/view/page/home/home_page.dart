import 'package:flutter/material.dart';
import 'package:flutter_app_sales_15082021/base/base_widget.dart';
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        appBar: AppBar(
          title: Text("Home"),
        ),
        child: HomePageContainer(),
        providers: []
    );
  }
}

class HomePageContainer extends StatefulWidget {

  @override
  _HomePageContainerState createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

