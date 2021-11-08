import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'base_event.dart';

abstract class BaseBloc extends ChangeNotifier{
  final StreamController<BaseEvent> _eventStreamController = StreamController();
  final StreamController<bool> _loadingController = StreamController();
  final StreamController<BaseEvent> _progressController = BehaviorSubject();

  Stream<BaseEvent> get progressStream => _progressController.stream;
  Sink<BaseEvent> get progressSink => _progressController.sink;

  Sink<BaseEvent> get eventSink => _eventStreamController.sink;
  Stream<bool> get loadingStream => _loadingController.stream;
  Sink<bool> get loadingSink => _loadingController.sink;

  @override
  void dispose() {
    super.dispose();
    _eventStreamController.close();
    _loadingController.close();
    _progressController.close();
  }
}