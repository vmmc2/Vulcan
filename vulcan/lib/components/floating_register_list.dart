import 'package:flutter/material.dart';
import 'package:vulcan/components/register_card.dart';

class FloatingRegisterList extends StatelessWidget {
  const FloatingRegisterList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        RegisterCard(name: 'f0', secondName: '(ft0)'),
        RegisterCard(name: 'f1', secondName: '(ft1)'),
        RegisterCard(name: 'f2', secondName: '(ft2)'),
        RegisterCard(name: 'f3', secondName: '(ft3)'),
        RegisterCard(name: 'f4', secondName: '(ft4)'),
        RegisterCard(name: 'f5', secondName: '(ft5)'),
        RegisterCard(name: 'f6', secondName: '(ft6)'),
        RegisterCard(name: 'f7', secondName: '(ft7)'),
        RegisterCard(name: 'f8', secondName: '(fs0)'),
        RegisterCard(name: 'f9', secondName: '(fs1)'),
        RegisterCard(name: 'f10', secondName: '(fa0)'),
        RegisterCard(name: 'f11', secondName: '(fa1)'),
        RegisterCard(name: 'f12', secondName: '(fa2)'),
        RegisterCard(name: 'f13', secondName: '(fa3)'),
        RegisterCard(name: 'f14', secondName: '(fa4)'),
        RegisterCard(name: 'f15', secondName: '(fa5)'),
        RegisterCard(name: 'f16', secondName: '(fa6)'),
        RegisterCard(name: 'f17', secondName: '(fa7)'),
        RegisterCard(name: 'f18', secondName: '(fs2)'),
        RegisterCard(name: 'f19', secondName: '(fs3)'),
        RegisterCard(name: 'f20', secondName: '(fs4)'),
        RegisterCard(name: 'f21', secondName: '(fs5)'),
        RegisterCard(name: 'f22', secondName: '(fs6)'),
        RegisterCard(name: 'f23', secondName: '(fs7)'),
        RegisterCard(name: 'f24', secondName: '(fs8)'),
        RegisterCard(name: 'f25', secondName: '(fs9)'),
        RegisterCard(name: 'f26', secondName: '(fs10)'),
        RegisterCard(name: 'f27', secondName: '(fs11)'),
        RegisterCard(name: 'f28', secondName: '(ft8)'),
        RegisterCard(name: 'f29', secondName: '(ft9)'),
        RegisterCard(name: 'f30', secondName: '(ft10)'),
        RegisterCard(name: 'f31', secondName: '(ft11)'),
      ],
    );
  }
}
