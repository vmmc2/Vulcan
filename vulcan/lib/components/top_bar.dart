import 'package:flutter/material.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  TopBar({this.title});

  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
          leading: Container(),
          title: Text(
            title,
            style: TextStyle(
              color: Color(0xFF02143D),
              fontFamily: 'Poppins',
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Color(0xFF00AAFF),
                    Color(0xFF00BCBF),
                  ]
              ),
            ),
          ),
        );
  }
}