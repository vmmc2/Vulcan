import 'package:flutter/material.dart';
import 'package:vulcan/components/top_bar.dart';
import 'package:vulcan/components/action_bar.dart';

class Simulator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF02143D),
        appBar: TopBar(title: 'Simulator Page'),
        body: Column(
          children: <Widget>[
            ActionBar(),
          ],
        ),
      ),
    );
  }
}
