import 'package:flutter/material.dart';

class StatusButton extends StatelessWidget {
  String name;
  double fSize;
  double wid;
  double hei;
  Function onPressed;
  Color backGroundColour;
  Color textColour;

  StatusButton({@required this.name, @required this.fSize, @required this.wid, @required this.hei, @required this.onPressed, @required this.backGroundColour, @required this.textColour});
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: hei,
        width: wid,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: backGroundColour,
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: fSize,
              color: textColour,
            ),
          ),
        ),
      ),
    );
  }
}
