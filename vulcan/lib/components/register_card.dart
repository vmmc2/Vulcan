import 'package:flutter/material.dart';

class RegisterCard extends StatefulWidget {
  final String name;
  final String secondName;
  RegisterCard({@required this.name, @required this.secondName});

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
            child: TextField(),
          ),
          SizedBox(width: 20.0),
        ],
      ),
    );
  }
}
