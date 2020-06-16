// Vulcan is a software developed by:
// Victor Miguel de Morais Costa.
// License: MIT.
import 'package:flutter/material.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(width: 15.0),
        Text(
          'Vulcan',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 70.0,
            color: Color(0xFF1CFDFC),
          ),
        ),
        SizedBox(width: 10.0),
        Hero(
          tag: 'logo',
          child: Image(
            height: 75.0,
            width: 75.0,
            image: AssetImage('assets/logo.png'),
          ),
        ),
        //SizedBox(width: 650.0),
        Expanded(
          child: Container(
            //margin: EdgeInsets.fromLTRB(650, 0, 0, 0), nao tava comentado
            child: Hero(
              tag: 'tab_bar',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(width: 10.0),
                  RaisedButton.icon(
                    onPressed: () {
                      //Checagem para ver se eu nao estou tentando
                      //ir para a mesma pagina que estou no momento
                      //Se eu estiver querendo ir para uma pagina na
                      //qual eu ja estou, nao faco nada.
                      var rout = ModalRoute.of(context);
                      if(rout != null){
                        if(rout.settings.name == '/') return;
                        else{
                          Navigator.pushNamed(context, '/');
                          return;
                        };
                      }
                    },
                    elevation: 15.0,
                    icon: Icon(
                      Icons.home,
                      color: Color(0xFF1CFDFC),
                      size: 15.0,
                    ),
                    label: Text(
                      'Home',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF1CFDFC)
                      ),
                    ),
                    color: Color(0xFF22007C),
                    hoverColor: Color(0xFF134074),
                    highlightElevation: 5.0,
                  ),
                  SizedBox(width: 15.0),
                  RaisedButton.icon(
                    onPressed: () {
                      var rout = ModalRoute.of(context);
                      if(rout != null){
                        if(rout.settings.name == '/editor') return;
                        else{
                          Navigator.pushNamed(context, '/editor');
                          return;
                        };
                      }
                    },
                    elevation: 15.0,
                    icon: Icon(
                      Icons.edit,
                      color: Color(0xFF1CFDFC),
                      size: 15.0,
                    ),
                    label: Text(
                      'Editor',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF1CFDFC)
                      ),
                    ),
                    color: Color(0xFF22007C),
                    hoverColor: Color(0xFF134074),
                    highlightElevation: 5.0,
                  ),
                  SizedBox(width: 15.0),
                  RaisedButton.icon(
                    onPressed: () {
                      var rout = ModalRoute.of(context);
                      if(rout != null){
                        if(rout.settings.name == '/simulator') return;
                        else{
                          Navigator.pushNamed(context, '/simulator');
                          return;
                        };
                      }
                    },
                    elevation: 15.0,
                    icon: Icon(
                      Icons.computer,
                      color: Color(0xFF1CFDFC),
                      size: 15.0,
                    ),
                    label: Text(
                      'Simulator',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF1CFDFC),
                      ),
                    ),
                    color: Color(0xFF22007C),
                    hoverColor: Color(0xFF134074),
                    highlightElevation: 5.0,
                  ),
                  SizedBox(width: 15.0),
                  RaisedButton.icon(
                    onPressed: () {
                      var rout = ModalRoute.of(context);
                      if(rout != null){
                        if(rout.settings.name == '/reference') return;
                        else{
                          Navigator.pushNamed(context, '/reference');
                          return;
                        };
                      }
                    },
                    elevation: 15.0,
                    icon: Icon(
                      Icons.library_books,
                      color: Color(0xFF1CFDFC),
                      size: 15.0,
                    ),
                    label: Text(
                      'Reference',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF1CFDFC),
                      ),
                    ),
                    color: Color(0xFF22007C),
                    hoverColor: Color(0xFF134074),
                    highlightElevation: 5.0,
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
