// Vulcan is Software developed by:
// Victor Miguel de Morais Costa
// License: MIT
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vulcan/components/responsive_widget.dart';
import 'package:vulcan/components/top_bar.dart';
import 'package:vulcan/components/action_bar.dart';
import 'package:vulcan/screens/error.dart';
import 'package:vulcan/utilities/instruction_card.dart';
import 'package:vulcan/components/status_button.dart';
import 'package:vulcan/components/register_card.dart';
import 'package:vulcan/components/floating_register_list.dart';
import 'package:vulcan/components/integer_register_list.dart';
import 'package:vulcan/utilities/assembler.dart';
import 'package:vulcan/utilities/processor.dart';

List<String> teste = ['Teste', 'Para', 'Ver', 'Como', 'O', 'List', 'View', 'Funciona', 'Em', 'Detalhes','porra', 'caralho', 'misera','0','1','2','3','4','5','6','7','8','9'];
int number = 0;

const kColumnStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 16.0,
  color: Color(0xFF02143D),
);

const kRowStyle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 14.0,
  color: Color(0xFF02143D),
);

//variaveis que serao usadas para controlar o painel de status
enum MajorStatus{register, memory}
enum TypeRegister{integer, floating}
Assembler assembler;
Processor processor;

class Simulator extends StatefulWidget {
  String codeWritten; //Lembrando que quando eu crio uma variavel sem atribuir nenhum valor a ela. Ela fica com o valor "null".

  Simulator({this.codeWritten});

  @override
  _SimulatorState createState() => _SimulatorState();
}

class _SimulatorState extends State<Simulator> {
  MajorStatus currentStatus = MajorStatus.register;
  TypeRegister cStatus = TypeRegister.integer;
  String dropdownValue = ' Text';

  @override
  void initState(){
    super.initState();
    //Agora vamos criar uma instancia do Assembler para comecar a simulacao
    assembler = Assembler(inputDocument: widget.codeWritten);
    //Ja crio uma instancia do processador para executar as instrucoes depois de carrega-las em seu formato binario na memoria do processador.
    processor = Processor();

    //Aqui dentro do initState() eu vou fazer o processamento do assembler.
    //Primeira coisa: Checar de onde eu estou vindo quando chego na tela do Simulator
    if(widget.codeWritten == "" || widget.codeWritten == null){ //Quer dizer que eu nao tava na tela do Editor antes de chegar na tela do Simulator. Logo, nao tem o que simular.
      return;
    }else{ //Caso contrario. Eu vim da tela do Editor e de fato tem que coisa para simular.

      //Aqui embaixo, pegamos a String inteira e separamos ela por '\n'.
      //Dessa forma, a gente obtem uma List de Strings. Na qual cada String representa uma instrucao.
      List<String> result = assembler.generateInstruction();
      //Feito. Segunda parte... Remover os elementos da List que sao: Linhas em branco ou linhas que ja comecam com comentarios...
      result = assembler.eliminateEmptyLinesAndComments(result);
      /*
      for(String line in result){
        print(line);
      }
      */
      print("------------------------------------------------------------------------------------------------------------------");
      //Quarta Parte: Passar essa lista com apenas as linas de codigo validas, para realizarmos um parsing e um tokenize
      List<List<String>> tokensPerLine = assembler.tokenize(result);
      
      tokensPerLine = assembler.removeEmptyLists(tokensPerLine);
      tokensPerLine = assembler.removeFirstTab(tokensPerLine);
      for(int i = 0; i < tokensPerLine.length; i++){
        print(tokensPerLine[i]);
      }

      //A gente agora vai identificar o enderenco de todas as labels.
      Map<String,int> labelsAddress = assembler.findLabelsAddress(tokensPerLine);
      //print(labelsAddress);
      //Ate aqui em cima tudo ok.

      //Quinta Parte: Agora vamos gerar o codigo de maquina para ser carregado na memoria...
      List<String> machineCode = assembler.generateMachineCode(tokensPerLine, labelsAddress); //O PROBLEMA TA AQUI.

      //Sexta Parte: Feito isso, chegou a hora de carregar o codigo binario (codigo de maquina no processador)
      processor.loadInstructionsInMemory(machineCode);
      //Setima Parte: Com as instrucoes carregadas, iniciamos a simulacao, execucao.
      processor.executeInstructions(labelsAddress);
    }
  }

