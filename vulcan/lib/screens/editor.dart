// Vulcan is a software developed by:
// Victor Miguel de Morais Costa.
// License: MIT.
import 'package:flutter/material.dart';
import 'package:codemirror/codemirror.dart';
import 'package:vulcan/components/responsive_widget.dart';
import 'package:vulcan/components/top_bar.dart';
import 'package:vulcan/components/action_bar.dart';
import 'package:vulcan/components/code_editor.dart';
import 'package:vulcan/screens/error.dart';
import 'package:vulcan/screens/simulator.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;

class Editor extends StatelessWidget{

  String _editorId = "code-editor";
  html.DivElement _codeContent = html.DivElement();
  CodeMirror _codeMirror;
  HtmlElementView _codeView;
  Map _editorOptions = {
    'mode': 'python',
    'theme': 'cobalt', //use 'cobalt' como tema
    'styleActiveLine': true,
    'indentWithTabs': true,
    'tabSize': 1,
  };
  //Possiveis themes para gente usar: blackboard, cobalt, erlang-dark, midnight, night
  var _focusNode = FocusNode();
  var _colNumbers = 20;
  var _lineNumbers = 20;

  static String content = "";
  var _controller = TextEditingController(text: content);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
          child: MediaQuery.of(context).size.width >= 1200 ? ResponsiveWidget(
            largeScreen: Scaffold(
              backgroundColor: Color(0xFF02143D),
              appBar: TopBar(title: 'Editor Page'),
              body: Column(
                children: <Widget>[
                  ActionBar(),
                  Text(
                    'To start coding, click on the editor.  Please make sure to use the app in full screen.',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15.0,
                      color: Color(0xFF1CFDFC),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 40.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFCDE6F5),//Color(0xFF02143D),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        width: 1300,
                        height: 550,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Theme(
                            data: ThemeData(
                              primaryColor: Color(0xFF02143D),
                              primaryColorDark: Color(0xFF02143D),
                            ),
                            child: TextField(
                              controller: _controller,
                              onChanged: (str) {
                                content = str;
                              },
                              cursorColor: Color(0xFF02143D),
                              minLines: 21,
                              maxLines: null,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF02143D)),
                                ),
                                labelText: 'Enter your code.',
                              ),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF02143D),
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40.0),
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Simulator(codeWritten: _controller.text),
                          )
                          );
                        },
                        color: Color(0xFF1CFDFC),
                        child: Text(
                          "Simulate",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14.0,
                            color: Color(0xFF02143D),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ) : ErrorPage(),
        ),
      );
  }
}
