import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:speedometer/speedometer.dart';
import 'package:rxdart/rxdart.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'SpeedOMeter Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _lowerValue = 20.0;
  double _upperValue = 40.0;
  int start = 0;
  int end = 60;
  
  int counter = 0;
  
  PublishSubject<double> eventObservable = new PublishSubject();
  @override
  void initState() {
    super.initState();
    const oneSec = const Duration(seconds:1);
    var rng = new Random();
    new Timer.periodic(oneSec, (Timer t) => eventObservable.add(rng.nextInt(59)+rng.nextDouble()));
    
  }
  
  @override
  Widget build(BuildContext context) {
    
      return  new Scaffold(
          appBar: new AppBar(
              title: new Text("SpeedOMeter"),
             // bottom: new Text("SpeedOMeter"),
          ),
          body: new Column(
              children: <Widget>[
                  new Padding(
                      padding: new EdgeInsets.all(40.0),
                      child: new SpeedOMeter(start:start, end:end, highlightStart:(_lowerValue/end), highlightEnd:(_upperValue/end), eventObservable: this.eventObservable),
                  ),
              ],
          )
      );
  }
  
  
}