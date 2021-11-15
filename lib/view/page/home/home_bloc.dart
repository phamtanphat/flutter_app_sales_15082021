import 'dart:async';
import 'package:flutter_app_sales_15082021/base/base_bloc.dart';
import 'package:flutter_app_sales_15082021/base/base_event.dart';
import 'package:flutter_app_sales_15082021/model/food_model.dart';
import 'package:flutter_app_sales_15082021/model/order_model.dart';
import 'package:flutter_app_sales_15082021/model/response_model.dart';
import 'package:flutter_app_sales_15082021/repository/food_repository.dart';
import 'package:flutter_app_sales_15082021/repository/order_repository.dart';
import 'package:flutter_app_sales_15082021/view/page/home/home_event.dart';

class HomeBloc extends BaseBloc{

  late FoodRepository _repository;
  late OrderRepository _orderRepository;

  HomeBloc();

  void updateFoodRepository(FoodRepository repository){
    this._repository = repository;
  }
  void updateOrderRepository(OrderRepository orderRepository) {
    _orderRepository = orderRepository;
  }

  StreamController<List<FoodModel>> foodController = StreamController();
  StreamController<OrderModel> orderModelController = StreamController();

  @override
  void dispatch(BaseEvent event) {
    if (event is HomeEventFetchListFood){
      handleFetchListFood(event);
    }else if(event is HomeEventAddCart){
      handleAddCart(event);
    }else if(event is HomeEventGetTotalCount){
      handleTotalCount(event);
    }
  }

  void handleFetchListFood(HomeEventFetchListFood event) async{
    loadingSink.add(true);
    try{
      ResponseModel<List<FoodModel>> response = await _repository.fetchListFood();
      foodController.sink.add(response.data!);
    }catch(e){
      foodController.sink.addError(e.toString());
    }finally{
      loadingSink.add(false);
    }
  }

  @override
  void dispose() {
    orderModelController.close();
    foodController.close();
    super.dispose();
  }

  void handleAddCart(HomeEventAddCart event) async{
    loadingSink.add(true);
    try {
      OrderModel orderModel = await _orderRepository.addFoodToCart(event.foodId);
      if (orderModel.orderId != null){
        eventSink.add(HomeEventGetTotalCount());
      }
    } catch (e) {
      orderModelController.sink.addError(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }

  void handleTotalCount(HomeEventGetTotalCount event) async{
    loadingSink.add(true);
    try {
      OrderModel orderModel = await _orderRepository.getTotalCount();
      orderModelController.sink.add(orderModel);
    } catch (e) {
      orderModelController.sink.addError(e.toString());
    } finally {
      loadingSink.add(false);
    }
  }

}