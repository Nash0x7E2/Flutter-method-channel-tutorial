import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

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
  static const platformMethodChannel = const MethodChannel('com.test/test');
  String nativeMessage = '';
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
              'Tap the button to change your life!',
              style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 23.0),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 102.0),
            child: new RaisedButton(
              child: new Text('Click Me'),
              onPressed: () => doNativeSuff(),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 102.0),
            child: new Text(
              nativeMessage,
              style: new TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 23.0),
            ),
          )
        ],
      ),
    );
  }

  Future<Null> doNativeSuff() async {
    String _message;
    // try {
    //   final String result =
    //       await platformMethodChannel.invokeMethod('changeLife');
    //   _message = result;
    //   print(result);
    // } on PlatformException catch (e) {
    //   _message = "Sadly I can not change your life: ${e.message}.";
    // }
    // setState(() {
    //     nativeMessage = _message;
    // });
    try {
      final String result =
          await platformMethodChannel.invokeMethod('vibrateDevice');
      _message = result;
      print(result);
    } on PlatformException catch (e) {
      _message = "Sadly I can not change your life: ${e.message}.";
    }
    setState(() {
      nativeMessage = _message;
    });
  }
}
