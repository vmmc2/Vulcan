// Vulcan is Software developed by:
// Victor Miguel de Morais Costa
// License: MIT
import 'package:flutter/material.dart';
import 'package:vulcan/components/responsive_widget.dart';
import 'package:vulcan/components/top_bar.dart';
import 'package:vulcan/components/action_bar.dart';
import 'package:vulcan/screens/error.dart';

class Reference extends StatefulWidget {
  @override
  _ReferenceState createState() => _ReferenceState();
}

class _ReferenceState extends State<Reference> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: MediaQuery.of(context).size.width >= 1200 ? ResponsiveWidget(
          largeScreen: Scaffold(
            backgroundColor: Color(0xFF02143D),
            appBar: TopBar(title: 'Reference Page'),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ActionBar(),
                Text(
                  'Please make sure to use the app in full screen.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15.0,
                    color: Color(0xFF1CFDFC),
                  ),
                ),
              ],
            ),
          ),
        ): ErrorPage(),
      ),
    );
  }
}
