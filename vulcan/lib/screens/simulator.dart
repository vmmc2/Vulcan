import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vulcan/components/responsive_widget.dart';
import 'package:vulcan/components/top_bar.dart';
import 'package:vulcan/components/action_bar.dart';
import 'package:vulcan/screens/error.dart';
import 'package:vulcan/utilities/instruction_card.dart';

List<String> teste = ['Teste', 'Para', 'Ver', 'Como', 'O', 'List', 'View', 'Funciona', 'Em', 'Detalhes','porra', 'caralho', 'misera','0','1','2','3','4','5','6','7','8','9'];
int number = 0;

class Simulator extends StatefulWidget {
  @override
  _SimulatorState createState() => _SimulatorState();
}

class _SimulatorState extends State<Simulator> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: MediaQuery.of(context).size.width >= 1200 ? ResponsiveWidget(
          largeScreen: Scaffold(
            backgroundColor: Color(0xFF02143D),
            appBar: TopBar(title: 'Simulator Page'),
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
                Expanded( //nao tinha esse Expanded() antes.
                  child: Row( //Nessa linha eu vou ter o status do simulador com as instrucoes executadas e a sua direita eu vou ter os registradores e a cache
                    children: <Widget>[
                      SizedBox(width: 20.0),
                      Column( //Primeira coluna, vai ficar o simulador.
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Simulator',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              color: Color(0xFFCDE6F5),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFCDE6F5),
                              ),
                              height: 535.0,
                              width: 980.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          'PC',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            color: Color(0xFF02143D),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          'Machine Code',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            color: Color(0xFF02143D),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Original Code',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            color: Color(0xFF02143D),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded( //Por algum motivo, para usar ListView ou ListView.builder dentro de um widget sem ser Scaffold tem que por ela dentro de um Expanded() antes.
                                    child: ListView.builder(
                                      padding: const EdgeInsets.all(8.0),
                                      itemCount: teste.length,
                                      itemBuilder: (BuildContext context, int index){
                                        return GestureDetector(
                                          onLongPress: () {},
                                          child: Container(
                                            margin: EdgeInsets.all(3.0),
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              color: index < 7 ? Colors.red : Color(0xFF00C4A7),
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            child: Text(
                                              '${teste[index]}',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Poppins',
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 20.0),
                      Column( //segunda coluna vai ficar os registradores e a memoria.
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Status',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20.0,
                                color: Color(0xFFCDE6F5),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFCDE6F5),
                                ),
                                height: 535.0,
                                width: 500.0,
                              ),
                            ),
                          ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ) : ErrorPage(),
      ),
    );
  }
}
