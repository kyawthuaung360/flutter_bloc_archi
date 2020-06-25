

import 'dart:async';
import 'dart:developer';

import 'package:flutterblocarchi/networks/enum/MsgState.dart';



class CounterBloc{
  int _counter = 0;

  final _counterController = StreamController<int>();
  StreamSink<int> get _incrementCounter => _counterController.sink;
  Stream<int> get counter => _counterController.stream;


  final _counterEventcontroller = StreamController<CounterState>();
  Sink<CounterState> get counterEventSink => _counterEventcontroller.sink;

  CounterBloc(){
    _counterEventcontroller.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterState event){
    if(event == CounterState.increment)
      _counter++;
    else
      _counter--;
    _incrementCounter.add(_counter);
  }

  void dispose(){
    _counterController.close();
    _counterEventcontroller.close();
  }

}