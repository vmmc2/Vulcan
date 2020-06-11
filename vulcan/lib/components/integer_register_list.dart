// Vulcan is Software developed by:
// Victor Miguel de Morais Costa
// License: MIT
import 'package:flutter/material.dart';
import 'package:vulcan/components/register_card.dart';

class IntegerRegisterList extends StatelessWidget {
  List<int> integerRegisters = [];
  
  IntegerRegisterList(List<int> input){
    this.integerRegisters = input;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        //O elemento da minha lista de registradores
        RegisterCard(name: 'x0', secondName: '', value: '${BigInt.from(integerRegisters[0]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x1', secondName: '(ra)', value: '${BigInt.from(integerRegisters[1]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x2', secondName: '(sp)', value: '${BigInt.from(integerRegisters[2]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x3', secondName: '(gp)', value: '${BigInt.from(integerRegisters[3]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x4', secondName: '(tp)', value: '${BigInt.from(integerRegisters[4]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x5', secondName: '(t0)', value: '${BigInt.from(integerRegisters[5]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x6', secondName: '(t1)', value: '${BigInt.from(integerRegisters[6]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x7', secondName: '(t2)', value: '${BigInt.from(integerRegisters[7]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x8', secondName: '(s0)', value: '${BigInt.from(integerRegisters[8]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x9', secondName: '(s1)', value: '${BigInt.from(integerRegisters[9]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x10', secondName: '(a0)', value: '${BigInt.from(integerRegisters[10]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x11', secondName: '(a1)', value: '${BigInt.from(integerRegisters[11]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x12', secondName: '(a2)', value: '${BigInt.from(integerRegisters[12]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x13', secondName: '(a3)', value: '${BigInt.from(integerRegisters[13]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x14', secondName: '(a4)', value: '${BigInt.from(integerRegisters[14]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x15', secondName: '(a5)', value: '${BigInt.from(integerRegisters[15]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x16', secondName: '(a6)', value: '${BigInt.from(integerRegisters[16]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x17', secondName: '(a7)', value: '${BigInt.from(integerRegisters[17]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x18', secondName: '(s2)', value: '${BigInt.from(integerRegisters[18]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x19', secondName: '(s3)', value: '${BigInt.from(integerRegisters[19]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x20', secondName: '(s4)', value: '${BigInt.from(integerRegisters[20]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x21', secondName: '(s5)', value: '${BigInt.from(integerRegisters[21]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x22', secondName: '(s6)', value: '${BigInt.from(integerRegisters[22]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x23', secondName: '(s7)', value: '${BigInt.from(integerRegisters[23]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x24', secondName: '(s8)', value: '${BigInt.from(integerRegisters[24]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x25', secondName: '(s9)', value: '${BigInt.from(integerRegisters[25]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x26', secondName: '(s10)', value: '${BigInt.from(integerRegisters[26]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x27', secondName: '(s11)', value: '${BigInt.from(integerRegisters[27]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x28', secondName: '(t3)', value: '${BigInt.from(integerRegisters[28]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x29', secondName: '(t4)', value: '${BigInt.from(integerRegisters[29]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x30', secondName: '(t5)', value: '${BigInt.from(integerRegisters[30]).toSigned(32).toRadixString(10)}'),
        RegisterCard(name: 'x31', secondName: '(t6)', value: '${BigInt.from(integerRegisters[31]).toSigned(32).toRadixString(10)}'),
      ],
    );
  }
}
