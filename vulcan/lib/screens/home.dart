import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:vulcan/components/top_bar.dart';
import 'package:vulcan/components/bottom_button.dart';
import 'package:path/path.dart';

const List<Color> orangeGradients = [
  Color(0xFFFF9844),
  Color(0xFFFE8853),
  Color(0xFFFD7267),
];


class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Container(
        child: Scaffold(
          backgroundColor: Color(0xFF02143D),
          appBar: TopBar(title: 'Home Page'),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                  height: 30.0,
                  child: Hero(
                    tag: 'tab_bar',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 14.0),
                        RotateAnimatedTextKit(
                          text: ['Vulcan'],
                          totalRepeatCount: 1000000,
                          textStyle: TextStyle(
                            color: Color(0xFF1CFDFC),
                            fontSize: 150.0,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Hero(
                          tag: 'logo',
                          child: Image(
                            width: 200.0,
                            image: AssetImage('assets/logo.png'),
                          ),
                        ),
                      ],
                    ),
                ),
                Text(
                    'A RISC-V Instruction Set Simulator',
                    style: TextStyle(
                      color: Color(0xFF1CFDFC),
                      fontSize: 60.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                Container(
                  width: 1010.0,
                  child: Divider(
                    height: 0.0,
                    thickness: 3.0,
                    color: Color(0xFF02142A),
                  ),
                ),
                Text(
                    'Built For Education',
                    style: TextStyle(
                      color: Color(0xFF1CFDFC),
                      fontSize: 60.0,
                      fontFamily: 'Poppins',
                    ),
                  ),
                Container(
                  width: 560.0,
                  child: Divider(
                    height: 0.0,
                    thickness: 3.0,
                    color: Color(0xFF02142A),
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(width: 15.0),
                    BottomButton(
                      title: 'GitHub',
                      url: 'https://github.com/vmmc2',
                      anotherTitle: 'GitHub Profile',
                    ),
                    SizedBox(width: 20.0),
                    BottomButton(
                      title: 'LinkedIn',
                      url: 'https://www.linkedin.com/in/victor-miguel-de-morais-costa-3200b6175/',
                      anotherTitle: 'LinkedIn Profile',
                    ),
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Developed by Victor Miguel de Morais Costa',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Color(0xFF1CFDFC),
                          fontSize: 12.0,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    SizedBox(width: 15.0),
                  ],
                ),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}