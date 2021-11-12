import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sales_15082021/base/base_widget.dart';
import 'package:flutter_app_sales_15082021/model/food_model.dart';
import 'package:flutter_app_sales_15082021/repository/food_repository.dart';
import 'package:flutter_app_sales_15082021/request/food_request.dart';
import 'package:flutter_app_sales_15082021/view/page/home/home_bloc.dart';
import 'package:flutter_app_sales_15082021/view/page/home/home_event.dart';
import 'package:flutter_app_sales_15082021/view/widget/container_listener_widget.dart';
import 'package:flutter_app_sales_15082021/view/widget/loading_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
        child: HomePageContainer(),
        providers: [
          Provider(create: (context) => FoodRequest()),
          ProxyProvider<FoodRequest, FoodRepository>(
            create: (context) => FoodRepository(),
            update: (context, request, repository) {
              repository!.updateFoodRequest(request);
              return repository;
            },
          ),
          ChangeNotifierProxyProvider<FoodRepository, HomeBloc>(
            create: (context) => HomeBloc(),
            update: (context, repository, bloc) {
              bloc!.updateFoodRepository(repository);
              return bloc;
            },
          )
        ]);
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Food"),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10, top: 5),
            child: Badge(
                padding: EdgeInsets.all(10),
                badgeContent: Text("0",
                    style: TextStyle(fontSize: 15, color: Colors.white)),
                child: IconButton(
                    icon: Icon(Icons.shopping_cart), onPressed: () {})),
          )
        ],
      ),
      body: ContainerListenerWidget<HomeBloc>(
        callback: (event) {},
        child: LoadingWidget(
          bloc: bloc,
          child: Container(
            child: StreamProvider.value(
              initialData: null,
              value: bloc.foodController.stream,
              child: Consumer<List<FoodModel>>(
                builder: (context, list, child) {
                  if (list == null) {
                    return SizedBox();
                  }
                  return ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return _buildItemFood(list[index]);
                      });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemFood(FoodModel foodModel) {
    return Container(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(foodModel.images![0].imageUrl!,
                    width: 150, height: 120, fit: BoxFit.fill),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(foodModel.foodName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US")
                                  .format(foodModel.price) +
                              " đ",
                          style: TextStyle(fontSize: 12)),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Color.fromARGB(200, 240, 102, 61);
                              } else {
                                return Color.fromARGB(230, 240, 102, 61);
                              }
                            }),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                        child:
                            Text("Add To Cart", style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
