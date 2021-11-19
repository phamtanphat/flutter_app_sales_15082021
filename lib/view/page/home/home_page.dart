
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sales_15082021/base/base_widget.dart';
import 'package:flutter_app_sales_15082021/common/share_pref.dart';
import 'package:flutter_app_sales_15082021/model/food_model.dart';
import 'package:flutter_app_sales_15082021/model/order_model.dart';
import 'package:flutter_app_sales_15082021/repository/food_repository.dart';
import 'package:flutter_app_sales_15082021/repository/order_repository.dart';
import 'package:flutter_app_sales_15082021/request/food_request.dart';
import 'package:flutter_app_sales_15082021/request/order_request.dart';
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
          Provider(create: (context) => OrderRequest()),
          ProxyProvider<FoodRequest, FoodRepository>(
            create: (context) => FoodRepository(),
            update: (context, request, repository) {
              repository!.updateFoodRequest(request);
              return repository;
            },
          ),
          ProxyProvider<OrderRequest, OrderRepository>(
            create: (context) => OrderRepository(),
            update: (context, request, repository) {
              repository!.updateOrderRequest(request);
              return repository;
            },
          ),
          ChangeNotifierProxyProvider2<FoodRepository , OrderRepository, HomeBloc>(
            create: (context) => HomeBloc(),
            update: (context, foddRepository , orderRepository , bloc) {
              bloc!.updateFoodRepository(foddRepository);
              bloc.updateOrderRepository(orderRepository);
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
    bloc.eventSink.add(HomeEventGetTotalCount());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: (){
            SPref.instance.clearSPref();
            Navigator.pushReplacementNamed(context, "/sign-in");
          },
        ),
        title: const Text("Food"),
        actions: [
          StreamProvider.value(
              value: bloc.orderModelController.stream,
              initialData: OrderModel(orderId: "", total: 0),
              child: Consumer<OrderModel>(
                builder: (context , orderModel , child){
                    if (orderModel.total! > 0){
                      return Container(
                        margin: const EdgeInsets.only(right: 10, top: 5),
                        child: Badge(
                            padding: const EdgeInsets.all(10),
                            badgeContent: Text(orderModel.total!.toString(),
                                style: TextStyle(fontSize: 15, color: Colors.white)),
                            child: IconButton(
                                icon: const Icon(Icons.shopping_cart), onPressed: () async {
                                  var orderModelResult = await Navigator.pushNamed(context, "/cart", arguments: {"orderId" : orderModel.orderId});
                                  if (orderModelResult != null && (orderModelResult as OrderModel).orderId!.isNotEmpty ){
                                    bloc.orderModelController.sink.add(orderModelResult);
                                  }
                            })),
                      );
                    }
                    return Container(
                      margin: const EdgeInsets.only(right: 10, top: 5),
                      child: IconButton(
                          icon: const Icon(Icons.shopping_cart), onPressed: () {
                        Navigator.pushNamed(context, "/cart" );
                      }),
                    );
                },
              )
              ),
        ],
      ),
      body: ContainerListenerWidget<HomeBloc>(
        callback: (event) {},
        child: LoadingWidget(
          bloc: bloc,
          child: StreamProvider.value(
            initialData: null,
            value: bloc.foodController.stream,
            child: Consumer<List<FoodModel>>(
              builder: (context, list, child) {
                if (list == null){
                  return const SizedBox();
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
    );
  }

  Widget _buildItemFood(FoodModel foodModel) {
    return SizedBox(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: const EdgeInsets.only(top: 5, bottom: 5),
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
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Text(
                          "Giá : " +
                              NumberFormat("#,###", "en_US")
                                  .format(foodModel.price) +
                              " đ",
                          style: const TextStyle(fontSize: 12)),
                      ElevatedButton(
                        onPressed: () {
                          bloc.eventSink
                              .add(HomeEventAddCart(foodId: foodModel.foodId!));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromARGB(200, 240, 102, 61);
                              } else {
                                return const Color.fromARGB(230, 240, 102, 61);
                              }
                            }),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))))),
                        child:
                            const Text("Add To Cart", style: TextStyle(fontSize: 14)),
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

