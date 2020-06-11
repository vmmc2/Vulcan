// Vulcan is Software developed by:
// Victor Miguel de Morais Costa
// License: MIT
import 'package:flutter/material.dart';

class Assembler{
  //List que contem todas as diretivas de Assembly RISC-V que foram implementadas
  //ate o momento.
  List<String> directives = [
    ".data",
    ".text",
    ".byte",
    ".string",
  ];

  //Map Abaixo contem o nome dos registradores inteiros de 32-bits
  Map<String,String> registerNames = {
    'x0' : "00000",
    'x1' : "00001",
    'x2' : "00010",
    'x3' : "00011",
    'x4' : "00100",
    'x5' : "00101",
    'x6' : "00110",
    'x7' : "00111",
    'x8' : "01000",
    'x9' : "01001",
    'x10' : "01010",
    'x11' : "01011",
    'x12' : "01100",
    'x13' : "01101",
    'x14' : "01110",
    'x15' : "01111",
    'x16' : "10000",
    'x17' : "10001",
    'x18' : "10010",
    'x19' : "10011",
    'x20' : "10100",
    'x21' : "10101",
    'x22' : "10110",
    'x23' : "10111",
    'x24' : "11000",
    'x25' : "11001",
    'x26' : "11010",
    'x27' : "11011",
    'x28' : "11100",
    'x29' : "11101",
    'x30' : "11110",
    'x31' : "11111",
  };

  //Map responsavel por mapear o nome da instrucao ao seu respectivo opcode
  //o opcode ta em formato String por questoes de simplicidade.
  //////////
  //R-TYPE//
  //////////
  Map<String,String> rTypeInstructionsOpCodeString = {
    "add" : "0110011", 
    "sub" : "0110011", 
    "sll" : "0110011", 
    "slt" : "0110011", 
    "sltu" : "0110011", 
    "xor" : "0110011", 
    "srl" : "0110011", 
    "sra" : "0110011", 
    "or" : "0110011", 
    "and" : "0110011", 
  };
  Map<String,String> rTypeInstructionsFunct3String = {
    "add" : "000", 
    "sub" : "000", 
    "sll" : "001", 
    "slt" : "010", 
    "sltu" : "011", 
    "xor" : "100", 
    "srl" : "101", 
    "sra" : "101", 
    "or" : "110", 
    "and" : "111", 
  };
  Map<String,String> rTypeInstructionsFunct7String = {
    "add" : "0000000", 
    "sub" : "0100000", 
    "sll" : "0000000", 
    "slt" : "0000000", 
    "sltu" : "0000000", 
    "xor" : "0000000", 
    "srl" :"0000000", 
    "sra" : "0100000", 
    "or" : "0000000", 
    "and" : "0000000", 
  };
  //////////
  //U-TYPE//
  //////////
  Map<String,String> uTypeInstructionsOpCodeString = {
    "lui" : "0110111",
    "auipc" : "0010111",
  };
  //////////
  //I-TYPE//
  //////////
  Map<String,String> iTypeInstructionsOpCodeString = {
    'addi' : '0010011',
    'slti' : '0010011',
    'sltiu' : '0010011',
    'xori' : '0010011',
    'ori' : '0010011',
    'andi' : '0010011',
    'slli' : '0010011',
    'srli' : '0010011',
    'srai' : '0010011',
    'lb' : '0000011',
    'lh' : '0000011',
    'lw' : '0000011',
    'lbu' : '0000011',
    'lhu' : '0000011',
    'jalr' : '1100111',
  };
  Map<String,String> iTypeInstructionsFunct3String = {
    'addi' : '000',
    'slti' : '010',
    'sltiu' : '011',
    'xori' : '100',
    'ori' : '110',
    'andi' : '111',
    'slli' : '001',
    'srli' : '101',
    'srai' : '101',
    'lb' : '000',
    'lh' : '001',
    'lw' : '010',
    'lbu' : '100',
    'lhu' : '101',
    'jalr' : '000',
  };
  //////////
  //S-TYPE//
  //////////
  Map<String,String> sTypeInstructionsOpCodeString = {
    'sb' : '0100011',
    'sh' : '0100011',
    'sw' : '0100011',
  };
  Map<String,String> sTypeInstructionsFunct3String = {
    'sb' : '000',
    'sh' : '001',
    'sw' : '010',
  };

  //Cada Set abaixo ta representando um formato/tipo de instrucao do RV32I
  Set<String> rTypeInstructions = {'add', 'sub', 'and', 'or', 'xor', 'sll', 'slt', 'sltu', 'srl', 'sra'};
  Set<String> uTypeInstructions = {'lui', 'auipc'};
  Set<String> iTypeInstructions = {'addi', 'slti', 'sltiu', 'xori', 'ori', 'andi', 'slli', 'srli', 'srai', 'lb', 'lh', 'lw', 'lbu', 'lhu', 'jalr'};
  Set<String> sTypeInstructions = {'sb', 'sh', 'sw'};
  Set<String> iTypeImmInstructions = {'addi', 'slti', 'sltiu', 'xori', 'ori', 'andi'};
  Set<String> iTypeShiftInstructions = {'slli', 'srli', 'srai'};
  Set<String> iTypeLoadInstructions = {'lb', 'lh', 'lw', 'lbu', 'lhu'};
  Set<String> iTypeJumpInstructions = {'jalr'};

