import 'package:flutter_app_sales_15082021/base/base_event.dart';

abstract class HomeEventBase extends BaseEvent{

}

class HomeEventFetchListFood extends HomeEventBase{
  @override
  List<Object?> get props => [];

}

class HomeEventAddCart extends HomeEventBase{
  final String foodId;

  HomeEventAddCart({required this.foodId});

  @override
  List<Object?> get props => [];

}