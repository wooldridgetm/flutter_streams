import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Presenter
{
  StreamController<int> _controller1 = PublishSubject<int>();
  StreamController<String> _controller2 = PublishSubject<String>();
  
  Sink<int> get sink1 => _controller1.sink;
  Stream<int> get stream1 => _controller1.stream;
  
  Sink<String> get sink2 => _controller2.sink;
  Stream<String> get stream2 => _controller2.stream;

  StreamSubscription _sub1;
  StreamSubscription _sub2;

  /// CONSTRUCTOR
  Presenter() 
  {
    _controller1.add(1);

//    _sub1 = stream1.listen(_listener1);
//    _sub2 = stream2.listen(_listener2);
  }

  void dispose()
  {
    _sub1?.cancel();
    _sub2?.cancel();

    _controller1.close();
    _controller2.close();
  }

  void _listener1(int counter)
  {
    print("controller1.stream $counter");
  }
  void _listener2(String msg)
  {
    print("controller2.stream $msg");
  }
}

class StreamsBlocViewModel
{
  final int counter;
  final String message;

  StreamsBlocViewModel(this.counter, this.message);
}