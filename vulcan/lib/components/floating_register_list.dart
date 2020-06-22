// Vulcan is a software developed by:
// Victor Miguel de Morais Costa.
// License: MIT.
import 'package:flutter/material.dart';
import 'package:vulcan/components/register_card.dart';

class FloatingRegisterList extends StatelessWidget {
  List<double> floatingpointRegisters = [];

  FloatingRegisterList(List<double> input){
    this.floatingpointRegisters = input;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        RegisterCard(name: 'f0', secondName: '(ft0)', value: floatingpointRegisters[0].toStringAsPrecision(6)),
        RegisterCard(name: 'f1', secondName: '(ft1)', value: floatingpointRegisters[1].toStringAsPrecision(6)),
        RegisterCard(name: 'f2', secondName: '(ft2)', value: floatingpointRegisters[2].toStringAsPrecision(6)),
        RegisterCard(name: 'f3', secondName: '(ft3)', value: floatingpointRegisters[3].toStringAsPrecision(6)),
        RegisterCard(name: 'f4', secondName: '(ft4)', value: floatingpointRegisters[4].toStringAsPrecision(6)),
        RegisterCard(name: 'f5', secondName: '(ft5)', value: floatingpointRegisters[5].toStringAsPrecision(6)),
        RegisterCard(name: 'f6', secondName: '(ft6)', value: floatingpointRegisters[6].toStringAsPrecision(6)),
        RegisterCard(name: 'f7', secondName: '(ft7)', value: floatingpointRegisters[7].toStringAsPrecision(6)),
        RegisterCard(name: 'f8', secondName: '(fs0)', value: floatingpointRegisters[8].toStringAsPrecision(6)),
        RegisterCard(name: 'f9', secondName: '(fs1)', value: floatingpointRegisters[9].toStringAsPrecision(6)),
        RegisterCard(name: 'f10', secondName: '(fa0)', value: floatingpointRegisters[10].toStringAsPrecision(6)),
        RegisterCard(name: 'f11', secondName: '(fa1)', value: floatingpointRegisters[11].toStringAsPrecision(6)),
        RegisterCard(name: 'f12', secondName: '(fa2)', value: floatingpointRegisters[12].toStringAsPrecision(6)),
        RegisterCard(name: 'f13', secondName: '(fa3)', value: floatingpointRegisters[13].toStringAsPrecision(6)),
        RegisterCard(name: 'f14', secondName: '(fa4)', value: floatingpointRegisters[14].toStringAsPrecision(6)),
        RegisterCard(name: 'f15', secondName: '(fa5)', value: floatingpointRegisters[15].toStringAsPrecision(6)),
        RegisterCard(name: 'f16', secondName: '(fa6)', value: floatingpointRegisters[16].toStringAsPrecision(6)),
        RegisterCard(name: 'f17', secondName: '(fa7)', value: floatingpointRegisters[17].toStringAsPrecision(6)),
        RegisterCard(name: 'f18', secondName: '(fs2)', value: floatingpointRegisters[18].toStringAsPrecision(6)),
        RegisterCard(name: 'f19', secondName: '(fs3)', value: floatingpointRegisters[19].toStringAsPrecision(6)),
        RegisterCard(name: 'f20', secondName: '(fs4)', value: floatingpointRegisters[20].toStringAsPrecision(6)),
        RegisterCard(name: 'f21', secondName: '(fs5)', value: floatingpointRegisters[21].toStringAsPrecision(6)),
        RegisterCard(name: 'f22', secondName: '(fs6)', value: floatingpointRegisters[22].toStringAsPrecision(6)),
        RegisterCard(name: 'f23', secondName: '(fs7)', value: floatingpointRegisters[23].toStringAsPrecision(6)),
        RegisterCard(name: 'f24', secondName: '(fs8)', value: floatingpointRegisters[24].toStringAsPrecision(6)),
        RegisterCard(name: 'f25', secondName: '(fs9)', value: floatingpointRegisters[25].toStringAsPrecision(6)),
        RegisterCard(name: 'f26', secondName: '(fs10)', value: floatingpointRegisters[26].toStringAsPrecision(6)),
        RegisterCard(name: 'f27', secondName: '(fs11)', value: floatingpointRegisters[27].toStringAsPrecision(6)),
        RegisterCard(name: 'f28', secondName: '(ft8)', value: floatingpointRegisters[28].toStringAsPrecision(6)),
        RegisterCard(name: 'f29', secondName: '(ft9)', value: floatingpointRegisters[29].toStringAsPrecision(6)),
        RegisterCard(name: 'f30', secondName: '(ft10)', value: floatingpointRegisters[30].toStringAsPrecision(6)),
        RegisterCard(name: 'f31', secondName: '(ft11)', value: floatingpointRegisters[31].toStringAsPrecision(6)),
      ],
    );
  }
}
//
