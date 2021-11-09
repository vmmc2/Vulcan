// Vulcan is a software developed by:
// Victor Miguel de Morais Costa.
// License: MIT.
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
List<String> errorsToBeDisplayed = ["Simulation Failed"];

class Simulator extends StatefulWidget {
  String codeWritten; //Lembrando que quando eu crio uma variavel sem atribuir nenhum valor a ela. Ela fica com o valor "null".

  Simulator({this.codeWritten});

  @override
  _SimulatorState createState() => _SimulatorState();
}

class _SimulatorState extends State<Simulator> {
  List<InstructionCard> displayedInstructions = [];
  MajorStatus currentStatus = MajorStatus.register;
  TypeRegister cStatus = TypeRegister.integer;
  String dropdownValue = ' Text';

  Map<String,String> convertBinToHex = {
    '0000' : '0' ,
    '0001' : '1',
    '0010' : '2',
    '0011' : '3',
    '0100' : '4',
    '0101' : '5',
    '0110' : '6',
    '0111' : '7',
    '1000' : '8',
    '1001' : '9',
    '1010' : 'a',
    '1011' : 'b',
    '1100' : 'c',
    '1101' : 'd',
    '1110' : 'e',
    '1111' : 'f',
  };

  String getHexFrom8Bits(String input){
    String almost1;
    String almost2;
    almost1 = convertBinToHex[input.substring(0, 4)];
    almost2 = convertBinToHex[input.substring(4, 8)];
    return (almost1 + almost2);
  }

