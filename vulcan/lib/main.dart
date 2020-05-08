import 'package:flutter/material.dart';
import 'package:vulcan/screens/home.dart';
import 'package:vulcan/screens/editor.dart';
import 'package:vulcan/screens/simulator.dart';
import 'package:vulcan/screens/reference.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => Home(),
        '/editor' : (context) => Editor(),
        '/simulator' : (context) => Simulator(),
        '/reference' : (context) => Reference(),
      },
    );
  }
}
