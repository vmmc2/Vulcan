// Vulcan is a software developed by:
// Victor Miguel de Morais Costa.
// License: MIT.
import 'package:flutter/material.dart';
import 'package:vulcan/components/responsive_widget.dart';
import 'package:vulcan/components/top_bar.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      largeScreen: Scaffold(
        backgroundColor: Color(0xFF02143D),
        appBar: TopBar(title: 'Opps.. An Error has occurred'),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Warning!!',
                style: TextStyle(
                  fontSize: 60.0,
                  fontFamily: 'Poppins',
                  color: Color(0xFF1CFDFC),
                ),
              ),
              Expanded(
                child: Text(
                  'Unfortunately, Vulcan is not a responsive Web App (yet).\n Please use it in full screen.',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Poppins',
                    color: Color(0xFF1CFDFC),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: Text(
                  'Infelizmente, Vulcan (ainda) não é um Web App responsivo.\n Por favor, use-o no modo tela cheia.',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Poppins',
                    color: Color(0xFF1CFDFC),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
