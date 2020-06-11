// Vulcan is Software developed by:
// Victor Miguel de Morais Costa
// License: MIT
class Processor{
  //Ponteiros fixados para os segmentos de memoria.
  final int reserved = 0;
  final int text = 400;
  final int staticData = 200400;
  final int heap = 400400;
  final int initialStack = 999992;

  //Registradores e memoria.
  List<int> integerRegisters = [];  //List de tamanho 32. Cada elemento da lista representa um dos 32 registradores inteiros do RISC-V.
  List<String> memory; //List de tamanho 999_992. Cada elemento eh uma string de tamanho 8 (8 bits = 1 byte). Isso acontece pq a memoria eh enderacada por byte.
  int pc = 400;

  //Construtor da Classe
  Processor(){
    this.integerRegisters = List<int>.filled(32, 0, growable: false);
    this.memory = List<String>.filled(999992, '00000000', growable: false);
    this.integerRegisters[2] = 1000000; //registrador x2(sp) funciona como o ponteiro de pilha.
    this.integerRegisters[3] = 200400; //registrador x3 aponta para os dados estaticos (static data).
    memory[0] = '11111110';
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

  void decodeAndExecute(String instruction){
    //Para fazer o decode da instrução, a gente tem que olhar primeiro para o opcode dela.
    //O opcode de uma instrucao de 32 bits sao sempre os ultimos 7 bits (7 bits menos significativos): [6..0]

    /////////////////////////
    // TYPE-R INSTRUCTIONS //
    /////////////////////////
    if(instruction.substring(25) == '0110011'){ //TYPE-R Instructions: add, sub, and, or, xor, slt, sltu, srl, sll, sra.
      //para diferenciar as instrucoes type-R do RV32I a gente vai usar os campos funct3 e funct7.
      if(instruction.substring(17, 20) == '000'){ //add ou sub
        if(instruction.substring(0, 7) == '0000000'){ //add
          //register[rd] = register[rs1] + register[rs2]
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] + integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
        }else if(instruction.substring(0, 7) == '0100000'){ //sub
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] - integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
        }
      }else if(instruction.substring(17, 20) == '001'){ //sll
        integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] << integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
      }else if(instruction.substring(17, 20) == '010'){ //slt
        if(integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] < integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)]){
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = 1;
        }else{
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = 0;
        }
      }else if(instruction.substring(17, 20) == '011'){ //sltu
        int rs1 = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)];
        int rs2 = integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
        if(rs1.toUnsigned(32) < rs2.toUnsigned(32)){
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = 1;
        }else{
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = 0;
        }
      }else if(instruction.substring(17, 20) == '100'){ //xor
        integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] ^ integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
      }
      else if(instruction.substring(17, 20) == '101'){ //srl ou sra
        if(instruction.substring(0, 7) == '0000000'){ //srl
          integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] >> integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
        }else if(instruction.substring(0, 7) == '0100000'){ //sra
          //A funcao sra realiza uma divisao por 2^n (mesmo o dividendo sendo positivo ou negativo).
          int rs1 = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)];
          int rs2 = integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
          if(rs1 < 0){
            rs1 = rs1 * (-1);
            int almost = rs1 >> rs2;
            integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = almost * (-1);
          }else{
            integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] >> integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
          }
        }
      }
      else if(instruction.substring(17, 20) == '110'){ //or
        integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] | integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
      }else if(instruction.substring(17, 20) == '111'){ //and
        integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = integerRegisters[int.parse(instruction.substring(12, 17), radix: 2)] & integerRegisters[int.parse(instruction.substring(7, 12), radix: 2)];
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
      }else if(instruction.substring(25) == '0010111'){ //auipc
      //Aparentemente a instrucao auipc nao aceita imediatos menores que zero.
      //Os imediatos da instrucao auipc apresentam 20 bits. Eles apresentam o seguinte range: 0, pow(2, 20) - 1.
        print("pc = ${pc} ------ valor la: ${int.parse(instruction.substring(0, 20), radix: 2) << 12}");
        integerRegisters[int.parse(instruction.substring(20, 25), radix: 2)] = pc + (int.parse(instruction.substring(0, 20), radix: 2) << 12);
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
        }
        else if(instruction.substring(17, 20) == '011'){ //sltiu
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
          if(BigInt.from(rs1).toUnsigned(12) < BigInt.from(immediate).toUnsigned(12)){
            integerRegisters[rd] = 1;
          }else{
            integerRegisters[rd] = 0;
          }
        }
        else if(instruction.substring(17, 20) == '100'){ //xori
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
          integerRegisters[rd] = integerRegisters[rs1] ^ immediate;
        }
        else if(instruction.substring(17, 20) == '110'){ //ori
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
          integerRegisters[rd] = integerRegisters[rs1] | immediate;
        }
        else if(instruction.substring(17, 20) == '111'){ //andi
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
          integerRegisters[rd] = integerRegisters[rs1] & immediate;
        }
        else if(instruction.substring(17, 20) == '001'){ //slli --> SO TRABALHA COM IMEDIATOS NAO-NEGATIVOS
          int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
          int rd = int.parse(instruction.substring(20, 25), radix: 2);
          int immediate = int.parse(instruction.substring(7, 12), radix: 2);
          integerRegisters[rd] = (integerRegisters[rs1] << immediate);
        }
        else if(instruction.substring(17, 20) == '101'){ //srli ou srai --> SO TRABALHA COM IMEDIATOS NAO-NEGATIVOS
          if(instruction.substring(0, 7) == '0000000'){ //srli
            //Como o srli faz extensao de 0. Eu tenho que deixar o operando mais a esquerda na notacao unsigned (sem sinal).
            int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
            int rd = int.parse(instruction.substring(20, 25), radix: 2);
            int immediate = int.parse(instruction.substring(7, 12), radix: 2);
            integerRegisters[rd] = ((integerRegisters[rs1]).toUnsigned(32) >> immediate);
          }else if(instruction.substring(0, 7) == '0100000'){ //srai
            //Como o srai faz extensaso de sinal, eu nao preciso me preocupar com a conversao para unsigned. posso deixar do jeito que ta.
            int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
            int rd = int.parse(instruction.substring(20, 25), radix: 2);
            int immediate = int.parse(instruction.substring(7, 12), radix: 2);
            integerRegisters[rd] = (integerRegisters[rs1] >> immediate);
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
        int address = rs1 + immediate;
        integerRegisters[rd] = getNumberFromBinaryTwoComplement(getByteFromMemory(address));
      }
      else if(instruction.substring(17, 20) == '001'){ //lh
        //No caso da instrucao "lh", a gente extende o valor carregado com sinal.
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
        int address = rs1 + immediate;
        integerRegisters[rd] = getNumberFromBinaryTwoComplement(getHalfWordFromMemory(address));
      }
      else if(instruction.substring(17, 20) == '010'){ //lw
        //No caso da instrucao "lw", a gente extende o valor carregado com sinal.
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
        int address = rs1 + immediate;
        integerRegisters[rd] = getNumberFromBinaryTwoComplement(getWordFromMemory(address));
      }
      else if(instruction.substring(17, 20) == '100'){ //lbu
        //No caso da instrucao "lbu", a gente extende o valor carregado sem sinal.
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
        int address = rs1 + immediate;
        integerRegisters[rd] = int.parse(getByteFromMemory(address), radix: 2);
      }
      else if(instruction.substring(17, 20) == '101'){ //lhu
        //No caso da instrucao "lhu", a gente extende o valor carregado com sinal.
        int rs1 = int.parse(instruction.substring(12, 17), radix: 2);
        int rd = int.parse(instruction.substring(20, 25), radix: 2);
        int immediate = getNumberFromBinaryTwoComplement(instruction.substring(0, 12));
        int address = rs1 + immediate;
        integerRegisters[rd] = int.parse(getHalfWordFromMemory(address), radix: 2);
      }
    }
    else if(instruction.substring(25) == '1100111'){ //TYPE-I INSTRUCTIONS: jalr.
  
    }

    /////////////////////////
    // TYPE-S INSTRUCTIONS //
    /////////////////////////
    else if(instruction.substring(25) == '0100011'){ //TYPE-S INSTRUCTIONS: sb, sh, sw.
      //Agora tem que filtrar pelo campo funct3.
      if(instruction.substring(17, 20) == "000"){ //sb

      }
      else if(instruction.substring(17, 20) == "001"){ //sh

      }
      else if(instruction.substring(17, 20) == "010"){ //sw

      }

    }
    return;
  }

  String getByteFromMemory(int address){
    String output = "";
    output = memory[address];
    return output;
  }

  String getHalfWordFromMemory(int address){
    String output = "";
    output = memory[address + 1] + memory[address];
    return output;
  }

  String getWordFromMemory(int address){
    String output = "";
    output = memory[address + 3] + memory[address + 2] + memory[address + 1] + memory[address];
    return output;
  }

  int getNumberFromBinaryTwoComplement(String input){
    int output;
    int signal = -1;
    print("input --- $input");
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

  void executeInstructions(){
    print("Iniciando a simulacao!!!");
    while(true){
      String instruction = fetchInstruction(pc);
      if(instruction == '00000000000000000000000000000000'){ //VAMO TER QUE MUDAR ESSA CONDICAO DE PARADA DA SIMULACAO. A MEMORIA NAO PODE SER INICIALIZADA DESSE JEITO.
        break; //Cheguei ao fim da simulacao
      }
      print(instruction);
      decodeAndExecute(instruction);
      print(pc);
      pc = pc + 4;
    }
    return;
  }  
}
