// Vulcan is a software developed by:
// Victor Miguel de Morais Costa.
// License: MIT.
import 'package:flutter/material.dart';
import 'dart:math';

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
  //Map Abaixo contem o nome dos registradores de ponto flutuante de precisao simples (32-bits)
  Map<String,String> floatingRegisterNames = {
    'f0' : "00000",
    'f1' : "00001",
    'f2' : "00010",
    'f3' : "00011",
    'f4' : "00100",
    'f5' : "00101",
    'f6' : "00110",
    'f7' : "00111",
    'f8' : "01000",
    'f9' : "01001",
    'f10' : "01010",
    'f11' : "01011",
    'f12' : "01100",
    'f13' : "01101",
    'f14' : "01110",
    'f15' : "01111",
    'f16' : "10000",
    'f17' : "10001",
    'f18' : "10010",
    'f19' : "10011",
    'f20' : "10100",
    'f21' : "10101",
    'f22' : "10110",
    'f23' : "10111",
    'f24' : "11000",
    'f25' : "11001",
    'f26' : "11010",
    'f27' : "11011",
    'f28' : "11100",
    'f29' : "11101",
    'f30' : "11110",
    'f31' : "11111",
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
  //////////
  //B-TYPE//
  //////////
  Map<String,String> bTypeInstructionsOpCodeString = {
    'beq' : '1100011',
    'bne' : '1100011',
    'blt' : '1100011',
    'bge' : '1100011',
    'bltu' : '1100011',
    'bgeu' : '1100011',
  };
  Map<String,String> bTypeInstructionsFunct3String = {
    'beq' : '000',
    'bne' : '001',
    'blt' : '100',
    'bge' : '101',
    'bltu' : '110',
    'bgeu' : '111',
  };
  //////////
  //J-TYPE//
  //////////
  //Instrucao do tipo-J nao tem funct3. Apenas tem o opcode.
  Map<String,String> jTypeInstructionsOpCodeString = {
    'jal' : '1101111',
  };

  //////////////////////
  //RV32M INSTRUCTIONS//
  //////////////////////
  Map<String,String> rv32MInstructionsOpCodeString = {
    'mul' : '0110011' ,
    'mulh' : '0110011',
    'mulhsu' : '0110011' ,
    'mulhu' : '0110011',
    'div' : '0110011',
    'divu' : '0110011',
    'rem' : '0110011',
    'remu' : '0110011',
  };
  Map<String,String> rv32MInstructionsFunct3String = {
    'mul' : '000' ,
    'mulh' : '001',
    'mulhsu' : '010' ,
    'mulhu' : '011',
    'div' : '100',
    'divu' : '101',
    'rem' : '110',
    'remu' : '111',
  };
  Map<String,String> rv32MInstructionsFunct7String = {
    'mul' : '0000001' ,
    'mulh' : '0000001',
    'mulhsu' : '0000001' ,
    'mulhu' : '0000001',
    'div' : '0000001',
    'divu' : '0000001',
    'rem' : '0000001',
    'remu' : '0000001',
  };


  //////////////////////
  //RV32A INSTRUCTIONS//
  //////////////////////
  Map<String,String> rv32AInstructionsOpCodeString = {
    'lr.w' : '0101111',
    'sc.w' : '0101111',
    'amoswap.w' : '0101111',
    'amoadd.w' : '0101111',
    'amoxor.w' : '0101111',
    'amoand.w' : '0101111',
    'amoor.w' : '0101111',
    'amomin.w' : '0101111',
    'amomax.w' : '0101111',
    'amominu.w' : '0101111',
    'amomaxu.w' : '0101111',
  };
  Map<String,String> rv32AInstructionsFunct3String = {
    'lr.w' : '010',
    'sc.w' : '010',
    'amoswap.w' : '010',
    'amoadd.w' : '010',
    'amoxor.w' : '010',
    'amoand.w' : '010',
    'amoor.w' : '010',
    'amomin.w' : '010',
    'amomax.w' : '010',
    'amominu.w' : '010',
    'amomaxu.w' : '010',
  };
  Map<String,String> rv32AInstructionsFunct5String = {
    'lr.w' : '00010',
    'sc.w' : '00011',
    'amoswap.w' : '00001',
    'amoadd.w' : '00000',
    'amoxor.w' : '00100',
    'amoand.w' : '01100',
    'amoor.w' : '01000',
    'amomin.w' : '10000',
    'amomax.w' : '10100',
    'amominu.w' : '11000',
    'amomaxu.w' : '11100',
  };



  //////////////////////
  //RV32F INSTRUCTIONS//
  //////////////////////
  /// Inicialmente, eu vou optar por deixar o campo rm das instrucoes com o valor '000'. Entretanto, esse valor deve ser alterado conforme o valor presente no registrador
  /// de controle dos valores de ponto-flutuante.
  /// Estou fazendo isso porque eu nao manjo muito de aritmetica envolvendo numeros de ponto flutuante. Preciso estudar mais sobre isso para entender melhor como funciona.
  Map<String,String> rv32FInstructionsOpCodeString = {
    'flw' : '0000111', //4
    'fsw' : '0100111', //4
    'fmadd.s' : '1000011', //5
    'fmsub.s' : '1000111', //5
    'fnmsub.s' : '1001011', //5
    'fnmadd.s' : '1001111', //5
    'fadd.s' : '1010011', //4
    'fsub.s' : '1010011', //4
    'fmul.s' : '1010011', //4
    'fdiv.s' : '1010011', //4
    'fsqrt.s' : '1010011', //4
    'fsgnj.s' : '1010011', //4
    'fsgnjn.s' : '1010011', //4
    'fsgnjx.s' : '1010011', //4
    'fmin.s' : '1010011', //4
    'fmax.s' : '1010011', //4
    'fcvt.w.s' : '1010011', //4
    'fcvt.wu.s' : '1010011', //4
    'fmv.x.w' : '1010011', //4
    'feq.s' : '1010011', //4
    'flt.s' : '1010011', //4
    'fle.s' : '1010011', //4
    'fclass.s' : '1010011', //4
    'fcvt.s.w' : '1010011', //4
    'fcvt.s.wu' : '1010011', //4
    'fmv.w.x' : '1010011', //4
  };
  Map<String,String> rv32FInstructionsFunct3String = {
    'flw' : '010',
    'fsw' : '010',
    'fsgnj.s' : '000',
    'fsgnjn.s' : '001',
    'fsgnjx.s' : '010',
    'fmin.s' : '000',
    'fmax.s' : '001',
    'fmv.x.w' : '000',
    'feq.s' : '010',
    'flt.s' : '001',
    'fle.s' : '000',
    'fclass.s' : '001',
    'fmv.w.x' : '000',
  };
  Map<String,String> rv32FExtraField5bits = {
    'fsqrt.s' : '00000',
    'fcvt.w.s' : '00000',
    'fcvt.wu.s' : '00001',
    'fmv.x.w' : '00000',
    'fclass.s' : '00000',
    'fcvt.s.w' : '00000',
    'fcvt.s.wu' : '00001',
    'fmv.w.x' : '00000',
  };
  Map<String,String> rv32FExtraField2Bits = {
    'fmadd.s' : '00',
    'fmsub.s' : '00',
    'fnmadd.s' : '00',
    'fnmsub.s' : '00',
  };
  Map<String,String> rv32FInstructionsFunct7String = {
    'fadd.s' : '0000000',
    'fsub.s' : '0000100',
    'fmul.s' : '0001000',
    'fdiv.s' : '0001100',
    'fsqrt.s' : '0101100',
    'fsgnj.s' : '0010000',
    'fsgnjn.s' : '0010000',
    'fsgnjx.s' : '0010000',
    'fmin.s' : '0010100',
    'fmax.s' : '0010100',
    'fcvt.w.s' : '1100000',
    'fcvt.wu.s' : '1100000',
    'fmv.x.w' : '1110000',
    'feq.s' : '1010000',
    'flt.s' : '1010000',
    'fle.s' : '1010000',
    'fclass.s' : '1110000',
    'fcvt.s.w' : '1101000',
    'fcvt.s.wu' : '1101000',
    'fmv.w.x' : '1111000',
  };
  String rm = "000";



  //Cada Set abaixo ta representando um formato/tipo de instrucao do RV32I
  Set<String> rTypeInstructions = {'add', 'sub', 'and', 'or', 'xor', 'sll', 'slt', 'sltu', 'srl', 'sra'};
  Set<String> uTypeInstructions = {'lui', 'auipc'};
  Set<String> iTypeInstructions = {'addi', 'slti', 'sltiu', 'xori', 'ori', 'andi', 'slli', 'srli', 'srai', 'lb', 'lh', 'lw', 'lbu', 'lhu', 'jalr'};
  Set<String> sTypeInstructions = {'sb', 'sh', 'sw'};
  Set<String> bTypeInstructions = {'beq', 'bne', 'bge', 'blt', 'bgeu', 'bltu'};
  Set<String> jTypeInstructions = {'jal'};
  Set<String> iTypeImmInstructions = {'addi', 'slti', 'sltiu', 'xori', 'ori', 'andi'};
  Set<String> iTypeShiftInstructions = {'slli', 'srli', 'srai'};
  Set<String> iTypeLoadInstructions = {'lb', 'lh', 'lw', 'lbu', 'lhu'};
  Set<String> iTypeJumpInstructions = {'jalr'};

  //Cada Set abaixo ta representando um formato/tipo de instrucao do RV32M
  Set<String> rv32MInstructions = {'mul', 'mulh', 'mulhsu', 'mulhu', 'div', 'divu', 'rem', 'remu'};

  //Cada Set abaixo ta representando um formato/tipo de instrucao do RV32A
  Set<String> rv32AInstructions = {'lr.w', 'sc.w', 'amoswap.w', 'amoadd.w', 'amoxor.w', 'amoand.w', 'amoor.w', 'amomin.w', 'amomax.w', 'amominu.w', 'amomaxu.w'};

  //Cada Set abaixo ta representando um formato/tipo de instrucao do RV32F
  Set<String> rv32FInstructions = {'flw', 'fsw', 'fmadd.s', 'fmsub.s', 'fnmsub.s', 'fnmadd.s', 'fadd.s', 'fsub.s', 'fmul.s', 'fdiv.s', 
                                    'fsqrt.s', 'fsgnj.s', 'fsgnjn.s' , 'fsgnjx.s', 'fmin.s', 'fmax.s', 'fcvt.w.s', 'fcvt.wu.s', 'fmv.x.w', 'feq.s', 'flt.s', 'fle.s',
                                    'fclass.s', 'fcvt.s.w', 'fcvt.s.wu', 'fmv.w.x'
  };

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

  //Sexta funcao. Vai receber como input a List<List<String>> com os tokens e vai ser responsavel por achar todas as labels dentro do codigo e os seus respectivos enderecos
  //, retornando tudo como um map.
  Map<String,int> findLabelsAddress(List<List<String>> input){
    Map<String,int> output = {};
    int pc = 400;
    for(int i = 0; i < input.length; i++){
      List<String> current = input[i];
      if(current.length == 1 && current[0].endsWith(":") == true){
        output[current[0]] = pc;
      }else{
        pc = pc + 4;
      }
    }
    return output;
  }

  //Setima funcao. Vai ser responsavel por gerar o codigo binario para cada instrucao. No caso, para cada instrucao, eu vou gerar uma String binario de tamanho 32
  //Lembrando que cada instrucao tem 32 bits e que cada posicao da minha string representa 1 bit.
  //POR ENQUANTO EU SO TENHO INSTRUCOES DO TIPO R e U
  List<String> generateMachineCode(List<List<String>> input, Map<String,int> labelsAddress){
    //Tenho que fazer esse processo para cada instrucao.
    List<String> machineCode = []; //Essa List contem Strings binarias que representam o codigo de maquina correspondente as instrucoes em Assembly.
    for(int i = 0; i < input.length; i++){

      List<String> currentInstruction = input[i]; //currentInstruction tem a instrucao da vez.

      if(currentInstruction.length == 4){ //Pode ser do tipo R ou uma instrucao do RV32M ou uma instrucao do tipo RV32A ou RV32F
        if(rTypeInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao do tipo R.
          String instruction = rTypeInstructionsFunct7String[currentInstruction[0]] + registerNames[currentInstruction[3]] + registerNames[currentInstruction[2]] + rTypeInstructionsFunct3String[currentInstruction[0]] + registerNames[currentInstruction[1]] + rTypeInstructionsOpCodeString[currentInstruction[0]];
          print(instruction);
          machineCode.add(instruction);
        }
        else if(rv32MInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao da extensao RV32M: mul, mulh, mulhsu, mulhu, div, divu, rem, remu
          String instruction = "";
          String funct7 = rv32MInstructionsFunct7String[currentInstruction[0]];
          String rs2 = registerNames[currentInstruction[3]];
          String rs1 = registerNames[currentInstruction[2]];
          String funct3 = rv32MInstructionsFunct3String[currentInstruction[0]];
          String rd = registerNames[currentInstruction[1]];
          String opcode = rv32MInstructionsOpCodeString[currentInstruction[0]];
          instruction = funct7 + rs2 + rs1 + funct3 + rd + opcode;
          machineCode.add(instruction);
        }
        else if(rv32FInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao da extensao RV32F
          //PRIMEIRA PARTE: Lidando com as instrucoes que tem o "rm":
          if(currentInstruction[0] == 'fadd.s' || currentInstruction[0] == 'fsub.s' || currentInstruction[0] == 'fmul.s' || currentInstruction[0] == 'fdiv.s'){
            String instruction = "";
            String funct7 = rv32FInstructionsFunct7String[currentInstruction[0]];
            String rs2 = floatingRegisterNames[currentInstruction[3]];
            String rs1 = floatingRegisterNames[currentInstruction[2]];
            String pseudoRm = rm;
            String rd = floatingRegisterNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = funct7 + rs2 + rs1 + pseudoRm + rd + opcode;
            machineCode.add(instruction);
          }
          //SEGUNDA PARTE: Lidando com as instrucoes "fmin.s" e "fmax.s":
          else if(currentInstruction[0] == 'fmin.s'){
            String instruction = "";
            String funct7 = rv32FInstructionsFunct7String[currentInstruction[0]];
            String rs2 = floatingRegisterNames[currentInstruction[3]];
            String rs1 = floatingRegisterNames[currentInstruction[2]];
            String aux = "000";
            String rd = floatingRegisterNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = funct7 + rs2 + rs1 + aux + rd + opcode;
            machineCode.add(instruction);
          }
          else if(currentInstruction[0] == 'fmax.s'){
            String instruction = "";
            String funct7 = rv32FInstructionsFunct7String[currentInstruction[0]];
            String rs2 = floatingRegisterNames[currentInstruction[3]];
            String rs1 = floatingRegisterNames[currentInstruction[2]];
            String aux = "001";
            String rd = floatingRegisterNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = funct7 + rs2 + rs1 + aux + rd + opcode;
            machineCode.add(instruction);
          }
          //TERCEIRA PARTE: Lidando com as instrucoes "feq.s", "flt.s", "fle.s"
          else if(currentInstruction[0] == 'feq.s' || currentInstruction[0] == 'flt.s' || currentInstruction[0] == 'fle.s'){
            String instruction = "";
            String funct7 = rv32FInstructionsFunct7String[currentInstruction[0]];
            String rs2 = floatingRegisterNames[currentInstruction[3]];
            String rs1 = floatingRegisterNames[currentInstruction[2]];
            String aux = rv32FInstructionsFunct3String[currentInstruction[0]];
            String rd = registerNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = funct7 + rs2 + rs1 + aux + rd + opcode;
            machineCode.add(instruction);
          }
          //QUARTA PARTE: Lidando com as instrucoes: "fsgnj.s", "fsgnjn.s", "fsgnjx.s"
          else if(currentInstruction[0] == "fsgnj.s" || currentInstruction[0] == "fsgnjn.s" || currentInstruction[0] == "fsgnjx.s"){
            String instruction = "";
            String funct7 = rv32FInstructionsFunct7String[currentInstruction[0]];
            String rs2 = floatingRegisterNames[currentInstruction[3]];
            String rs1 = floatingRegisterNames[currentInstruction[2]];
            String funct3 = rv32FInstructionsFunct3String[currentInstruction[0]];
            String rd = floatingRegisterNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = funct7 + rs2 + rs1 + funct3 + rd + opcode;
            machineCode.add(instruction);
          }
          //QUINTA PARTE: Lidando com a instrucao "fsw"
          //Example: fsw rs2, offset, rs1
          else if(currentInstruction[0] == "fsw"){
            String instruction = "";
            String immediate = get12bits2ComplementImm(currentInstruction[2], 12);
            String imm115 = immediate.substring(0, 7); 
            String imm40 = immediate.substring(7, 12);
            String rs2 = floatingRegisterNames[currentInstruction[1]];
            String rs1 = registerNames[currentInstruction[3]];
            String funct3 = rv32FInstructionsFunct3String[currentInstruction[0]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = imm115 + rs2 + rs1 + funct3 + imm40 + opcode;
            machineCode.add(instruction);
          }
          //SEXTA PARTE: Lidando com a instrucao "flw"
          //Example: flw rd, offset, rs1
          else if(currentInstruction[0] == "flw"){
            String instruction = "";
            String immediate = get12bits2ComplementImm(currentInstruction[2], 12);
            String rs1 = registerNames[currentInstruction[3]];
            String funct3 = rv32FInstructionsFunct3String[currentInstruction[0]];
            String rd = floatingRegisterNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = immediate + rs1 + funct3 + rd + opcode;
            machineCode.add(instruction);
          }
        }
        else if(rv32AInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao da extensao RV32A: 'sc.w', 'amoswap.w', 'amoadd.w', 'amoxor.w', 'amoand.w', 'amoor.w', 'amomin.w', 'amomax.w', 'amominu.w', 'amomaxu.w'
          var rndGenerator = Random();
          String instruction = "";
          String opcode = rv32AInstructionsOpCodeString[currentInstruction[0]];
          String funct3 = rv32AInstructionsFunct3String[currentInstruction[0]];
          String funct5 = rv32AInstructionsFunct5String[currentInstruction[0]];
          String rs1 = registerNames[currentInstruction[3]];
          String rs2 = registerNames[currentInstruction[2]];
          String rd = registerNames[currentInstruction[1]];
          String aq = rndGenerator.nextBool() == true ? '1' : '0';
          String rl = rndGenerator.nextBool() == true ? '1' : '0';;
          instruction = funct5 + aq + rl + rs2 + rs1 + funct3 + rd + opcode;
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
            machineCode.add(instruction);
          }
          else if(iTypeLoadInstructions.contains(currentInstruction[0]) == true){ // lb, lh, lw, lbu, lhu.
            String immediate = get12bits2ComplementImm(currentInstruction[2], 12);
            String rs1 = registerNames[currentInstruction[3]];
            String funct3 = iTypeInstructionsFunct3String[currentInstruction[0]];;
            String rd = registerNames[currentInstruction[1]];
            String opcode = iTypeInstructionsOpCodeString[currentInstruction[0]];;
            String instruction = immediate + rs1 + funct3 + rd + opcode;
            machineCode.add(instruction);
          }
          else if(iTypeJumpInstructions.contains(currentInstruction[0]) == true){ // jalr.
            String rs1 = registerNames[currentInstruction[3]];
            String funct3 = iTypeInstructionsFunct3String[currentInstruction[0]];
            String rd = registerNames[currentInstruction[1]];
            String opcode = iTypeInstructionsOpCodeString[currentInstruction[0]];
            String immediate = get12bits2ComplementImm(currentInstruction[2] , 12);
            String instruction = immediate + rs1 + funct3 + rd + opcode;
            //O valor que vai no immediate + o valor de rs1 eh o valor do novo pc pos-salto.
            //rd recebe pc + 4 (pre-salto).
            machineCode.add(instruction);
          }
        }
        else if(sTypeInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao do tipo S: sb, sh, sw.
          // sb rs2, imm, rs1
          String immediate = get12bits2ComplementImm(currentInstruction[2], 12);
          String imm115 = immediate.substring(0, 7); 
          String imm40 = immediate.substring(7, 12);
          String rs2 = registerNames[currentInstruction[1]];
          String rs1 = registerNames[currentInstruction[3]];
          String funct3 = sTypeInstructionsFunct3String[currentInstruction[0]];
          String opcode = sTypeInstructionsOpCodeString[currentInstruction[0]];
          String instruction = imm115 + rs2 + rs1 + funct3 + imm40 + opcode;
          machineCode.add(instruction);
        }
        else if(bTypeInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao do tipo B: beq, bne, blt, bge, bltu, bgeu.
          // beq rs1, rs2, label
          String rs1;
          String rs2;
          String funct3;
          String opcode;
          int offset;
          String immediate;
          String instruction;
          ///
          rs2 = registerNames[currentInstruction[2]];
          rs1 = registerNames[currentInstruction[1]];
          funct3 = bTypeInstructionsFunct3String[currentInstruction[0]];
          opcode = bTypeInstructionsOpCodeString[currentInstruction[0]];
          
          offset = labelsAddress[currentInstruction[3] + ":"];
          
          immediate = BigInt.from(offset).toUnsigned(12).toRadixString(2);
          print("endereco da label ${currentInstruction[3]}: $offset");
          instruction = "";
          if(immediate.length == 12){ //deu imediato negativo.
            //hora de montar a instruction.
            instruction = immediate[0] + immediate.substring(2, 8) + rs2 + rs1 + funct3 + immediate.substring(8, 12) + immediate[1] + opcode;
          }else if(immediate.length < 12){ //deu imediato positivo.
            immediate = ('0' * (12 - immediate.length)) + immediate;
            //hora de montar a instruction.
            instruction = immediate[0] + immediate.substring(2, 8) + rs2 + rs1 + funct3 + immediate.substring(8, 12) + immediate[1] + opcode;
          }
          machineCode.add(instruction);
        }
      }
      else if(currentInstruction.length == 5){ //Pode ser alguma das seguintes instrucoes da RV32F: fmadd.s, fmsub.s, fnmadd.s, fnmsub.s
        //instrucoes: fmadd.s, fmsub.s, fnmadd.s, fnmsub.s
        if(rv32FInstructions.contains(currentInstruction[0]) == true){
          if(currentInstruction[0] == 'fmadd.s' || currentInstruction[0] == 'fmsub.s' || currentInstruction[0] == 'fnmadd.s' || currentInstruction[0] == 'fnmsub.s'){
            String instruction = "";
            String rs3 = floatingRegisterNames[currentInstruction[4]];
            String aux = "00";
            String rs2 = floatingRegisterNames[currentInstruction[3]];
            String rs1 = floatingRegisterNames[currentInstruction[2]];
            String pseudoRm = rm;
            String rd = floatingRegisterNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = rs3 + aux + rs2 + rs1 + pseudoRm + rd + opcode;
            machineCode.add(instruction);
          }
        }
      }
      else if(currentInstruction.length == 3){ //Pode ser do tipo U ou J ou a instrucao "lr.w" da extensao RV32A
        if(uTypeInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao do tipo U.
          String instruction = generate20bitImmediate(currentInstruction[2]) + registerNames[currentInstruction[1]] + uTypeInstructionsOpCodeString[currentInstruction[0]];
          machineCode.add(instruction);
        }
        else if(rv32AInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh a instrucao: lr.w
          var rndGenerator = Random();
          String instruction = "";
          String funct5 = rv32AInstructionsFunct5String[currentInstruction[0]];
          String aq = rndGenerator.nextBool() == true ? "1" : "0";
          String rl = rndGenerator.nextBool() == true ? "1" : "0";
          String aux = "00000";
          String rs1 = registerNames[currentInstruction[2]];
          String funct3 = rv32AInstructionsFunct3String[currentInstruction[0]];
          String rd = registerNames[currentInstruction[1]];
          String opcode = rv32AInstructionsOpCodeString[currentInstruction[0]];
          instruction = funct5 + aq + rl + aux + rs1 + funct3 + rd + opcode;
          machineCode.add(instruction);
        }
        else if(rv32FInstructions.contains(currentInstruction[0]) == true){ //Instrucoes de tamanho 3 da extensao RV32F.
          //Lidando com a instrucao: 'fsqrt.s': 
          if(currentInstruction[0] == 'fsqrt.s'){ 
            String instruction = "";
            String funct7 = rv32FInstructionsFunct7String[currentInstruction[0]];
            String aux = "00000";
            String rs1 = floatingRegisterNames[currentInstruction[2]];
            String pseudoRm = rm;
            String rd = floatingRegisterNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = funct7 + aux + rs1 + pseudoRm + rd + opcode;
            machineCode.add(instruction);
          }
          //Lidando com as instrucoes "fcvt.s.w" e "fcvt.s.wu"
          else if(currentInstruction[0] == "fcvt.s.w" || currentInstruction[0] == 'fcvt.s.wu'){
            String instruction = "";
            String funct7 = rv32FInstructionsFunct7String[currentInstruction[0]];
            String funct5 = rv32FExtraField5bits[currentInstruction[0]];
            String rs1 = registerNames[currentInstruction[2]];
            String pseudoRm = rm;
            String rd = floatingRegisterNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = funct7 + funct5 + rs1 + pseudoRm + rd + opcode;
            machineCode.add(instruction);
          }
          //Lidando com a instrucao: "fmv.w.x"
          else if(currentInstruction[0] == "fmv.w.x"){
            String instruction = "";
            String funct7 = rv32FInstructionsFunct7String[currentInstruction[0]];
            String funct5 = rv32FExtraField5bits[currentInstruction[0]];
            String rs1 = registerNames[currentInstruction[2]];
            String aux = rv32FInstructionsFunct3String[currentInstruction[0]];
            String rd = floatingRegisterNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = funct7 + funct5 + rs1 + aux + rd + opcode;
            machineCode.add(instruction);
          }
          //Lidando com a instrucao: "fclass.s"
          else if(currentInstruction[0] == "fclass.s"){
            String instruction = "";
            String funct7 = rv32FInstructionsFunct7String[currentInstruction[0]];
            String funct5 = rv32FExtraField5bits[currentInstruction[0]];
            String rs1 = floatingRegisterNames[currentInstruction[2]];
            String aux = rv32FInstructionsFunct3String[currentInstruction[0]];
            String rd = registerNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = funct7 + funct5 + rs1 + aux + rd + opcode;
            machineCode.add(instruction);
          }
          //Lidando com as instrucoes: "fcvt.w.s" e "fcvt.wu.s"
          else if(currentInstruction[0] == "fcvt.w.s" || currentInstruction[0] == "fcvt.wu.s"){
            String instruction = "";
            String funct7 = rv32FInstructionsFunct7String[currentInstruction[0]];
            String funct5 = rv32FExtraField5bits[currentInstruction[0]];
            String rs1 = floatingRegisterNames[currentInstruction[2]];
            String pseudoRm = rm;
            String rd = registerNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = funct7 + funct5 + rs1 + pseudoRm + rd + opcode;
            machineCode.add(instruction);
          }
          //Lidando com a instrucao: "fmv.x.w"
          else if(currentInstruction[0] == "fmv.x.w"){
            String instruction = "";
            String funct7 = rv32FInstructionsFunct7String[currentInstruction[0]];
            String funct5 = rv32FExtraField5bits[currentInstruction[0]];
            String rs1 = floatingRegisterNames[currentInstruction[2]];
            String aux = "000";
            String rd = registerNames[currentInstruction[1]];
            String opcode = rv32FInstructionsOpCodeString[currentInstruction[0]];
            instruction = funct7 + funct5 + rs1 + aux + rd + opcode;
            machineCode.add(instruction);
          }
        }
        else if(jTypeInstructions.contains(currentInstruction[0]) == true){ //Tenho certeza que eh uma instrucao do tipo J. (jal)
          String rd = registerNames[currentInstruction[1]];
          String opcode = jTypeInstructionsOpCodeString[currentInstruction[0]];
          int offset;
          try{
          offset = labelsAddress[currentInstruction[2] + ":"];
          }catch(e){
            print("errou miseravi!!!");
          }
          print("offset de ${currentInstruction[2]}: $offset");
          String instruction = "";
          String immediate = BigInt.from(offset).toUnsigned(20).toRadixString(2);
          if(immediate.length == 20){ //deu imediato negativo.
            //hora de montar a instruction.
            instruction = immediate[0] + immediate.substring(10, 20) + immediate[9] + immediate.substring(1, 9) + rd + opcode;
          }else if(immediate.length < 20){ //deu imediato positivo.
            immediate = ('0' * (20 - immediate.length)) + immediate;
            //hora de montar a instruction.
            instruction = immediate[0] + immediate.substring(10, 20) + immediate[9] + immediate.substring(1, 9) + rd + opcode;
          }
          machineCode.add(instruction);
        }
      }

    }
    return machineCode;
  }

  //Oitava funcao: Responsavel por pegar a lista de strings e pegar apenas as instrucoes... (sem considerar as labels).
  List<String> getInstructionsList(List<List<String>> tokensPerLine){
    List<String> output = [];
    for(int i = 0; i < tokensPerLine.length; i++){
      List<String> current = tokensPerLine[i];
      if(current.length == 1){
        continue;
      }else if(current.length > 1){
        String finale = "";
        for(int j = 0; j < current.length; j++){
          if(j > 0 && j != current.length - 1) {
            finale += current[j] + ", ";
          }else{
            finale += current[j] + " ";
          }
        }
        output.add(finale);
      }
    }
    return output;
  }

  //Nona funcao: Pega os PCs de todas as instrucoes. Menos os das labels
  List<String> getPcs(List<String> dpInstructions){
    List<String> output = [];
    int pc = 400;
    for(String element in dpInstructions) {
      output.add("$pc");
      pc += 4;
    }
    return output;
  }

  //Decima funcao: Responsavel por receber a List<List<String>> tokensPerLine e retorna uma lista de strings contendo possiveis erros de sintaxe
  List<String> findSyntaxErrors(List<List<String>> tokensPerLine, Map<String,int> labelsAddress){
    List<String> output = [];
    try{
    for(List<String> element in tokensPerLine){
      if(element.length == 1){ //Pode ser uma label...
        if(element[0].endsWith(':') == true){
          // Eh uma label..
        }else{
          output.add("Invalid instruction: " + element.join(' '));
        }
      }
      else if(element.length == 2 || element.length > 6){
        output.add("Invalid instruction: " + element.join(' '));
      }
      else{ // O tamanho da instrucao eh valido (3 ou 4 ou 5). Mas a instrucao pode ser invalida
        //Primeiro teste: Verificar se o nome da instrucao eh invalido.
        if(rTypeInstructions.contains(element[0]) == false && iTypeInstructions.contains(element[0]) == false && jTypeInstructions.contains(element[0]) == false && sTypeInstructions.contains(element[0]) == false && uTypeInstructions.contains(element[0]) == false && bTypeInstructions.contains(element[0]) == false && rv32MInstructions.contains(element[0]) == false  && rv32AInstructions.contains(element[0]) == false && rv32FInstructions.contains(element[0]) == false){
          output.add("Invalid instruction: " + element.join(' '));
        }
        //Segundo teste: Verificar se tem nome de registrador invalido na instrucao.
        if(element.length == 4 && rTypeInstructions.contains(element[0]) == true){ //tem que checar se os registradores das instrucoes type-R estao Ok.
          if(registerNames.containsKey(element[1]) == false || registerNames.containsKey(element[2]) == false || registerNames.containsKey(element[3]) == false){
            List<String> answer = [];
            for(int i = 0; i < element.length; i++){
              if(i == element.length - 1 || i == 0){
                answer.add(element[i]);
              }else{
                answer.add(element[i] + ",");
              }
            }
            output.add("Invalid register at instruction: " + answer.join(' '));
          }
        }else if(element.length != 4 && rTypeInstructions.contains(element[0]) == true){
          List<String> answer = [];
          for(int i = 0; i < element.length; i++){
            if(i == element.length - 1 || i == 0){
              answer.add(element[i]);
            }else{
              answer.add(element[i] + ",");
            }
          }
          output.add("Invalid number of operands at instruction: " + answer.join(' '));
        }



        if(element.length == 4 && rv32MInstructions.contains(element[0]) == true){ //Checando se os registradores das instrucoes do RV32M estao Ok.
          if(registerNames.containsKey(element[1]) == false || registerNames.containsKey(element[2]) == false || registerNames.containsKey(element[3]) == false){
            List<String> answer = [];
            for(int i = 0; i < element.length; i++){
              if(i == element.length - 1 || i == 0){
                answer.add(element[i]);
              }else{
                answer.add(element[i] + ",");
              }
            }
            output.add("Invalid register at instruction: " + answer.join(' '));
          }
        }else if(element.length != 4 && rv32MInstructions.contains(element[0]) == true){
          List<String> answer = [];
          for(int i = 0; i < element.length; i++){
            if(i == element.length - 1 || i == 0){
              answer.add(element[i]);
            }else{
              answer.add(element[i] + ",");
            }
          }
          output.add("Invalid number of operands at instruction: " + answer.join(' '));
        }


        if((element.length == 4 || element.length == 3) && rv32AInstructions.contains(element[0]) == true){ //Checando se os registradores das instrucoes do RV32A estao Ok.
          if(element.length == 4){
            if(registerNames.containsKey(element[1]) == false || registerNames.containsKey(element[2]) == false || registerNames.containsKey(element[3]) == false){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
          }else if(element.length == 3){
            if(registerNames.containsKey(element[1]) == false || registerNames.containsKey(element[2]) == false){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
          }
        }else if(element.length != 4 && element.length != 3 && rv32AInstructions.contains(element[0]) == true){
          List<String> answer = [];
          for(int i = 0; i < element.length; i++){
            if(i == element.length - 1 || i == 0){
              answer.add(element[i]);
            }else{
              answer.add(element[i] + ",");
            }
          }
          output.add("Invalid number of operands at instruction: " + answer.join(' '));
        }

        if(rv32FInstructions.contains(element[0]) == true){ //Checando os erros nas instrucoes RV32F
          //Instrucoes: fadd.s, fsub.s, fmul.s, fdiv.s, fmin.s, fmax.s
          if(element[0] == "fadd.s" || element[0] == "fsub.s" || element[0] == "fmul.s" || element[0] == "fdiv.s" || element[0] == "fmin.s" || element[0] == "fmax.s"){
            if(element.length != 4){ //Invalid number of operands
              //print("entreeeiiiiiiiiiiiiiiiiii daleeeeeeeee porrrrrrrrrraaaaaaaaa");
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid number of operands at instruction: " + answer.join(' '));
            }
            if(floatingRegisterNames.containsKey(element[1]) == false || floatingRegisterNames.containsKey(element[2]) == false || floatingRegisterNames.containsKey(element[3]) == false){ //Invalid Registers
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
          }
          //Instrucoes: feq.s, fle.s, flt.s
          else if(element[0] == "feq.s" || element[0] == "fle.s" || element[0] == "flt.s"){
            if(element.length != 4){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid number of operands at instruction: " + answer.join(' '));
            }
            if(registerNames.containsKey(element[1]) == false || floatingRegisterNames.containsKey(element[2]) == false || floatingRegisterNames.containsKey(element[3]) == false){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
          }
          //Instrucoes: fcvt.s.w, fcvt.s.wu, fmv.w.x
          else if(element[0] == "fcvt.s.w" || element[0] == "fcvt.s.wu" || element[0] == "fmv.w.x"){
            if(element.length != 3){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid number of operands at instruction: " + answer.join(' '));
            }
            if(floatingRegisterNames.containsKey(element[1]) == false || registerNames.containsKey(element[2]) == false){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
          }
          //Instrucoes: fsqrt.s
          else if(element[0] == "fsqrt.s"){
            if(element.length != 3){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid number of operands at instruction: " + answer.join(' '));
            }
            if(floatingRegisterNames.containsKey(element[1]) == false || floatingRegisterNames.containsKey(element[2]) == false){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
          }
          //Instrucoes: fmadd.s, fmsub.s, fnmadd.s, fnmsub.s
          else if(element[0] == "fmadd.s" || element[0] == "fmsub.s" || element[0] == "fnmadd.s" || element[0] == "fnmsub.s"){
            if(element.length != 5){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid number of operands at instruction: " + answer.join(' '));
            }
            if(floatingRegisterNames.containsKey(element[1]) == false || floatingRegisterNames.containsKey(element[2]) == false || floatingRegisterNames.containsKey(element[3]) == false || floatingRegisterNames.containsKey(element[4]) == false){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
          }
          //Instrucoes: fcvt.w.s, fcvt.wu.s, fmv.x.w
          else if(element[0] == "fcvt.w.s" || element[0] == "fcvt.wu.s" || element[0] == "fmv.x.w"){
            if(element.length != 3){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid number of operands at instruction: " + answer.join(' '));
            }
            if(registerNames.containsKey(element[1]) == false || floatingRegisterNames.containsKey(element[2]) == false){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
          }
          //Instrucoes: fsgnj.s, fsgnjn.s, fsgnjx.s
          else if(element[0] == "fsgnj.s" || element[0] == "fsgnjn.s" || element[0] == "fsgnjx.s"){
            if(element.length != 4){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid number of operands at instruction: " + answer.join(' '));
            }
            if(floatingRegisterNames.containsKey(element[1]) == false || floatingRegisterNames.containsKey(element[2]) == false || floatingRegisterNames.containsKey(element[3]) == false){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
          }
          //Instrucao: flw
          else if(element[0] == "flw"){
            if(element.length != 4){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid number of operands at instruction: " + answer.join(' '));
            }
            if(floatingRegisterNames.containsKey(element[1]) == false || registerNames.containsKey(element[3]) == false){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
            try{
              int valorImm = int.parse(element[2], radix: 10);
              if(valorImm < -2048 || valorImm > 2047){
                List<String> answer = [];
                for(int i = 0; i < element.length; i++){
                  if(i == element.length - 1 || i == 0){
                    answer.add(element[i]);
                  }else{
                    answer.add(element[i] + ",");
                  }
                }
                output.add("Invalid immediate (out of range) at instruction: " + answer.join(' '));
              }
            }catch(e){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid immediate (not a number) at instruction: " + answer.join(' '));
            }
          }
          //Instrucao: fsw
          else if(element[0] == "fsw"){
            if(element.length != 4){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid number of operands at instruction: " + answer.join(' '));
            }
            if(floatingRegisterNames.containsKey(element[1]) == false || registerNames.containsKey(element[3]) == false){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
            try{
              int valorImm = int.parse(element[2], radix: 10);
              if(valorImm < -2048 || valorImm > 2047){
                List<String> answer = [];
                for(int i = 0; i < element.length; i++){
                  if(i == element.length - 1 || i == 0){
                    answer.add(element[i]);
                  }else{
                    answer.add(element[i] + ",");
                  }
                }
                output.add("Invalid immediate (out of range) at instruction: " + answer.join(' '));
              }
            }catch(e){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid immediate (not a number) at instruction: " + answer.join(' '));
            }
          }
        }
        

        if(element.length == 4 && sTypeInstructions.contains(element[0]) == true){ //checando por possiveis erros em instrucoes type-S: registradores invalidos ou immediato fora de range.
          if(registerNames.containsKey(element[1]) == false || registerNames.containsKey(element[3]) == false){ //registrador invalido
            List<String> answer = [];
            for(int i = 0; i < element.length; i++){
              if(i == element.length - 1 || i == 0){
                answer.add(element[i]);
              }else{
                answer.add(element[i] + ",");
              }
            }
            output.add("Invalid register at instruction: " + answer.join(' '));
          }
          try{ //checando por immediatos invalidos: nas instrucoes type-S os immediatos devem estar dentro do range: [-2048, 2047]
            int valorImm = int.parse(element[2], radix: 10);
            if(valorImm < -2048 || valorImm > 2047){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid immediate (out of range) at instruction: " + answer.join(' '));
            }
          }catch(e){
            List<String> answer = [];
            for(int i = 0; i < element.length; i++){
              if(i == element.length - 1 || i == 0){
                answer.add(element[i]);
              }else{
                answer.add(element[i] + ",");
              }
            }
            output.add("Invalid immediate (not a number) at instruction: " + answer.join(' '));
          }
        }else if(element.length != 4 && sTypeInstructions.contains(element[0]) == true){
          List<String> answer = [];
          for(int i = 0; i < element.length; i++){
            if(i == element.length - 1 || i == 0){
              answer.add(element[i]);
            }else{
              answer.add(element[i] + ",");
            }
          }
          output.add("Invalid number of operands at instruction: " + answer.join(' '));
        }



        if(element.length == 3 && uTypeInstructions.contains(element[0]) == true){ //checando por possiveis erros em instrucoes type-U: registradores invalidos ou immediatos fora do range
          if(registerNames.containsKey(element[1]) == false){ //registrador invalido
            List<String> answer = [];
            for(int i = 0; i < element.length; i++){
              if(i == element.length - 1 || i == 0){
                answer.add(element[i]);
              }else{
                answer.add(element[i] + ",");
              }
            }
            output.add("Invalid register at instruction: " + answer.join(' '));
          }
          try{ //checando por immediatos invalidos: nas instrucoes type-U os immediatos devem estar dentro do range: [0, 1048575]
            int valorImm = int.parse(element[2], radix: 10);
            if(valorImm < 0 || valorImm > 1048575){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid immediate (out of range) at instruction: " + answer.join(' '));
            }
          }catch(e){
            List<String> answer = [];
            for(int i = 0; i < element.length; i++){
              if(i == element.length - 1 || i == 0){
                answer.add(element[i]);
              }else{
                answer.add(element[i] + ",");
              }
            }
            output.add("Invalid immediate (not a number) at instruction: " + answer.join(' '));
          }
        }else if(element.length != 3 && uTypeInstructions.contains(element[0]) == true){
          List<String> answer = [];
          for(int i = 0; i < element.length; i++){
            if(i == element.length - 1 || i == 0){
              answer.add(element[i]);
            }else{
              answer.add(element[i] + ",");
            }
          }
          output.add("Invalid number of operands at instruction: " + answer.join(' '));
        }



        if(element.length == 3 && jTypeInstructions.contains(element[0]) == true){ //checando por possiveis erros em instrucoes type-J: registradores invalidos ou labels inexistentes
          if(registerNames.containsKey(element[1]) == false){ //registrador invalido
            List<String> answer = [];
            for(int i = 0; i < element.length; i++){
              if(i == element.length - 1 || i == 0){
                answer.add(element[i]);
              }else{
                answer.add(element[i] + ",");
              }
            }
            output.add("Invalid register at instruction: " + answer.join(' '));
          }
          if(labelsAddress.containsKey(element[2] + ":") == false){ //Estou tentando pular para uma label que nao existe no codigo. ERRO.
            List<String> answer = [];
            for(int i = 0; i < element.length; i++){
              if(i == element.length - 1 || i == 0){
                answer.add(element[i]);
              }else{
                answer.add(element[i] + ",");
              }
            }
            output.add("Invalid label at instruction: " + answer.join(' '));
          }
        }else if(element.length != 3 && jTypeInstructions.contains(element[0]) == true){
          List<String> answer = [];
          for(int i = 0; i < element.length; i++){
            if(i == element.length - 1 || i == 0){
              answer.add(element[i]);
            }else{
              answer.add(element[i] + ",");
            }
          }
          output.add("Invalid number of operands at instruction: " + answer.join(' '));
        }



        if(element.length == 4 && bTypeInstructions.contains(element[0]) == true){ //checando por possiveis erros em instrucoes type-B: registradores invalidos ou labels inexistentes.
          if(registerNames.containsKey(element[1]) == false || registerNames.containsKey(element[2]) == false){
            List<String> answer = [];
            for(int i = 0; i < element.length; i++){
              if(i == element.length - 1 || i == 0){
                answer.add(element[i]);
              }else{
                answer.add(element[i] + ",");
              }
            }
            output.add("Invalid register at instruction: " + answer.join(' '));
          }
          if(labelsAddress.containsKey(element[3] + ":") == false){ //Estou tentando pular para uma label que nao existe no codigo. ERRO.
            List<String> answer = [];
            for(int i = 0; i < element.length; i++){
              if(i == element.length - 1 || i == 0){
                answer.add(element[i]);
              }else{
                answer.add(element[i] + ",");
              }
            }
            output.add("Invalid label at instruction: " + answer.join(' '));
          }
        }else if(element.length != 4 && bTypeInstructions.contains(element[0]) == true){
          List<String> answer = [];
          for(int i = 0; i < element.length; i++){
            if(i == element.length - 1 || i == 0){
              answer.add(element[i]);
            }else{
              answer.add(element[i] + ",");
            }
          }
          output.add("Invalid number of operands at instruction: " + answer.join(' '));
        }



        if(element.length == 4 && iTypeInstructions.contains(element[0]) == true){ //checando por possiveis erros em instrucoes type-I: registradores invalidos ou labels inexistentes.
          //Tem que filtrar mais as instrucoes do type-I
          if(iTypeImmInstructions.contains(element[0])){ //addi, slti, sltiu, xori, ori, andi
            if(registerNames.containsKey(element[1]) == false || registerNames.containsKey(element[2]) == false){ //testando registradores invalidos
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
            try{ //checando por immediatos invalidos: nessas instrucoes, os immediatos devem estar dentro do range: [-2048 , 2047]
              int valorImm = int.parse(element[3], radix: 10);
              if(valorImm < -2048 || valorImm > 2047){
                List<String> answer = [];
                for(int i = 0; i < element.length; i++){
                  if(i == element.length - 1 || i == 0){
                    answer.add(element[i]);
                  }else{
                    answer.add(element[i] + ",");
                  }
                }
                output.add("Invalid immediate (out of range) at instruction: " + answer.join(' '));
              }
            }catch(e){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                  if(i == element.length - 1 || i == 0){
                    answer.add(element[i]);
                  }else{
                    answer.add(element[i] + ",");
                  }
                }
              output.add("Invalid immediate (not a number) at instruction: " + answer.join(' '));
            }
          }else if(iTypeShiftInstructions.contains(element[0])){ //slli, srli, srai
            if(registerNames.containsKey(element[1]) == false || registerNames.containsKey(element[2]) == false){ //testando registradores invalidos
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                  if(i == element.length - 1 || i == 0){
                    answer.add(element[i]);
                  }else{
                    answer.add(element[i] + ",");
                  }
                }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
            try{ //checando por immediatos invalidos: nessas instrucoes, os immediatos devem estar dentro do range: [0 , 31]
              int valorImm = int.parse(element[3], radix: 10);
              if(valorImm < 0 || valorImm > 31){
                List<String> answer = [];
                for(int i = 0; i < element.length; i++){
                  if(i == element.length - 1 || i == 0){
                    answer.add(element[i]);
                  }else{
                    answer.add(element[i] + ",");
                  }
                }
                output.add("Invalid immediate (out of range) at instruction: " + answer.join(' '));
              }
            }catch(e){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid immediate (not a number) at instruction: " + answer.join(' '));
            }
          }else if(iTypeLoadInstructions.contains(element[0])){ //lb, lh, lw, lbu, lhu
            if(registerNames.containsKey(element[1]) == false || registerNames.containsKey(element[3]) == false){ //testando registradores invalidos
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
            try{ //checando por immediatos invalidos: nessas instrucoes, os immediatos devem estar dentro do range: [-2048 , 2047]
              int valorImm = int.parse(element[2], radix: 10);
              if(valorImm < -2048 || valorImm > 2047){
                List<String> answer = [];
                for(int i = 0; i < element.length; i++){
                  if(i == element.length - 1 || i == 0){
                    answer.add(element[i]);
                  }else{
                    answer.add(element[i] + ",");
                  }
                }
                output.add("Invalid immediate (out of range) at instruction: " + answer.join(' '));
              }
            }catch(e){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid immediate (not a number) at instruction: " + answer.join(' '));
            }
          }else if(iTypeJumpInstructions.contains(element[0])){ //jalr
            if(registerNames.containsKey(element[1]) == false || registerNames.containsKey(element[3]) == false){ //testando registradores invalidos
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid register at instruction: " + answer.join(' '));
            }
            try{ //checando por immediatos invalidos: nessas instrucoes, os immediatos devem estar dentro do range: [-2048 , 2047]
              int valorImm = int.parse(element[2], radix: 10);
              if(valorImm < -2048 || valorImm > 2047){
                List<String> answer = [];
                for(int i = 0; i < element.length; i++){
                  if(i == element.length - 1 || i == 0){
                    answer.add(element[i]);
                  }else{
                  answer.add(element[i] + ",");
                  }
                }
                output.add("Invalid immediate (out of range) at instruction: " + answer.join(' '));
              }
            }catch(e){
              List<String> answer = [];
              for(int i = 0; i < element.length; i++){
                if(i == element.length - 1 || i == 0){
                  answer.add(element[i]);
                }else{
                  answer.add(element[i] + ",");
                }
              }
              output.add("Invalid immediate (not a number) at instruction: " + answer.join(' '));
            }
          }
        }else if(element.length != 4 && iTypeInstructions.contains(element[0]) == true){
          List<String> answer = [];
          for(int i = 0; i < element.length; i++){
            if(i == element.length - 1 || i == 0){
              answer.add(element[i]);
            }else{
              answer.add(element[i] + ",");
            }
          }
          output.add("Invalid number of operands at instruction: " + answer.join(' '));
        }
      }
    }
    }catch(e){
      print(e);
    }
    return output;
  }

}
