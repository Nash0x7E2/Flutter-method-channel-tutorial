import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      body: new PlatformTestBody(),
    ),
  ));
}

class PlatformTestBody extends StatefulWidget {
  @override
  PlatformTestBodyState createState() {
    return new PlatformTestBodyState();
  }
}

class PlatformTestBodyState extends State<PlatformTestBody> {
  static const platform =
      const MethodChannel('com.example.flutternativetut/vibration');
  String duration;
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.pinkAccent,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(left: 18.0, top: 200.0),
            child: new Text(
              'Tap the button to vibrate your device',
              style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 23.0),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 102.0),
            child: new RaisedButton(
              child: new Text('Clicky for vibration'),
              onPressed: () => _vibratePhone(),
            ),
          )
        ],
      ),
    );
  }

  Future<String> _vibratePhone() async {
    String message;

    try {
      message = await platform.invokeMethod('vibrateDevice');
    } on PlatformException catch (e) {
      print(e);
    }
    return message;
  }
}
