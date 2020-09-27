// Vulcan is a software developed by:
// Victor Miguel de Morais Costa.
// License: MIT.
import 'dart:math';

class Processor{
  //Ponteiros fixados para os segmentos de memoria.
  final int reserved = 0;
  final int text = 400;
  final int staticData = 200400;
  final int heap = 400400;
  final int initialStack = 999986;

  //Registradores e memoria.
  List<int> integerRegisters = [];  //List de tamanho 32. Cada elemento da lista representa um dos 32 registradores inteiros do RISC-V.
  List<double> floatingpointRegisters = []; //List de tamanho 32. Cada elemento da lista representa um dos 32 registradores de ponto-flutuante do RISC-V.
  List<String> memory; //List de tamanho 999_992. Cada elemento eh uma string de tamanho 8 (8 bits = 1 byte). Isso acontece pq a memoria eh enderacada por byte.
  List<bool> reservedMemory; //List utilizada para realizarmos as operacoes atomicas de load e de store.
  int pc = 400;
  int floatingPointControlRegister = 0; //Registrador de controle para a extensao de ponto flutuante.

  //Construtor da Classe
  Processor(){
    this.integerRegisters = List<int>.filled(32, 0, growable: false);
    this.floatingpointRegisters = List<double>.filled(32, 0.0, growable: false);
    this.memory = List<String>.filled(999987, '00000000', growable: false); //999_987
    this.reservedMemory = List<bool>.filled(999987, false, growable: false); //999_887
    this.integerRegisters[2] = 999986; //registrador x2(sp) funciona como o ponteiro de pilha.
    this.integerRegisters[3] = 200400; //registrador x3 aponta para os dados estaticos (static data).
  }

  //Funcao abaixo executa o seguinte: Dado uma List<String> machineCode, ela vai carregar as instrucoes na memoria
  //seguindo a convencao Little-Endian
  void loadInstructionsInMemory(List<String> machineCode){
    int cursor = pc;
    for(int i = 0; i < machineCode.length; i++){
      //Peguei a instrucao em formato binario.
      String currentInstruction = machineCode[i];
      //Agora tenho que quebrar a instrucao em 4 partes. Cada parte com 8 caracteres( representando os 8 bits) e carregar essas partes na memoria, seguindo a convencao Little-Endian
      //Little-Endian: Bits menos significativos ficam nos enderecos menores.
      memory[cursor] = currentInstruction.substring(24);
      memory[cursor + 1] = currentInstruction.substring(16, 24);
      memory[cursor + 2] = currentInstruction.substring(8, 16);
      memory[cursor + 3] = currentInstruction.substring(0, 8);
      cursor = cursor + 4;
    }
    return;
  }


  String fetchInstruction(int pc){
    String result = memory[pc + 3] + memory[pc + 2] + memory[pc + 1] + memory[pc];
    return result;
  }

