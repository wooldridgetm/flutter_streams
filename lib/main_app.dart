import 'dart:math';

import 'package:flutter/material.dart';
import "package:random_string/random_string.dart";
import 'package:rxdart/rxdart.dart';
import 'package:streams_ex1/presenter.dart';

/// This is the stateless widget that the main application instantiates.
class MainApp extends StatefulWidget
{
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp>
{
  final Presenter streamsBloc = Presenter();

  @override
  void dispose()
  {
    streamsBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return StreamBuilder<StreamsBlocViewModel>(
        initialData: StreamsBlocViewModel(0, ""),
        stream: Observable.combineLatest2(
            streamsBloc.stream1,
            streamsBloc.stream2,
                (counter, message) => StreamsBlocViewModel(counter, message)
        ),
        builder: (BuildContext context, AsyncSnapshot<StreamsBlocViewModel> snapshot) {

          return Scaffold(
            appBar: AppBar(title: Text('Streams')),
            body: Material(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Counter: ${snapshot.data.counter}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 45),
                      Text("Message: ${snapshot.data.message}", style: TextStyle(fontSize: 20, color: Colors.black)),
                    ],
                  ),
                )
            ),
            floatingActionButton: _buildFab(),
          );
        }
    );
  }

  Widget _buildFab()
  {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.pink,
      onPressed: () {
        streamsBloc.sink1.add(randomBetween(-12356, 926661341));
        streamsBloc.sink2.add(randomString(25));
      },
    );
  }
}

