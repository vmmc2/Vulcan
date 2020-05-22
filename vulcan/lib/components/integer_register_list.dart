import 'package:flutter/material.dart';
import 'package:vulcan/components/register_card.dart';

class IntegerRegisterList extends StatelessWidget {
  const IntegerRegisterList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        //O elemento da minha lista de registradores
        RegisterCard(name: 'x0', secondName: ''),
        //termina aqui o elemento da minha lista de registradores
        RegisterCard(name: 'x1', secondName: '(ra)'),
        RegisterCard(name: 'x2', secondName: '(sp)'),
        RegisterCard(name: 'x3', secondName: '(gp)'),
        RegisterCard(name: 'x4', secondName: '(tp)'),
        RegisterCard(name: 'x5', secondName: '(t0)'),
        RegisterCard(name: 'x6', secondName: '(t1)'),
        RegisterCard(name: 'x7', secondName: '(t2)'),
        RegisterCard(name: 'x8', secondName: '(s0)'),
        RegisterCard(name: 'x9', secondName: '(s1)'),
        RegisterCard(name: 'x10', secondName: '(a0)'),
        RegisterCard(name: 'x11', secondName: '(a1)'),
        RegisterCard(name: 'x12', secondName: '(a2)'),
        RegisterCard(name: 'x13', secondName: '(a3)'),
        RegisterCard(name: 'x14', secondName: '(a4)'),
        RegisterCard(name: 'x15', secondName: '(a5)'),
        RegisterCard(name: 'x16', secondName: '(a6)'),
        RegisterCard(name: 'x17', secondName: '(a7)'),
        RegisterCard(name: 'x18', secondName: '(s2)'),
        RegisterCard(name: 'x19', secondName: '(s3)'),
        RegisterCard(name: 'x20', secondName: '(s4)'),
        RegisterCard(name: 'x21', secondName: '(s5)'),
        RegisterCard(name: 'x22', secondName: '(s6)'),
        RegisterCard(name: 'x23', secondName: '(s7)'),
        RegisterCard(name: 'x24', secondName: '(s8)'),
        RegisterCard(name: 'x25', secondName: '(s9)'),
        RegisterCard(name: 'x26', secondName: '(s10)'),
        RegisterCard(name: 'x27', secondName: '(s11)'),
        RegisterCard(name: 'x28', secondName: '(t3)'),
        RegisterCard(name: 'x29', secondName: '(t4)'),
        RegisterCard(name: 'x30', secondName: '(t5)'),
        RegisterCard(name: 'x31', secondName: '(t6)'),
      ],
    );
  }
}
