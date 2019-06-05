import 'dart:async';

void execute() async
{
  final ex = MyClass();
  final counterStream = ex.timedCounter(const Duration(seconds: 1), 15);
  await Future.delayed(const Duration(seconds: 5));

  // after 5 seconds, add a listener
  await for (int n in counterStream)
  {
    print(n);
  }
}

void listenWithPause()
{
  final maxCount = 15;
  var counterStream = timedCounter(const Duration(seconds: 1), maxCount);
  StreamSubscription<int> subscription;

  subscription = counterStream.listen((int counter)
  {
    print(counter); // Print an integer every second.
    if (counter == 5)
    {
      // After 5 ticks, pause for five seconds, then resume.
      subscription.pause(Future.delayed(const Duration(seconds: 5)));
    }
    if (counter == maxCount)
    {
      subscription.cancel();
    }
  });
}

/// dart's solution!
Stream<int> timedCounter(Duration interval, [int maxCount])
{
  StreamController<int> controller;
  Timer timer;
  int counter = 0;

  void tick(_)
  {
    counter++;
    controller.add(counter); // Ask stream to send counter values as event.
    if (counter == maxCount)
    {
      timer.cancel();
      controller.close(); // Ask stream to shut down and tell listeners.
    }
  }

  void startTimer()
  {
    timer = Timer.periodic(interval, tick);
  }

  void stopTimer()
  {
    if (timer != null)
    {
      timer.cancel();
      timer = null;
    }
  }

  controller = StreamController<int>(
      onListen: startTimer,
      onPause: stopTimer,
      onResume: startTimer,
      onCancel: stopTimer);

  return controller.stream;
}


/// Thomas's solution
class MyClass
{
  // ignore: close_sinks
  StreamController<int> controller;
  int _counter = 0;
  int _maxCount = 0;
  Duration _interval;
  Timer _timer;

  MyClass()
  {
    controller = StreamController<int>(onListen: _listener, onPause: _pause, onResume: _listener, onCancel: _pause);
  }

  Stream<int> timedCounter(Duration interval, [int maxCount])
  {
    _interval = interval;
    _maxCount = maxCount;
    return controller.stream;
  }

  void _tick(_)
  {
    _counter++;
    controller.add(_counter); // ask stream to send counter values as event
    if (_maxCount != null && _counter >= _maxCount)
    {
      _timer.cancel();
      controller.close(); // ask stream to shut down
    }
  }

  void _listener()
  {
    _timer = Timer.periodic(_interval, _tick);
  }

  void _pause()
  {
    _timer?.cancel();
    _timer = null;
  }
}
