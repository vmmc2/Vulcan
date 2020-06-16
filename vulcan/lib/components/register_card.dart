// Vulcan is a software developed by:
// Victor Miguel de Morais Costa.
// License: MIT.
import 'package:flutter/material.dart';

class RegisterCard extends StatefulWidget {
  final String name;
  final String secondName;
  final String value;
  RegisterCard({@required this.name, @required this.secondName, @required this.value});

  @override
  _RegisterCardState createState() => _RegisterCardState();
}

class _RegisterCardState extends State<RegisterCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Color(0xFF02143D),
          width: 2.0,
        ),
        color: Color(0xFFCDE6F5),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                    color: Color(0xFF02143D),
                  ),
                ),
                Text(
                  widget.secondName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    color: Color(0xFF02143D),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              widget.value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15.0,
                color: Color(0xFF02143D),
              ),
            ),
          ),
          SizedBox(width: 20.0),
        ],
      ),
    );
  }
}