  Widget putData(MajorStatus currentStatus, TypeRegister cStatus){
    if(currentStatus == MajorStatus.memory){
      return MemoryView();
    }else if(currentStatus == MajorStatus.register && cStatus == TypeRegister.integer){
      return IntegerRegisterList(processor.integerRegisters);
    }else if(currentStatus == MajorStatus.register && cStatus == TypeRegister.floating){
      return FloatingRegisterList();
    }
  }

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
                              width: 930.0, //tava 980.0 antes
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
                                  SizedBox(
                                    height: 0.5,
                                    width: 980.0,
                                    child: Divider(
                                      color: Color(0xFF02143D),
                                      thickness: 2.0,
                                    ),
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
                                width: 540.0,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        StatusButton(name: 'Registers', fSize: 16.0, hei: 32.0, wid: 100.0,
                                          backGroundColour: currentStatus == MajorStatus.register ? Color(0xFF02143D) : Color(0xFFCDE6F5),
                                          textColour: currentStatus == MajorStatus.register ? Color(0xFFCDE6F5) : Color(0xFF02143D),
                                          onPressed: () {
                                            setState(() {
                                              currentStatus = MajorStatus.register;
                                            });
                                          },
                                        ),
                                        SizedBox(width: 20.0),
                                        StatusButton(name: 'Memory', fSize: 16.0, hei: 32.0, wid: 100.0,
                                          backGroundColour: currentStatus == MajorStatus.memory ? Color(0xFF02143D) : Color(0xFFCDE6F5),
                                          textColour: currentStatus == MajorStatus.memory ? Color(0xFFCDE6F5) : Color(0xFF02143D),
                                            onPressed: () {
                                            setState(() {
                                              currentStatus = MajorStatus.memory;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        StatusButton(name: 'Integer (I)', fSize: 12.0, hei: 25.0, wid: 80.0,
                                          backGroundColour: (currentStatus == MajorStatus.register) && (cStatus == TypeRegister.integer)? Color(0xFF02143D) : Color(0xFFCDE6F5),
                                          textColour: (currentStatus == MajorStatus.register) && (cStatus == TypeRegister.integer)? Color(0xFFCDE6F5) : Color(0xFF02143D),
                                          onPressed: () {
                                            if(currentStatus != MajorStatus.register) return;
                                            setState(() {
                                              cStatus = TypeRegister.integer;
                                            });
                                          },
                                        ),
                                        SizedBox(width: 20.0),
                                        StatusButton(name: 'Floating (F)', fSize: 12.0, hei: 25.0, wid: 80.0,
                                          backGroundColour: (currentStatus == MajorStatus.register) && (cStatus == TypeRegister.floating)? Color(0xFF02143D) : Color(0xFFCDE6F5),
                                          textColour: (currentStatus == MajorStatus.register) && (cStatus == TypeRegister.floating)? Color(0xFFCDE6F5) : Color(0xFF02143D),
                                          onPressed: () {
                                            if(currentStatus != MajorStatus.register) return;
                                            setState(() {
                                              cStatus = TypeRegister.floating;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.0),
                                    SizedBox(
                                      height: 0.5,
                                      width: 540.0,
                                      child: Divider(
                                        color: Color(0xFF02143D),
                                        thickness: 2.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: putData(currentStatus, cStatus),
                                    ),
                                  ],
                                ),
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

class MemoryView extends StatefulWidget { //Widget stateful responsavel por mostrar o status da memoria e por se movimentar atraves dela...
  List<int> memory = new List<int>.generate(1000000, (int index) => index); //inicializar e memoria como privada porque nao tem logica o cara se capaz de mudar ela diretamente...
  int cursor = 0; //vai servir para me guiar na horar de ir mudando de list em list.
  String dropdownValue = ' Text';
  Map memorySegments = <String, int>{
    ' Text' : 400,
    ' Data': 200400,
    ' Heap': 400400,
    ' Stack': 999992,
  };

  @override
  _MemoryViewState createState() => _MemoryViewState();
}

class _MemoryViewState extends State<MemoryView> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: <Widget>[
              SizedBox(width: 10.0),
              Text(
                'Memory Segment:',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  color: Color(0xFF02143D),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Color(0xFF02143D),
                    width: 1.0,
                  ),
                ),
                child: DropdownButton<String>(
                  value: widget.dropdownValue,
                  dropdownColor: Color(0xFFCDE6F5),
                  icon: Icon(
                    Icons.arrow_downward,
                    color: Color(0xFF02143D),
                  ),
                  iconSize: 20,
                  elevation: 16,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    color: Color(0xFF02143D),
                  ),
                  underline: Container(
                    height: 0,
                    color: Color(0xFF02143D),
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      widget.dropdownValue = newValue;
                      widget.cursor = widget.memorySegments[widget.dropdownValue];
                    });
                  },
                  items: <String>[' Text', ' Data', ' Heap', ' Stack']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(width: 110.0),
              Container(
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Color(0xFF02143D),
                    width: 1.0,
                  ),
                ),
                child: FlatButton(
                  onPressed: () {
                    if(widget.cursor == 0) return;
                    else{
                      setState(() {
                        if(widget.cursor - 28 < 0){
                          widget.cursor = 0;
                        } else {
                          widget.cursor -= 28;
                        }
                      });
                    }
                  },
                  color: Color(0xFFCDE6F5),
                  child: Text(
                    'Up',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Color(0xFF02143D),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: Color(0xFF02143D),
                    width: 1.0,
                  ),
                ),
                child: FlatButton(
                  onPressed: () {
                    if(widget.cursor == 999992) return;
                    else{
                      setState(() {
                        if(widget.cursor + 28 > 999992){
                          widget.cursor = 999992;
                        }else {
                          widget.cursor += 28;
                        }
                      });
                    }
                  },
                  color: Color(0xFFCDE6F5),
                  child: Text(
                    'Down',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Color(0xFF02143D),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Expanded(
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Address',
                    style: kColumnStyle,
                  ),
                ),
                DataColumn(
                  label: Text(
                    '+3',
                    style: kColumnStyle,
                  ),
                ),
                DataColumn(
                  label: Text(
                    '+2',
                    style: kColumnStyle,
                  ),
                ),
                DataColumn(
                  label: Text(
                    '+1',
                    style: kColumnStyle,
                  ),
                ),
                DataColumn(
                  label: Text(
                    '+0',
                    style: kColumnStyle,
                  ),
                ),
              ],
              rows: [
                DataRow(
                    cells: [
                      DataCell(Text('0', style: kRowStyle)),
                      DataCell(Text('${widget.memory[widget.cursor + 3]}', style: kRowStyle)),
                      DataCell(Text('${widget.memory[widget.cursor + 2]}', style: kRowStyle)),
                      DataCell(Text('${widget.memory[widget.cursor + 1]}', style: kRowStyle)),
                      DataCell(Text('${widget.memory[widget.cursor + 0]}', style: kRowStyle)),
                    ]
                ),
                DataRow(
                    cells: [
                      DataCell(Text('1', style: kRowStyle)),
                      DataCell(Text('${widget.memory[widget.cursor + 7]}', style: kRowStyle)),
                      DataCell(Text('${widget.memory[widget.cursor + 6]}', style: kRowStyle)),
                      DataCell(Text('${widget.memory[widget.cursor + 5]}', style: kRowStyle)),
                      DataCell(Text('${widget.memory[widget.cursor + 4]}', style: kRowStyle)),
                    ]
                ),
                DataRow(
                    cells: [
                      DataCell(Text('2', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 11]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 10]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 9]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 8]}' : '--', style: kRowStyle)),
                    ]
                ),
                DataRow(
                    cells: [
                      DataCell(Text('3', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 15]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 14]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 13]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 12]}' : '--', style: kRowStyle)),
                    ]
                ),
                DataRow(
                    cells: [
                      DataCell(Text('4', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 19]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 18]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 17]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 16]}' : '--', style: kRowStyle)),
                    ]
                ),
                DataRow(
                    cells: [
                      DataCell(Text('5', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 23]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 22]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 21]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 20]}' : '--', style: kRowStyle)),
                    ]
                ),
                DataRow(
                    cells: [
                      DataCell(Text('6', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 27]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 26]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 25]}' : '--', style: kRowStyle)),
                      DataCell(Text(widget.cursor != 999992 ?'${widget.memory[widget.cursor + 24]}' : '--', style: kRowStyle)),
                    ]
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



