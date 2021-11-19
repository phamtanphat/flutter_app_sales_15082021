import 'package:flutter/material.dart';
import 'package:flutter_app_sales_15082021/base/base_widget.dart';
import 'package:flutter_app_sales_15082021/model/cart_model.dart';
import 'package:flutter_app_sales_15082021/model/food_model.dart';
import 'package:flutter_app_sales_15082021/model/order_model.dart';
import 'package:flutter_app_sales_15082021/repository/order_repository.dart';
import 'package:flutter_app_sales_15082021/request/order_request.dart';
import 'package:flutter_app_sales_15082021/view/page/cart/cart_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'cart_event.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: CartPageContainer(),
      providers: [
        Provider(create: (context) => OrderRequest()),
        ProxyProvider<OrderRequest, OrderRepository>(
          create: (context) => OrderRepository(),
          update: (context, request, repository) {
            repository!.updateOrderRequest(request);
            return repository;
          },
        ),
        ChangeNotifierProxyProvider<OrderRepository, CartBloc>(
          create: (context) => CartBloc(),
          update: (context, orderRepository, bloc) {
            bloc!.updateOrderRepo(orderRepository);
            return bloc;
          },
        )
      ],
      appBar: AppBar(
        title: Text("Cart"),
      ),
    );
  }
}

class CartPageContainer extends StatefulWidget {
  const CartPageContainer({Key? key}) : super(key: key);

  @override
  _CartPageContainerState createState() => _CartPageContainerState();
}

class _CartPageContainerState extends State<CartPageContainer> {
  late CartBloc bloc;
  String orderId = "";
  int total = 0;

  @override
  void didChangeDependencies() {
    if(ModalRoute.of(context)?.settings.arguments != null){
      orderId = (ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>)['orderId'];
    }

    bloc = context.read();
    bloc.eventSink.add(CartEventOrderDetail());

    bloc.resultController.stream.listen((event) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(event.toString())));
    });
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context,OrderModel(orderId: orderId,total: total));
        return Future.value(true);
      },
      child: StreamProvider.value(
        value: bloc.cartController.stream,
        initialData: null,
        child: Consumer<CartModel>(
          builder: (context, cartModel, child) {
            if (cartModel == null) {
              total = 0;
              return SizedBox();
            }
            total = 0;
            cartModel.items!.forEach((element) {
              total += element.quantity!;
            });
            return Container(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: cartModel.items!.length,
                        itemBuilder: (lstContext, index) =>
                            _buildItem(cartModel.items![index], context)),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Text(
                          "Tổng tiền : " +
                              NumberFormat("#,###", "en_US")
                                  .format(cartModel.total) +
                              " đ",
                          style: TextStyle(fontSize: 25, color: Colors.white))),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.deepOrange)),
                        child: Text("Confirm",
                            style: TextStyle(color: Colors.white, fontSize: 25)),
                      )),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem(FoodModel foodModel, BuildContext context) {
    return Container(
      height: 135,
      child: Card(
        elevation: 5,
        shadowColor: Colors.blueGrey,
        child: Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(foodModel.images![0].imageUrl!,
                      width: 150, height: 120, fit: BoxFit.fill),
                ),
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
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (foodModel.quantity! > 1) {
                                bloc.eventSink.add(CartEventOrderUpdate(
                                    orderId: orderId,
                                    foodId: foodModel.foodId!,
                                    quantity: foodModel.quantity!.toInt() - 1));
                              }
                            },
                            child: Text("-"),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(foodModel.quantity.toString(),
                                style: TextStyle(fontSize: 16)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              bloc.eventSink.add(CartEventOrderUpdate(
                                  orderId: orderId,
                                  foodId: foodModel.foodId!,
                                  quantity: foodModel.quantity!.toInt() + 1));
                            },
                            child: Text("+"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: IconButton(
                  icon: Icon(Icons.delete , color: Colors.red,),
                  onPressed: (){
                    bloc.eventSink.add(CartEventOrderDeleteItem(foodId: foodModel.foodId!));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