  void decodeAndExecute(String instruction, Map<String,int> labelsAddress){
    //Para fazer o decode da instrução, a gente tem que olhar primeiro para o opcode dela.
    //O opcode de uma instrucao de 32 bits sao sempre os ultimos 7 bits (7 bits menos significativos): [6..0]

    /////////////////////////
    // TYPE-R INSTRUCTIONS //
    /////////////////////////
    if(instruction.substring(25) == '0110011' && (instruction.substring(0, 7) == "0000000" || instruction.substring(0, 7) == "0100000")){ //TYPE-R Instructions: add, sub, and, or, xor, slt, sltu, srl, sll, sra.
      //para diferenciar as instrucoes type-R do RV32I a gente vai usar os campos funct3 e funct7.
      if(instruction.substring(17, 20) == '000'){ //add ou sub
        if(instruction.substring(0, 7) == '0000000'){ //add
          //register[rd] = register[rs1] + register[rs2]
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] + integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == '0100000'){ //sub
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] - integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
          pc = pc + 4;
        }
      }else if(instruction.substring(17, 20) == '001'){ //sll
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        if(integerRegisters[rs2] < 0){
          integerRegisters[rd] = 0;
        }else{
        integerRegisters[rd] = integerRegisters[rs1] << integerRegisters[rs2];
        }
        pc = pc + 4;
      }else if(instruction.substring(17, 20) == '010'){ //slt
        if(integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] < integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)]){
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = 1;
        }else{
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = 0;
        }
        pc = pc + 4;
      }else if(instruction.substring(17, 20) == '011'){ //sltu
        int rs1 = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)];
        int rs2 = integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
        if(rs1.toUnsigned(32) < rs2.toUnsigned(32)){
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = 1;
        }else{
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = 0;
        }
        pc = pc + 4;
      }else if(instruction.substring(17, 20) == '100'){ //xor
        integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] ^ integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
        pc = pc + 4;
      }
      else if(instruction.substring(17, 20) == '101'){ //srl ou sra
        if(instruction.substring(0, 7) == '0000000'){ //srl
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
          if(integerRegisters[rs2] < 0){
            integerRegisters[rd] = 0;
          }else{
            integerRegisters[rd] = integerRegisters[rs1] >> integerRegisters[rs2];
          }
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == '0100000'){ //sra
          //A funcao sra realiza uma divisao por 2^n (mesmo o dividendo sendo positivo ou negativo).
          int rs1 = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)];
          int rs2 = integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
          try{
            if(integerRegisters[rs1] < 0){
              integerRegisters[rs1] = integerRegisters[rs1] * (-1);
              if(integerRegisters[rs2] < 0){
                integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = 0;
              }else{
                int almost = integerRegisters[rs1] >> integerRegisters[rs2];
                integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = almost * (-1);
              }
            }else{
              if(integerRegisters[rs2] < 0){
                integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = 0;
              }else{
                integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] >> integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
              }
            }
          }catch(e){
            print(e);
          }
          pc = pc + 4;
        }
      }
      else if(instruction.substring(17, 20) == '110'){ //or
        integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] | integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
        pc = pc + 4;
      }else if(instruction.substring(17, 20) == '111'){ //and
        integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] & integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
        pc = pc + 4;
      }
    }

    /////////////////////////
    // RV32M  INSTRUCTIONS //
    /////////////////////////
    // mul, mulh, mulhsu, mulhu, div, divu, rem, remu
    else if(instruction.substring(25) == "0110011" && instruction.substring(0, 7) == "0000001"){
      if(instruction.substring(17, 20) == "000"){ //mul
        int rd = int.parse(instruction.substring(20, 25) , radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        integerRegisters[rd] = (integerRegisters[rs1] * integerRegisters[rs2]) & 0xFFFFFFFF;
        pc = pc + 4;
      }else if(instruction.substring(17, 20) == "001"){ //mulh
        int signal = 1;
        int rd = int.parse(instruction.substring(20, 25) , radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        BigInt almost = BigInt.from(integerRegisters[rs1]) * BigInt.from(integerRegisters[rs2]);
        almost = almost >> 32;
        integerRegisters[rd] = almost.toInt();
        pc = pc + 4;
      }else if(instruction.substring(17, 20) == "010"){ //mulhsu
        int rd = int.parse(instruction.substring(20, 25) , radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        BigInt almost = BigInt.from(integerRegisters[rs1]) * BigInt.from(integerRegisters[rs2].toUnsigned(32));
        almost = almost >> 32;
        integerRegisters[rd] = almost.toInt();
        pc = pc + 4;
      }else if(instruction.substring(17, 20) == "011"){ //mulhu
        int rd = int.parse(instruction.substring(20, 25) , radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        BigInt almost = BigInt.from(integerRegisters[rs1].toUnsigned(32)) * BigInt.from(integerRegisters[rs2].toUnsigned(32));
        almost = almost >> 32;
        integerRegisters[rd] = almost.toInt();
        pc = pc + 4;
      }else if(instruction.substring(17, 20) == "100"){ //div
        int rd = int.parse(instruction.substring(20, 25) , radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        if(integerRegisters[rs2] == 0){ //Divisao por zero nao pode.
          integerRegisters[rd] = 0;
        }else{
          integerRegisters[rd] = integerRegisters[rs1] ~/ integerRegisters[rs2];  //  ~/ -> Simbolo de divisao inteira.
        }
        pc = pc + 4;
      }else if(instruction.substring(17, 20) == "101"){ //divu
        int rd = int.parse(instruction.substring(20, 25) , radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        if(integerRegisters[rs2] == 0){
          integerRegisters[rd] = 0;
        }else {
          integerRegisters[rd] = (integerRegisters[rs1].toUnsigned(32)) ~/ (integerRegisters[rs2].toUnsigned(32));
        }
        pc = pc + 4;
      }else if(instruction.substring(17, 20) == "110"){ //rem
        int rd = int.parse(instruction.substring(20, 25) , radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        if(integerRegisters[rs2] == 0){
          integerRegisters[rd] = 0;
        }else{
          integerRegisters[rd] = integerRegisters[rs1] % integerRegisters[rs2];
        }
        pc = pc + 4;
      }else if(instruction.substring(17, 20) == "111"){ //remu
        int rd = int.parse(instruction.substring(20, 25) , radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        if(integerRegisters[rs2] == 0){
          integerRegisters[rd] = 0;
        }else{
          integerRegisters[rd] = integerRegisters[rs1].toUnsigned(32) % integerRegisters[rs2].toUnsigned(32);
        }
        pc = pc + 4;
      }
    }


    /////////////////////////
    // RV32A  INSTRUCTIONS //
    /////////////////////////
    // lr.w, sc.w, amoswap.w, amoadd.w, amoxor.w, amoand.w, amoor.w, amomin.w, amomax.wm amominu.w, amomaxu.w
    else if(instruction.substring(25) == "0101111" && instruction.substring(17, 20) == "010"){
      if(instruction.substring(0, 5) == "00010"){ //lr.w
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        int address = integerRegisters[rs1];
        integerRegisters[rd] = getNumberFromBinaryTwoComplement(getWordFromMemory(address));
        reservedMemory[address] = true;
        pc = pc + 4;
      }else if(instruction.substring(0, 5) == "00011"){ //sc.w
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        if(reservedMemory[integerRegisters[rs1]] == true){
          loadWordIntoMemory(integerRegisters[rs2], integerRegisters[rs1]);
          integerRegisters[rd] = 0; //CODIGO DE OKAY PARA STORE ATOMICO BEM-SUCEDIDO
        }
        else{
          integerRegisters[rd] = -1; //CODIGO DE ERRO PARA STORE ATOMICO MAL-SUCEDIDO
        }
        pc = pc + 4;
      }else if(instruction.substring(0, 5) == "00001"){ //amoswap.w
        // int rd = int.parse(instruction.substring(20, 25) , radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        String almostT = getWordFromMemory(integerRegisters[rs1]);
        int t = getNumberFromBinaryTwoComplement(almostT);
        loadWordIntoMemory(integerRegisters[rs2], integerRegisters[rs1]);
        integerRegisters[rd] = t;
        pc = pc + 4;
      }else if(instruction.substring(0, 5) == "00000"){ //amoadd.w
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        String almostT = getWordFromMemory(integerRegisters[rs1]);
        int t = getNumberFromBinaryTwoComplement(almostT);
        loadWordIntoMemory(t + integerRegisters[rs2], integerRegisters[rs1]);
        integerRegisters[rd] = t;
        pc = pc + 4;
      }else if(instruction.substring(0, 5) == "00100"){ //amoxor.w
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        String almostT = getWordFromMemory(integerRegisters[rs1]);
        int t = getNumberFromBinaryTwoComplement(almostT);
        loadWordIntoMemory(t ^ integerRegisters[rs2], integerRegisters[rs1]);
        integerRegisters[rd] = t;
        pc = pc + 4;
      }else if(instruction.substring(0, 5) == "01100"){ //amoand.w
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        String almostT = getWordFromMemory(integerRegisters[rs1]);
        int t = getNumberFromBinaryTwoComplement(almostT);
        loadWordIntoMemory(t & integerRegisters[rs2], integerRegisters[rs1]);
        integerRegisters[rd] = t;
        pc = pc + 4;
      }else if(instruction.substring(0, 5) == "01000"){ //amoor.w
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        String almostT = getWordFromMemory(integerRegisters[rs1]);
        int t = getNumberFromBinaryTwoComplement(almostT);
        loadWordIntoMemory(t | integerRegisters[rs2], integerRegisters[rs1]);
        integerRegisters[rd] = t;
        pc = pc + 4;
      }else if(instruction.substring(0, 5) == "10000"){ //amomin.w
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        String almostT = getWordFromMemory(integerRegisters[rs1]);
        int t = getNumberFromBinaryTwoComplement(almostT);
        loadWordIntoMemory(min(t, integerRegisters[rs2]), integerRegisters[rs1]);
        integerRegisters[rd] = t;
        pc = pc + 4;
      }else if(instruction.substring(0, 5) == "10100"){ //amomax.w
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        String almostT = getWordFromMemory(integerRegisters[rs1]);
        int t = getNumberFromBinaryTwoComplement(almostT);
        loadWordIntoMemory(max(t, integerRegisters[rs2]), integerRegisters[rs1]);
        integerRegisters[rd] = t;
        pc = pc + 4;
      }else if(instruction.substring(0, 5) == "11000"){ //amominu.w
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        String almostT = getWordFromMemory(integerRegisters[rs1]);
        int t = getNumberFromBinaryTwoComplement(almostT);
        int answer = min(t.toUnsigned(32), integerRegisters[rs2].toUnsigned(32));
        int answer2 = answer.toInt();
        loadWordIntoMemory(answer2, integerRegisters[rs1]);
        integerRegisters[rd] = t;
        pc = pc + 4;
      }else if(instruction.substring(0, 5) == "11100"){ //amomaxu.w
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        String almostT = getWordFromMemory(integerRegisters[rs1]);
        int t = getNumberFromBinaryTwoComplement(almostT);
        int answer = max(t.toUnsigned(32), integerRegisters[rs2].toUnsigned(32));
        int answer2 = answer.toInt();
        loadWordIntoMemory(answer2, integerRegisters[rs1]);
        integerRegisters[rd] = t;
        pc = pc + 4;
      }
    }
    

    /////////////////////////
    /// RV32F INSTRUCTIONS //
    /////////////////////////
    else if(instruction.substring(25) == "0000111" || instruction.substring(25) == "0100111" || instruction.substring(25) == "1000011" || instruction.substring(25) == "1000111" || instruction.substring(25) == "1001011" || instruction.substring(25) == "1001111" || instruction.substring(25) == "1010011"){
      print("dale porra");
      if(instruction.substring(25) == "0000111" && instruction.substring(17, 20) == "010"){ //flw
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        String imm = instruction.substring(0, 12);
        int immediate = getNumberFromBinaryTwoComplement(imm);
        int address = immediate + integerRegisters[rs1];
        String fpString = getWordFromMemory(address);
        floatingpointRegisters[rd] = convertFPStringToNumber(fpString);
        pc = pc + 4;
      }else if(instruction.substring(25) == "0100111" && instruction.substring(17, 20) == "010"){ //fsw
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        String imm115 = instruction.substring(0, 7);
        String imm40 = instruction.substring(20, 25);
        String imm = imm115 + imm40;
        int immediate = getNumberFromBinaryTwoComplement(imm);
        int address = integerRegisters[rs1] + immediate;
        String value = generateStringFromFloatingPoint(floatingpointRegisters[rs2]);
        if(address < 0 || address >= 999987){
          pc = pc + 4;
          return;
        }
        memory[address] = value.substring(24);
        memory[address + 1] = value.substring(16, 24);
        memory[address + 2] = value.substring(8, 16);
        memory[address + 3] = value.substring(0, 8);
        pc = pc + 4;
      }else if(instruction.substring(25) == "1000011" && instruction.substring(5, 7) == "00"){ //fmadd.s
        int rs3 = int.parse(instruction.substring(0, 5), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        floatingpointRegisters[rd] = (floatingpointRegisters[rs1] * floatingpointRegisters[rs2]) + floatingpointRegisters[rs3];
        pc = pc + 4;
      }else if(instruction.substring(25) == "1000111" && instruction.substring(5, 7) == "00"){ //fmsub.s        
        int rs3 = int.parse(instruction.substring(0, 5), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        floatingpointRegisters[rd] = (floatingpointRegisters[rs1] * floatingpointRegisters[rs2]) - floatingpointRegisters[rs3];
        pc = pc + 4;
      }else if(instruction.substring(25) == "1001011" && instruction.substring(5, 7) == "00"){ //fnmsub.s
        int rs3 = int.parse(instruction.substring(0, 5), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        floatingpointRegisters[rd] = -(floatingpointRegisters[rs1] * floatingpointRegisters[rs2]) + floatingpointRegisters[rs3];
        pc = pc + 4;
      }else if(instruction.substring(25) == "1001111" && instruction.substring(5, 7) == "00"){ //fnmadd.s
        int rs3 = int.parse(instruction.substring(0, 5), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        floatingpointRegisters[rd] = -(floatingpointRegisters[rs1] * floatingpointRegisters[rs2]) - floatingpointRegisters[rs3];
        pc = pc + 4;
      }else if(instruction.substring(25) == "1010011"){ // the rest of the instructions...
        if(instruction.substring(0, 7) == "0000000"){ //fadd.s
          print("entrei no fadd.s");
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12) , radix: 2);
          floatingpointRegisters[rd] = floatingpointRegisters[rs1] + floatingpointRegisters[rs2];
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "0000100"){ // fsub.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12) , radix: 2);
          floatingpointRegisters[rd] = floatingpointRegisters[rs1] - floatingpointRegisters[rs2];
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "0001000"){ //fmul.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12) , radix: 2);
          floatingpointRegisters[rd] = floatingpointRegisters[rs1] * floatingpointRegisters[rs2];
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "0001100"){ //fdiv.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12) , radix: 2);
          if(floatingpointRegisters[rs2] == 0){
            floatingpointRegisters[rd] = 0;
          }else{
            floatingpointRegisters[rd] = floatingpointRegisters[rs1] / floatingpointRegisters[rs2];
          }
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "0101100" && instruction.substring(7, 12) == "00000"){ //fsqrt.s
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          floatingpointRegisters[rd] = sqrt(floatingpointRegisters[rs1]);
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "0010100" && instruction.substring(17, 20) == "000"){ //fmin.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
          floatingpointRegisters[rd] = min(floatingpointRegisters[rs1], floatingpointRegisters[rs2]);
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "0010100" && instruction.substring(17, 20) == "001"){ //fmax.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
          floatingpointRegisters[rd] = max(floatingpointRegisters[rs1], floatingpointRegisters[rs2]);
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "1010000" && instruction.substring(17, 20) == "010"){ //feq.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
          if(floatingpointRegisters[rs1] == floatingpointRegisters[rs2]){
            integerRegisters[rd] = 1;
          }else{
            integerRegisters[rd] = 0;
          }
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "1010000" && instruction.substring(17, 20) == "000"){ //fle.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
          if(floatingpointRegisters[rs1] <= floatingpointRegisters[rs2]){
            integerRegisters[rd] = 1;
          }else{
            integerRegisters[rd] = 0;
          }
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "1010000" && instruction.substring(17, 20) == "001"){ //flt.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
          if(floatingpointRegisters[rs1] < floatingpointRegisters[rs2]){
            integerRegisters[rd] = 1;
          }else{
            integerRegisters[rd] = 0;
          }
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "1101000" && instruction.substring(7, 12) == "00000"){ //fcvt.s.w
          print("entrei no fcvt.s.w");
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          floatingpointRegisters[rd] = integerRegisters[rs1].toDouble();
          print("fp-register[${rd}]: ${floatingpointRegisters[rd]}");
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "1101000" && instruction.substring(7, 12) == "00001"){ //fcvt.s.wu
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          floatingpointRegisters[rd] = integerRegisters[rs1].abs().toDouble();
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "1111000" && instruction.substring(7, 12) == "00000" && instruction.substring(17, 20) == "000"){ //fmv.w.x
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          floatingpointRegisters[rd] = integerRegisters[rs1].toDouble();
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "1100000" && instruction.substring(7, 12) == "00000"){ //fcvt.w.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          integerRegisters[rd] = floatingpointRegisters[rs1].round();
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "1100000" && instruction.substring(7, 12) == "00001"){ //fcvt.wu.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          integerRegisters[rd] = floatingpointRegisters[rs1].abs().round();
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "1110000" && instruction.substring(7, 12) == "00000" && instruction.substring(17, 20) == "000"){ //fmv.x.w
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          integerRegisters[rd] = floatingpointRegisters[rs1].round();
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "1110000" && instruction.substring(7, 12) == "00000" && instruction.substring(17, 20) == "001"){ //fclass.s
          //Nao faco ideia de como implementar isso daqui XD
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "0010000" && instruction.substring(17, 20) == "000"){ //fsgnj.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
          String valueOfRs1 = generateStringFromFloatingPoint(floatingpointRegisters[rs1]);
          String valueOfRs2 = generateStringFromFloatingPoint(floatingpointRegisters[rs2]);
          String valueOfRd = valueOfRs2[0] + valueOfRs1.substring(1);
          floatingpointRegisters[rd] = convertFPStringToNumber(valueOfRd);
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "0010000" && instruction.substring(17, 20) == "001"){ //fsgnjn.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
          String valueOfRs1 = generateStringFromFloatingPoint(floatingpointRegisters[rs1]);
          String valueOfRs2 = generateStringFromFloatingPoint(floatingpointRegisters[rs2]);
          String valueOfRd = "";
          if(valueOfRs2[0] == "0"){
            valueOfRd = "1" + valueOfRs1.substring(1);
          }else if(valueOfRs2[0] == "1"){
            valueOfRd = "0" + valueOfRs1.substring(1);
          }
          floatingpointRegisters[rd] = convertFPStringToNumber(valueOfRd);
          pc = pc + 4;
        }else if(instruction.substring(0, 7) == "0010000" && instruction.substring(17, 20) == "010"){ //fsgnjx.s
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
          String valueOfRs1 = generateStringFromFloatingPoint(floatingpointRegisters[rs1]);
          String valueOfRs2 = generateStringFromFloatingPoint(floatingpointRegisters[rs2]);
          int xorResult = int.parse(valueOfRs1[0], radix: 10) ^ int.parse(valueOfRs2[0], radix: 10);
          String valueOfRd = xorResult.toRadixString(2) + valueOfRs1.substring(1);
          floatingpointRegisters[rd] = convertFPStringToNumber(valueOfRd);
          pc = pc + 4;
        }
      }
    }


    /////////////////////////
    // TYPE-U INSTRUCTIONS //
    /////////////////////////
    else if(instruction.substring(25) == '0110111' || instruction.substring(25) == '0010111'){ //TYPE-U INSTRUCTIONS: lui e auipc, respectivamente.
      if(instruction.substring(25) == '0110111'){ //lui
      //Aparentemente a instrucao lui nao aceita imediatos menores que zero.
      //Os imediatos da instrucao lui apresentam 20 bits. Eles apresentam o seguinte range: 0, pow(2, 20) - 1.
        integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = (int.parse(instruction.substring(0, 20), radix: 2) << 12);
        pc = pc + 4;
      }else if(instruction.substring(25) == '0010111'){ //auipc
      //Aparentemente a instrucao auipc nao aceita imediatos menores que zero.
      //Os imediatos da instrucao auipc apresentam 20 bits. Eles apresentam o seguinte range: 0, pow(2, 20) - 1.
        integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = pc + (int.parse(instruction.substring(0, 20), radix: 2) << 12);
        pc = pc + 4;
      }
    }

    /////////////////////////
    // TYPE-I INSTRUCTIONS //
    /////////////////////////
    else if(instruction.substring(25) == '0010011'){ //TYPE-I INSTRUCTIONS: addi, slti, sltiu, xori, ori, andi, slli, srli, srai.
        if(instruction.substring(17, 20) == '000'){ //addi
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
          integerRegisters[rd] = integerRegisters[rs1] + immediate;
          pc = pc + 4; 
        }
        else if(instruction.substring(17, 20) == '010'){ //slti
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
          if(integerRegisters[rs1] < immediate){
            integerRegisters[rd] = 1;
          }else{
            integerRegisters[rd] = 0;
          }
          pc = pc + 4;
        }
        else if(instruction.substring(17, 20) == '011'){ //sltiu
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
          if(BigInt.from(integerRegisters[rs1]).toUnsigned(12) < BigInt.from(immediate).toUnsigned(12)){
            integerRegisters[rd] = 1;
          }else{
            integerRegisters[rd] = 0;
          }
          pc = pc + 4;
        }
        else if(instruction.substring(17, 20) == '100'){ //xori
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
          integerRegisters[rd] = integerRegisters[rs1] ^ immediate;
          pc = pc + 4;
        }
        else if(instruction.substring(17, 20) == '110'){ //ori
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
          integerRegisters[rd] = integerRegisters[rs1] | immediate;
          pc = pc + 4;
        }
        else if(instruction.substring(17, 20) == '111'){ //andi
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
          integerRegisters[rd] = integerRegisters[rs1] & immediate;
          pc = pc + 4;
        }
        else if(instruction.substring(17, 20) == '001'){ //slli --> SO TRABALHA COM IMEDIATOS NAO-NEGATIVOS
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = int.parse(instruction.substring(7, 12), radix: 2);
          print("immediate sll: $immediate");
          if(immediate >= 0){
            integerRegisters[rd] = (integerRegisters[rs1] << immediate) & 0xFFFFFFFF;
          }else{
            integerRegisters[rd] = 0;
          }
          pc = pc + 4;
        }
        else if(instruction.substring(17, 20) == '101'){ //srli ou srai --> SO TRABALHA COM IMEDIATOS NAO-NEGATIVOS
          if(instruction.substring(0, 7) == '0000000'){ //srli
            //Como o srli faz extensao de 0. Eu tenho que deixar o operando mais a esquerda na notacao unsigned (sem sinal).
            int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
            int rd = int.parse(instruction.substring(20, 25), radix: 2);
            int immediate = int.parse(instruction.substring(7, 12), radix: 2);
            if(immediate >= 0){
              integerRegisters[rd] = ((integerRegisters[rs1]).toUnsigned(32) >> immediate);
            }else{
              integerRegisters[rd] = 0;
            }
            pc = pc + 4;
          }else if(instruction.substring(0, 7) == '0100000'){ //srai
            //Como o srai faz extensao de sinal, eu nao preciso me preocupar com a conversao para unsigned. posso deixar do jeito que ta.
            int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
            int rd = int.parse(instruction.substring(20, 25), radix: 2);
            int immediate = int.parse(instruction.substring(7, 12), radix: 2);
            if(immediate >= 0){
              integerRegisters[rd] = (integerRegisters[rs1] >> immediate);
            }else{
              integerRegisters[rd] = 0;
            }
            pc = pc + 4;
          }
        }
    }
    else if(instruction.substring(25) == '0000011'){ //TYPE-I INSTRUCTIONS: lb, lh, lw, lbu, lhu.
      //Agora tem que fazer a filtragem por meio do funct3
      if(instruction.substring(17, 20) == '000'){ //lb
        //No caso da instrucao "lb", a gente extende o valor carregado com sinal.
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
        int address = integerRegisters[rs1] + immediate;
        integerRegisters[rd] = getNumberFromBinaryTwoComplement(getByteFromMemory(address));
        pc = pc + 4;
      }
      else if(instruction.substring(17, 20) == '001'){ //lh
        //No caso da instrucao "lh", a gente extende o valor carregado com sinal.
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
        int address = integerRegisters[rs1] + immediate;
        integerRegisters[rd] = getNumberFromBinaryTwoComplement(getHalfWordFromMemory(address));
        pc = pc + 4;
      }
      else if(instruction.substring(17, 20) == '010'){ //lw
        //No caso da instrucao "lw", a gente extende o valor carregado com sinal.
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
        int address = integerRegisters[rs1] + immediate;
        integerRegisters[rd] = getNumberFromBinaryTwoComplement(getWordFromMemory(address));
        pc = pc + 4;
      }
      else if(instruction.substring(17, 20) == '100'){ //lbu
        //No caso da instrucao "lbu", a gente extende o valor carregado sem sinal.
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
        int address = integerRegisters[rs1] + immediate;
        integerRegisters[rd] = int.parse(getByteFromMemory(address), radix: 2);
        pc = pc + 4;
      }
      else if(instruction.substring(17, 20) == '101'){ //lhu
        //No caso da instrucao "lhu", a gente extende o valor carregado com sinal.
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
        int address = integerRegisters[rs1] + immediate;
        integerRegisters[rd] = int.parse(getHalfWordFromMemory(address), radix: 2);
        pc = pc + 4;
      }
    }
    else if(instruction.substring(25) == '1100111'){ //TYPE-I INSTRUCTIONS: jalr.
      int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
      int rd = int.parse(instruction.substring(20, 25), radix: 2);
      int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
      integerRegisters[rd] = pc + 4;
      pc = immediate + integerRegisters[rs1] + 400;
    }

    /////////////////////////
    // TYPE-S INSTRUCTIONS //
    /////////////////////////
    else if(instruction.substring(25) == '0100011'){ //TYPE-S INSTRUCTIONS: sb, sh, sw.
      //Agora tem que filtrar pelo campo funct3.
      if(instruction.substring(17, 20) == "000"){ //sb
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        String imm = instruction.substring(0, 7) + instruction.substring(20, 25);
        int immediate = getNumberFromBinaryTwoComplement(imm);
        int address = integerRegisters[rs1] + immediate;
        int numberToBeStored = (integerRegisters[rs2] & 0xFF); //pegando o byte.
        String almost = BigInt.from(numberToBeStored).toUnsigned(8).toRadixString(2);
        if(almost.length == 8){
          memory[address] = almost;
        }else if(almost.length < 8){
          memory[address] = ('0' * (8 - almost.length)) + almost;
        }
        pc = pc + 4;
      }
      else if(instruction.substring(17, 20) == "001"){ //sh
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        String imm = instruction.substring(0, 7) + instruction.substring(20, 25);
        int immediate = getNumberFromBinaryTwoComplement(imm);
        int address = integerRegisters[rs1] + immediate;
        int numberToBeStored = (integerRegisters[rs2] & 0xFFFF); //pegando a halfword.
        String almost = BigInt.from(numberToBeStored).toUnsigned(16).toRadixString(2);
        if(almost.length == 16){
          memory[address] = almost.substring(8, 16);
          memory[address + 1] = almost.substring(0, 8);
        }else if(almost.length < 16){
          almost = ('0' * (16 - almost.length)) + almost;
          memory[address] = almost.substring(8, 16);
          memory[address + 1] = almost.substring(0, 8);
        }
        pc = pc + 4;
        //print(memory[1] + memory[0]);
      }
      else if(instruction.substring(17, 20) == "010"){ //sw
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        String imm = instruction.substring(0, 7) + instruction.substring(20, 25);
        int immediate = getNumberFromBinaryTwoComplement(imm);
        int address = integerRegisters[rs1] + immediate;
        int numberToBeStored = (integerRegisters[rs2] & 0xFFFFFFFF); //pegando a word.
        String almost = BigInt.from(numberToBeStored).toUnsigned(32).toRadixString(2);
        if(almost.length == 32){
          memory[address] = almost.substring(24, 32);
          memory[address + 1] = almost.substring(16, 24);
          memory[address + 2] = almost.substring(8, 16);
          memory[address + 3] = almost.substring(0, 8);
        }else if(almost.length < 32){
          almost = ('0' * (32 - almost.length)) + almost;
          memory[address] = almost.substring(24, 32);
          memory[address + 1] = almost.substring(16, 24);
          memory[address + 2] = almost.substring(8, 16);
          memory[address + 3] = almost.substring(0, 8);
        }
        pc = pc + 4;
        //print(memory[3] + memory[2] + memory[1] + memory[0]);
      }
    }

    /////////////////////////
    // TYPE-B INSTRUCTIONS //
    /////////////////////////
    else if(instruction.substring(25) == '1100011'){ //TYPE-B INSTRUCTIONS: beq, bne, blt, bge, bltu, bgeu.
      if(instruction.substring(17, 20) == '000'){ //beq
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        String imm = instruction[0] + instruction[24] + instruction.substring(1, 7) + instruction.substring(20, 24);
        int immediate = getNumberFromBinaryTwoComplement(imm);
        print("endereco recebido para o beq: $immediate");
        if(integerRegisters[rs1] == integerRegisters[rs2]){
          pc = immediate;
        }else{
          pc = pc + 4;
        }
      }
      else if(instruction.substring(17, 20) == '001'){ //bne
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        String imm = instruction[0] + instruction[24] + instruction.substring(1, 7) + instruction.substring(20, 24);
        int immediate = getNumberFromBinaryTwoComplement(imm);
        if(integerRegisters[rs1] != integerRegisters[rs2]){
          pc = immediate;
        }else{
          pc = pc + 4;
        }
      }
      else if(instruction.substring(17, 20) == '100'){ //blt
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        String imm = instruction[0] + instruction[24] + instruction.substring(1, 7) + instruction.substring(20, 24);
        int immediate = getNumberFromBinaryTwoComplement(imm);
        if(integerRegisters[rs1] < integerRegisters[rs2]){
          pc = immediate;
        }else{
          pc = pc + 4;
        }
      }
      else if(instruction.substring(17, 20) == '101'){ //bge
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        String imm = instruction[0] + instruction[24] + instruction.substring(1, 7) + instruction.substring(20, 24);
        int immediate = getNumberFromBinaryTwoComplement(imm);
        if(integerRegisters[rs1] >= integerRegisters[rs2]){
          pc = immediate;
        }else{
          pc = pc + 4;
        }
      }
      else if(instruction.substring(17, 20) == '110'){ //bltu
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        String imm = instruction[0] + instruction[24] + instruction.substring(1, 7) + instruction.substring(20, 24);
        int immediate = getNumberFromBinaryTwoComplement(imm);
        if(BigInt.from(integerRegisters[rs1]).toUnsigned(32) < BigInt.from(integerRegisters[rs2]).toUnsigned(32)){
          pc = immediate;
        }else{
          pc = pc + 4;
        }
      }
      else if(instruction.substring(17, 20) == '111'){ //bgeu
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rs2 = int.parse(instruction.substring(7, 12), radix: 2);
        String imm = instruction[0] + instruction[24] + instruction.substring(1, 7) + instruction.substring(20, 24);
        int immediate = getNumberFromBinaryTwoComplement(imm);
        if(BigInt.from(integerRegisters[rs1]).toUnsigned(32) >= BigInt.from(integerRegisters[rs2]).toUnsigned(32)){
          pc = immediate;
        }else{
          pc = pc + 4;
        }
      }
    }

    /////////////////////////
    // TYPE-J INSTRUCTIONS //
    /////////////////////////
    else if(instruction.substring(25) == '1101111'){ //TYPE-J INSTRUCTIONS: jal.
      //Nao precisa de filtragem, so tem uma instrucao do tipo-J.
      int rd = int.parse(instruction.substring(20, 25), radix: 2);
      String imm = instruction[0] + instruction.substring(12, 20) + instruction[11] + instruction.substring(1, 11);
      int immediate = getNumberFromBinaryTwoComplement(imm);
      integerRegisters[rd] = pc + 4;
      pc = immediate;
      print("pc dps da execucao do jal: ${pc}");
    }
    return;
  }

  String getByteFromMemory(int address){
    if(address < 0 || address >= 999987){
      return "00000000";
    }
    String output = "";
    output = memory[address];
    return output;
  }

  String getHalfWordFromMemory(int address){
    if(address < 0 || address >= 999987){
      return "0000000000000000";
    }
    String output = "";
    output = memory[address + 1] + memory[address];
    return output;
  }

  String getWordFromMemory(int address){
    if(address < 0 || address >= 999987){
      return "00000000000000000000000000000000";
    }
    String output = "";
    output = memory[address + 3] + memory[address + 2] + memory[address + 1] + memory[address];
    return output;
  }

  void loadWordIntoMemory(int value, int address){ //Funcao responsavel por carregar uma word na memoria.
    if(address < 0 || address >= 999987){
      return;
    }
    //Memoria eh enderacada por byte.
    //Primeira parte: Converter o valor(int) para uma string binaria.
    String almost = BigInt.from(value).toUnsigned(32).toRadixString(2);
    //Segunda parte: Carregar o valor que agora eh uma string binaria na memoria.
    if(almost.length == 32){
      memory[address] = almost.substring(24, 32);
      memory[address + 1] = almost.substring(16, 24);
      memory[address + 2] = almost.substring(8, 16);
      memory[address + 3] = almost.substring(0, 8);
    }else if(almost.length < 32){
      almost = ('0' * (32 - almost.length)) + almost;
      memory[address] = almost.substring(24, 32);
      memory[address + 1] = almost.substring(16, 24);
      memory[address + 2] = almost.substring(8, 16);
      memory[address + 3] = almost.substring(0, 8);
    }
    return;
  }

  double convertFPStringToNumber(String input){
    double answer;
    //1) Pegando o sinal.
    String signal = input[0];
    int sign = 0;
    if(signal == '1'){
      sign = 1;
    }

    //2) Pegando os bits do expoente (8 bits) => 1..8
    String expPart = input.substring(1, 9);
    int exp = int.parse(expPart, radix: 2);
    int expUnBias = exp - 127;

    //3) Pegando a mantissa
    double mantissa = 0;
    int exponent = -1;
    for(int i = 9; i < input.length; i++){
      mantissa +=  int.parse(input[i], radix: 10) * pow(2, exponent);
      exponent -= 1;
    }

    answer = pow(-1.0, sign).toDouble() * (1 + mantissa).toDouble() * pow(2, expUnBias).toDouble();

    return answer;
  }


  String fractionToBinary(double fraction){
    String answer = "";
    
    while(fraction != 0 && answer.length <= 32){
      fraction = fraction * 2;
      if(fraction >= 1){
        answer += "1";
        fraction = fraction - 1;
      }else{
        answer += "0";
      }
    }
    return answer;
  }


  String generateStringFromFloatingPoint(double value){
    String answer = "";
    //Devemos converter o numero de ponto flutuante para o formato IEE-754
    //Primeira parte: O primeiro bit eh o bit de sinal
    // '0' -> numero de ponto flutuante positivo
    // '1' -> numero de ponto flutuante negativo
    if(value >= 0){
      answer += '0';
    }else{
      answer += '1';
    }
    //Tira o valor absoluto (modulo) do numero e tambem converte a parte inteira dele para a representacao binaria.
    value = value.abs();
    int valueInt = value.floor();
    String valueIntStr = valueInt.toRadixString(2);
    //Realizando agora a conversao da parte decimal do numero float para uma string.
    String valueFractionStr = fractionToBinary(value - value.floor());
    
    //Pegando o index do primeiro bit '1' na String que representa a parte inteira do valor.
    int index = -1;
    for(int i = 0; i < valueIntStr.length; i++){
      if(valueIntStr[i] == '1'){
        index = i;
        break;
      }
    }
    String expStr = ((valueIntStr.length - index - 1) + 127).toRadixString(2);
    String aux = valueIntStr + valueFractionStr;
    String mantStr = aux.substring(index + 1);
    if(mantStr.length < 23){
      while(mantStr.length != 23){
        mantStr += '0';
      }
    }

    answer += expStr + mantStr;

    return answer.substring(0, 32);
  }

  int getNumberFromBinaryTwoComplement(String input){
    int output;
    int signal = -1;
    //print("input --- $input");
    //Primeira coisa: Checo se o numero eh positivo ou negativo.
    if(input[0] == '0'){ //Numero positivo.
      output = int.parse(input, radix: 2);
    }else if(input[0] == '1'){ //Numero negativo (seguindo convencao complemento a 2).
      String almost = "";
      String reversed = "";
      //Primeira parte do complemento a 2.
      for(int i = 0; i < input.length; i++){
        if(input[i] == '0'){
          almost += '1';
        }else if(input[i] == '1'){
          almost += '0';
        }
      }
      //Reverte a string para somar 1
      for(int i = almost.length - 1; i >= 0; i--){
        reversed += almost[i];
      }
      //Somando 1 (a string ta invertida)
      int carry = 1;
      String answer = "";
      for(int i = 0; i < reversed.length; i++){
        if(carry == 0){
          answer += reversed[i];
        }
        else{
          if(carry == 1 && reversed[i] == '1'){
            answer += '0';
          }else if(carry == 1 && reversed[i] == '0'){
            answer += '1';
            carry = 0;
          }
        }
      }
      //Tem que inverter a string dnv para termos o resultado real.
      String ans = "";
      for(int i = answer.length - 1; i >= 0; i--){
        ans += answer[i];
      }
      //finish...
      output = int.parse(ans, radix: 2);
      output = output * signal;
    }else{
      print("An error has occurred while processing the immediate.");
    }
    return output;
  }

  void executeInstructions(Map<String,int> labelsAddress){
    print("Iniciando a simulacao!!!");
    print(labelsAddress);
    while(true){
      String instruction = fetchInstruction(pc);
      if(instruction == '00000000000000000000000000000000'){
        break; //Cheguei ao fim da simulacao
      }
      //print(instruction);
      decodeAndExecute(instruction, labelsAddress);
      integerRegisters[0] = 0;
    }
    return;
  }  
}
