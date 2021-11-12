import 'package:flutter/material.dart';
import 'package:flutter_app_sales_15082021/base/base_widget.dart';
import 'package:flutter_app_sales_15082021/repository/food_repository.dart';
import 'package:flutter_app_sales_15082021/request/food_request.dart';
import 'package:flutter_app_sales_15082021/view/page/home/home_bloc.dart';
import 'package:flutter_app_sales_15082021/view/page/home/home_event.dart';
import 'package:provider/provider.dart';
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        appBar: AppBar(
          title: Text("Home"),
        ),
        child: HomePageContainer(),
        providers: [
          Provider(create: (context) => FoodRequest()),
          ProxyProvider<FoodRequest,FoodRepository>(
            create: (context) => FoodRepository(),
            update: (context, request , repository){
              repository!.updateFoodRequest(request);
              return repository;
            },
          ),
          ChangeNotifierProxyProvider<FoodRepository,HomeBloc>(
            create: (context) => HomeBloc(),
            update: (context, repository , bloc){
              bloc!.updateFoodRepository(repository);
              return bloc;
            },
          )
        ]
    );
  }
}

class HomePageContainer extends StatefulWidget {

  @override
  _HomePageContainerState createState() => _HomePageContainerState();
}

class _HomePageContainerState extends State<HomePageContainer> {

  late HomeBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = context.read();
    bloc.eventSink.add(HomeEventFetchListFood());
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

