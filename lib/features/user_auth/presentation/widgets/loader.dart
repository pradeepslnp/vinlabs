import 'package:demo_app/constants/appconstants.dart';
import 'package:flutter/material.dart';

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              const CircularProgressIndicator(
                  strokeWidth: 4.0, color: Colors.blue),
              Container(
                  padding: EdgeInsets.all(screenWidth * 8),
                  child: Text('Please Wait',
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: fontSize * 18)))
            ])));
  }
}