  //Essa String inicial contem varias substrings separadas por '\n'
  //Cada uma das substrings representa uma linha do meu arquivo Assembly.
  String inputDocument;

  //o inputDocument eh um parametro obrigatorio para instanciar meu Assembler.
  Assembler({@required this.inputDocument});

  //Primeira funcao.. Vamo pegar essa string gigante com todas as instrucoes e gerar uma List de Strings, separando elas por '\n'. Fazendo isso, a gente obtem
  //uma List de Strings na qual cada elemento/substring representa uma instrucao
  List<String> generateInstruction(){
    List<String> result = inputDocument.split("\n");
    return result;
  }

  //Segunda função. Ela recebe como input uma List de Strings na qual cada String representa uma linha de código escrito. Ela retira as linhas vazias (em branco) e também
  //retira linhas que contém apenas comentários.
  List<String> eliminateEmptyLinesAndComments(List<String> input){
    List<String> output = [];
    for(int i = 0; i < input.length; i++){
      String line = input[i];
      if(line.length != 0 && line[0] != '#'){ //Se nao for linha vazia ou linha so com comentario, eu adiciono a minha List de Strings Output
        output.add(line);
      }
    }
    return output;
  }

  //Funcao auxiliar para a terceira funcao explicada abaixo:
  List<String> parse(String rawCode){
    List<String> result = [];
    var buffer = StringBuffer(); //Para operacoes de concatenacao, StringBuffer eh mais eficiente.
    bool foundAWord = false;
    for(int i = 0; i < rawCode.length; i++){
      if(rawCode[i] == '#'){ //Oq vem depois sao comentarios. Logo nao preciso checar o que vem depois disso.
        //print("entrei 1 -- ${i}");
        if(buffer.isEmpty == false){
          result.add(buffer.toString());
        }
        break;
      }
      if(rawCode[i] != ' ' && rawCode[i] != ','){
        //print("entrei 2 -- ${i}");
        buffer.write(rawCode[i]);
        if(i == rawCode.length - 1){
          result.add(buffer.toString());
        }
      }else{
        //print("entrei 3 -- ${i}");
        if(buffer.isEmpty == false){
          result.add(buffer.toString());
        }
        buffer.clear();
      }
    }
    return result;
  }

  //Terceira função. Vai ser a responsável por realizar a tokenização de cada linha de codigo. Como vai funcionar isso?
  //Entrada: "addi x9, x10, 145" ----> Saida: ["addi" , "x9" , "x10" , "145"]
  //Entrada2: "sub x9,x8,x6" ---------> Saida: ["sub" , "x9" , "x8" , "x6"]
  //Entrada3: "addi x10, x0, 14 #um comentario qualquer" ----> Saida: ["addi" , "x10" , "x0" , "14"]
  List<List<String>> tokenize(List<String> input){
    List<List<String>> result = [];
    for(int i = 0; i < input.length; i++){
      result.add(parse(input[i]));
    }
    return result;
  }

  //Funcao auxiliar para a quarta funcao, explicada abaixo:
  bool isFullTab(List<String> input){
    if(input.length > 1) return false;
    String test = input[0];
    if(test == '\t') return true;
    else return false;
  }

  //Quarta funcao. Vai ser responsavel por retirar empty lists ou lists que so tenham whitespaces que possam ter ficado dentro da minha List<List<String>>...
  List<List<String>> removeEmptyLists(List<List<String>> input){
    List<List<String>> output = [];
    for(int i = 0; i < input.length; i++){
      if(input[i].length != 0 && isFullTab(input[i]) == false){
        output.add(input[i]);
      }
    }
    return output;
  }

  //Quinta funcao. Vai ser responsavel por checar se cada lista, na sua primeira posicao (index 0) possui uma string cujo primeiro caracter eh um tab ('\t').
  //Se isso for verdade, vai retirar esse tab. E prosseguir o processo normalmente.
  List<List<String>> removeFirstTab(List<List<String>> input){
    for(int i = 0; i < input.length; i++){
      List<String> current = input[i];
      if(current[0].startsWith('\t') == true){
          String aux = current[0].substring(1);
          input[i][0] = aux;
      }
    }
    return input;
  }

  //Funcao auxiliar: Serve para gerar Strings de tamanho 20 (20 bits) para as instrucoes: lui e auipc.
  //Lembrando que os imediatos de lui e auipc sao sempre NUMEROS POSITIVOS.
  String generate20bitImmediate(String number){
    int n1 = int.parse(number, radix: 10);
    String pseudoans = n1.toRadixString(2); //Agora o imediato ta representado como uma String binaria (0's e 1's).
    int tamanho = pseudoans.length;
    String ext = '0' * (20 - tamanho); //Faco a extensao, caso seja necessario.
    return (ext + pseudoans); //retorno o imediato positivo como uma string binaria de 32 bits.
  }