  @override
  void initState(){
    super.initState();
    errorsToBeDisplayed = ["Simulation Failed"];
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
      print(labelsAddress);

      //Chegou a hora de comecar a busca por erros de sintaxe...
      List<String> errors = assembler.findSyntaxErrors(tokensPerLine, labelsAddress);
      for(String error in errors){
        print(error);
      }
      if(errors.length > 0){
        for(String element in errors){
          errorsToBeDisplayed.add(element);
        }
        return;
      }

      //Quinta Parte: Agora vamos gerar o codigo de maquina para ser carregado na memoria...
      List<String> machineCode = assembler.generateMachineCode(tokensPerLine, labelsAddress);

      //Sexta Parte: Feito isso, chegou a hora de carregar o codigo binario (codigo de maquina no processador)
      processor.loadInstructionsInMemory(machineCode);
      //Setima Parte: Com as instrucoes carregadas, iniciamos a simulacao, execucao.
      processor.executeInstructions(labelsAddress);

      //Oitava Parte: Gerar a lista para printar na tela do Simulator.
      List<String> dpInstructions = assembler.getInstructionsList(tokensPerLine);
      List<String> programmingCounter = assembler.getPcs(dpInstructions);

      for (int i = 0; i < dpInstructions.length; i++) {
        print("${programmingCounter[i]} ------- ${machineCode[i]} ------- ${dpInstructions[i]}");
        try {
          displayedInstructions.add(InstructionCard(pc: programmingCounter[i],
              machineCode: getHexFrom8Bits(machineCode[i].substring(0, 8)) + getHexFrom8Bits(machineCode[i].substring(8, 16)) + getHexFrom8Bits(machineCode[i].substring(16, 24)) + getHexFrom8Bits(machineCode[i].substring(24, 32)),
              originalCode: dpInstructions[i]));
        }catch(e){
          print("i");
        }
      }
    }
  }

  Widget putData(MajorStatus currentStatus, TypeRegister cStatus){
    if(currentStatus == MajorStatus.memory){
      print("conteudo da memoria: ${processor.memory[12]}");
      return MemoryView(processor.memory);
    }else if(currentStatus == MajorStatus.register && cStatus == TypeRegister.integer){
      return IntegerRegisterList(processor.integerRegisters);
    }else if(currentStatus == MajorStatus.register && cStatus == TypeRegister.floating){
      return FloatingRegisterList(processor.floatingpointRegisters);
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
                                  Container(
                                    child: Expanded( //Por algum motivo, para usar ListView ou ListView.builder dentro de um widget sem ser Scaffold tem que por ela dentro de um Expanded() antes.
                                      child: errorsToBeDisplayed.length == 1 ? ListView.builder(
                                        padding: const EdgeInsets.all(8.0),
                                        itemCount: displayedInstructions.length,
                                        itemBuilder: (BuildContext context, int index){
                                          return GestureDetector(
                                            onLongPress: () {},
                                            child: Container(
                                              margin: EdgeInsets.all(3.0),
                                              height: 50.0,
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
                                                  SizedBox(width: 50.0),
                                                  Text(
                                                    '${displayedInstructions[index].pc}',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Color(0xFF02143D),
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                  SizedBox(width: 340.0),
                                                  Text(
                                                    '${displayedInstructions[index].machineCode}',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      color: Color(0xFF02143D),
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14.0,
                                                    ),
                                                  ),
                                                  SizedBox(width: 300.0),
                                                  Expanded(
                                                    child: Text(
                                                      '${displayedInstructions[index].originalCode}',
                                                      textAlign: TextAlign.start,
                                                      style: TextStyle(
                                                        color: Color(0xFF02143D),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      ) : ListView.builder(
                                        padding: const EdgeInsets.all(8.0),
                                        itemCount: errorsToBeDisplayed.length,
                                        itemBuilder: (BuildContext context, int index){
                                          return GestureDetector(
                                            onLongPress: () {},
                                            child: Container(
                                              margin: EdgeInsets.all(3.0),
                                              height: 70.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5.0),
                                                color: Color(0xFFFF3860),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Center(
                                                    child: Text(
                                                      index == 0 ? '${errorsToBeDisplayed[index]} with ${errorsToBeDisplayed.length - 1} error(s)!' : '${errorsToBeDisplayed[index]}',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins',
                                                        fontSize: index == 0 ? 24.0 : 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      ),
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
  List<String> memory = List<String>.filled(999988, '00000000', growable: false); //inicializar e memoria como privada porque nao tem logica o cara se capaz de mudar ela diretamente...
  int cursor = 400; //vai servir para me guiar na horar de ir mudando de list em list.
  int address = 400;
  String dropdownValue = ' Text';
  Map memorySegments = <String, int>{
    ' Text' : 400,
    ' Data': 200400,
    ' Heap': 400400,
    ' Stack': 999959,
  };
  Map<String,String> convertBinToHex = {
    '0000' : '0' ,
    '0001' : '1',
    '0010' : '2',
    '0011' : '3',
    '0100' : '4',
    '0101' : '5',
    '0110' : '6',
    '0111' : '7',
    '1000' : '8',
    '1001' : '9',
    '1010' : 'a',
    '1011' : 'b',
    '1100' : 'c',
    '1101' : 'd',
    '1110' : 'e',
    '1111' : 'f',
  };

  String getHexFrom8Bits(String input){
    String almost1;
    String almost2;
    almost1 = convertBinToHex[input.substring(0, 4)];
    almost2 = convertBinToHex[input.substring(4, 8)];
    return (almost1 + almost2);
  }

  //Construtor da Classe.
  MemoryView(List<String> input){
    for(int i = 0; i < input.length; i++){
      //IDEIA MELHOR: FAZER UM MAP DE TAMANHO DE 16 DE NUMEROS BINARIOS (4 BITS) PARA HEXADECIMAIS (2 CASAS).
      memory[i] = getHexFrom8Bits(input[i]);
    }
  }

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
                      widget.address = widget.memorySegments[widget.dropdownValue];
                      print("widget.address = ${widget.address}");
                      print("widget.cursor = ${widget.cursor}");
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
                        if (widget.cursor - 28 < 0) {
                          widget.cursor = 0;
                          widget.address = 0;
                        }
                        else {
                          widget.cursor -= 28;
                          widget.address -= 28;
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
                    if(widget.cursor >= 999987) return;
                    else{
                      setState(() {
                        if(widget.cursor + 28 >= 999987){
                          widget.cursor = 999959;
                          widget.address = 999959;
                        }else {
                          widget.cursor += 28;
                          widget.address += 28;
                        }
                        print("widget.address = ${widget.address}");
                        print("widget.cursor = ${widget.cursor}");
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
        Expanded(
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
                    DataCell(Text(widget.address <= 999987 ? '${widget.address}': '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 3]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 2]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 1]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 0]}' : '--', style: kRowStyle)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text(widget.address <= 999987 ? '${widget.address + 4}': '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 7]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 6]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 5]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 4]}' : '--', style: kRowStyle)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text(widget.address <= 999987 ? '${widget.address + 8}': '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 11]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 10]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 9]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 8]}' : '--', style: kRowStyle)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text(widget.address <= 999987 ? '${widget.address + 12}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 15]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 14]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 13]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 12]}' : '--', style: kRowStyle)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text(widget.address <= 999987 ? '${widget.address + 16}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 19]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 18]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 17]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 16]}' : '--', style: kRowStyle)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text(widget.address <= 999987 ? '${widget.address + 20}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 23]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 22]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 21]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 20]}' : '--', style: kRowStyle)),
                  ]
              ),
              DataRow(
                  cells: [
                    DataCell(Text(widget.address <= 999987 ? '${widget.address + 24}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 27]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 26]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 25]}' : '--', style: kRowStyle)),
                    DataCell(Text(widget.cursor <= 999987 ?'${widget.memory[widget.cursor + 24]}' : '--', style: kRowStyle)),
                  ]
              ),
            ],
          ),
        ),
      ],
    );
  }
}
