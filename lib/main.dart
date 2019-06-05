// Flutter code sample for material.FloatingActionButton.2

// This example shows how to make an extended [FloatingActionButton] in a
// [Scaffold], with a  pink [backgroundColor] and a thumbs up [Icon] and a
// [Text] label.

import 'package:flutter/material.dart';

import 'main_app.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget
{
  static const String _title = 'Stream Example';

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: _title,
      home: MainApp(),
    );
  }
}

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget
{
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text('Floating Action Button Sample'),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
        onPressed: () {
        },
      ),
      body: Material(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget> [
                ]
              )
            )
          ],
        )
      ),
    );
  }
}