  //Funcao auxiliar: Recebe um string representando um numero positivo/negativo na notacao decimal e retorna esse mesmo numero no formato binario seguindo a convencao
  //de complemento a 2.
  String get12bits2ComplementImm(String input, int len){
    int number = int.parse(input, radix: 10);
    String output = "";
    //Essa funcao abaixo tem uma treta. Ela nao faz extensao de zero para numeros positivos. Entretanto, ela faz extensao de sinal para numeros na notacao complemento a 2.
    if(number < 0){
      output = BigInt.from(number).toUnsigned(len).toRadixString(2);
    }else{
      String almost = BigInt.from(number).toUnsigned(len).toRadixString(2);
      int extend = (len - almost.length);
      output = ('0' * extend) + almost;
    }
    return output;
  }

  //Sexta funcao. Vai ser responsavel por gerar o codigo binario para cada instrucao. No caso, para cada instrucao, eu vou gerar uma String binario de tamanho 32
  //Lembrando que cada instrucao tem 32 bits e que cada posicao da minha string representa 1 bit.
  //POR ENQUANTO EU SO TENHO INSTRUCOES DO TIPO R e U
  List<String> generateMachineCode(List<List<String>> input){
    //Tenho que fazer esse processo para cada instrucao.
    List<String> machineCode = []; //Essa List contem Strings binarias que representam o codigo de maquina correspondente as instrucoes em Assembly.
    for(int i = 0; i < input.length; i++){

      List<String> currentInstruction = input[i]; //currentInstruction tem a instrucao da vez.

      if(currentInstruction.length == 4){ //Pode ser do tipo R
        if(rTypeInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao do tipo R.
          String instruction = rTypeInstructionsFunct7String[currentInstruction[0]] + registerNames[currentInstruction[3]] + registerNames[currentInstruction[2]] + rTypeInstructionsFunct3String[currentInstruction[0]] + registerNames[currentInstruction[1]] + rTypeInstructionsOpCodeString[currentInstruction[0]];
          print(instruction);
          machineCode.add(instruction);
        }
        else if(iTypeInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao do tipo I. Porem tenho que filtrar mais..
          if(iTypeImmInstructions.contains(currentInstruction[0]) == true){ // addi, slti, sltiu, ori, xori, andi.
            String immediate = get12bits2ComplementImm(currentInstruction[3], 12);
            String rs1 = registerNames[currentInstruction[2]];
            String funct3 = iTypeInstructionsFunct3String[currentInstruction[0]];
            String rd = registerNames[currentInstruction[1]];
            String opcode = iTypeInstructionsOpCodeString[currentInstruction[0]];
            String instruction = immediate + rs1 + funct3 + rd + opcode;
            print(instruction);
            machineCode.add(instruction);
          }
          else if(iTypeShiftInstructions.contains(currentInstruction[0]) == true){ // slli, srli, srai.
            String sllisrliFirst = "0000000";
            String sraiFirst = "0100000";
            String shamt = get12bits2ComplementImm(currentInstruction[3], 5);
            String rs1 = registerNames[currentInstruction[2]];
            String funct3 = iTypeInstructionsFunct3String[currentInstruction[0]];
            String rd = registerNames[currentInstruction[1]];
            String opcode = iTypeInstructionsOpCodeString[currentInstruction[0]];
            String instruction;
            if(currentInstruction[0] == "slli" || currentInstruction[0] == 'srli'){
              instruction = sllisrliFirst + shamt + rs1 + funct3 + rd + opcode;
            }else if(currentInstruction[0] == 'srai'){
              instruction = sraiFirst + shamt + rs1 + funct3 + rd + opcode;
            }
            print(instruction);
            machineCode.add(instruction);
          }
          else if(iTypeLoadInstructions.contains(currentInstruction[0]) == true){ // lb, lh, lw, lbu, lhu.
            String immediate = get12bits2ComplementImm(currentInstruction[2], 12);
            String rs1 = registerNames[currentInstruction[3]];
            String funct3 = iTypeInstructionsFunct3String[currentInstruction[0]];;
            String rd = registerNames[currentInstruction[1]];
            String opcode = iTypeInstructionsOpCodeString[currentInstruction[0]];;
            String instruction = immediate + rs1 + funct3 + rd + opcode;
            print(instruction);
            machineCode.add(instruction);
          }
          else if(iTypeJumpInstructions.contains(currentInstruction[0]) == true){ // jalr.
            //TO DO
          }
        }
        else if(sTypeInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao do tipo S: sb, sh, sw.

        }
      }
      else if(currentInstruction.length == 3){ //Pode ser do tipo U
        if(uTypeInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao do tipo U.
          String instruction = generate20bitImmediate(currentInstruction[2]) + registerNames[currentInstruction[1]] + uTypeInstructionsOpCodeString[currentInstruction[0]];
          print(instruction);
          machineCode.add(instruction);
        }

      }
    }
    return machineCode;
  }

}