/*
Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Memory Segment:',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    color: Color(0xFF02143D),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  height: 30.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Color(0xFF02143D),
                      width: 1.0,
                    ),
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    dropdownColor: Color(0xFFCDE6F5),
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 20,
                    elevation: 16,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.0,
                      color: Color(0xFF02143D),
                    ),
                    underline: Container(
                      height: 0,
                      color: Color(0xFF02143D),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[' Text', ' Data', ' Heap', ' Stack']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: 90.0),
                Container(
                  height: 30.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Color(0xFF02143D),
                      width: 1.0,
                    ),
                  ),
                  child: FlatButton(
                    onPressed: () {},
                    color: Color(0xFFCDE6F5),
                    child: Text(
                      'Up',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Color(0xFF02143D),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  height: 30.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Color(0xFF02143D),
                      width: 1.0,
                    ),
                  ),
                  child: FlatButton(
                    onPressed: () {},
                    color: Color(0xFFCDE6F5),
                    child: Text(
                      'Down',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        color: Color(0xFF02143D),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Expanded(
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'Address',
                      style: kColumnStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '+3',
                      style: kColumnStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '+2',
                      style: kColumnStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '+1',
                      style: kColumnStyle,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '+0',
                      style: kColumnStyle,
                    ),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text('Dale', style: kRowStyle)),
                      DataCell(Text('Porra', style: kRowStyle)),
                      DataCell(Text('Dale', style: kRowStyle)),
                      DataCell(Text('Porra', style: kRowStyle)),
                      DataCell(Text('Dale', style: kRowStyle)),
                    ]
                  ),
                  DataRow(
                      cells: [
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                      ]
                  ),
                  DataRow(
                      cells: [
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                      ]
                  ),
                  DataRow(
                      cells: [
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                      ]
                  ),
                  DataRow(
                      cells: [
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                      ]
                  ),
                  DataRow(
                      cells: [
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                      ]
                  ),
                  DataRow(
                      cells: [
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                        DataCell(Text('Porra', style: kRowStyle)),
                        DataCell(Text('Dale', style: kRowStyle)),
                      ]
                  ),
                ],
              ),
            ),
          ),
        ],
      );

 */



