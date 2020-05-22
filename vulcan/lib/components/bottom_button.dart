import 'package:flutter/material.dart';
import 'dart:html' as html;

class BottomButton extends StatelessWidget {
  final String title;
  final String url;
  final String anotherTitle;

  BottomButton({@required this.title, this.url, this.anotherTitle});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        html.window.open(url, anotherTitle);
      },
      elevation: 20.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Color(0xFF02143D),
        ),
      ),
      color: Color(0xFF1CFDFC),
      hoverColor: Color(0xFF78E0DC),
      hoverElevation: 5.0,
    );
  }
}
//
