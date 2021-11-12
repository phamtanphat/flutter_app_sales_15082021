import 'dart:async';
import 'package:flutter_app_sales_15082021/base/base_bloc.dart';
import 'package:flutter_app_sales_15082021/base/base_event.dart';
import 'package:flutter_app_sales_15082021/model/food_model.dart';
import 'package:flutter_app_sales_15082021/model/response_model.dart';
import 'package:flutter_app_sales_15082021/repository/food_repository.dart';
import 'package:flutter_app_sales_15082021/view/page/home/home_event.dart';

class HomeBloc extends BaseBloc{

  late FoodRepository _repository;

  HomeBloc();

  void updateFoodRepository(FoodRepository repository){
    this._repository = repository;
  }

  StreamController<List<FoodModel>> foodController = StreamController();

  @override
  void dispatch(BaseEvent event) {
    if (event is HomeEventFetchListFood){
      handleFetchListFood(event);
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

}