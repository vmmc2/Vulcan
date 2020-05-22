import 'package:flutter/material.dart';
import 'package:vulcan/screens/home.dart';
import 'package:vulcan/screens/editor.dart';
import 'package:vulcan/screens/simulator.dart';
import 'package:vulcan/screens/reference.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: '/', //Indica qual eh a pagina inicial. No caso eh a Home()
      routes: {
        '/' : (context) => Home(),  //Pagina Inicial
        '/editor' : (context) => Editor(), //Pagina do Editor
        '/simulator' : (context) => Simulator(), //Pagina do Simulador
        '/reference' : (context) => Reference(), //Pagina da Referencia/Orientacoes/Explicacoes sobre o ISA do RISC-V e sobre a arquitetura no geral.
      },
    );
  }
}
