// Vulcan is Software developed by:
// Victor Miguel de Morais Costa
// License: MIT
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

//iSSO AQUI era stateful antes

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

  /*
  @override
  void initState() {
    super.initState();
    ui.platformViewRegistry
        .registerViewFactory(_editorId, (int viewId) => _codeContent);
    _codeView = HtmlElementView(
      viewType: _editorId,
    );
    var node = html.document.getElementsByTagName("flt-platform-view")[0] as html.HtmlElement; //o problema ta aqui eu acho... confirmado. a treta eh aqui.
    _codeMirror = CodeMirror.fromElement(_codeContent, options: _editorOptions);
  }
  */

  /* ISSO AQUI NAO TAVA COMENTADO ANTES
  handleEditorCreated(CodeMirror mirror) {
    _codeMirror = mirror;
    //Nao tinha essa linha abaixo.
    _codeMirror.setSize(1300, 580); //width, height
    //O número de linhas de exibição torna inutilizável
    _codeMirror.setLineNumbers(true);
    _codeMirror.refresh(); //nao tinha isso antes. foi a 1 coisa q adicionei
    _codeMirror.getDoc().setValue("");
    _codeMirror.onMouseDown.listen((event) { //Para ativar o editor, tem que colocar o mouse em cima dele e clicar duas vezes tava como: onDoubleClick
      _codeMirror.refresh(); //n tinha isso
      // numero da linha
      setState(() {
        _colNumbers = _codeMirror
            .getCursor()
            .ch;
        _lineNumbers = _codeMirror
            .getCursor()
            .line;
        _focusNode.requestFocus();
      });
    });
  }*/

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
                    'To start coding wait for the editor to be loaded and then click on it.  Please make sure to use the app in full screen.',
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
                        //Vou tentar fazer esse lance do codigo usando o Rich_Code_Editor. Vamo ver oq rola...
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
                              obscureText: false, //Deixa o conteudo digitado visivel
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



                        //O que tem aqui embaixo eh o lance do CodeMirror
                        /*
                        child: CodeEditor(
                            editorId: _editorId,
                            height: 550,
                            width: 1300,
                            initialOptions: _editorOptions,
                            onEditorCreated: handleEditorCreated,
                            focusNode: _focusNode
                        ),
                        */
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

              /*
              body: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(onPressed: showCodeEditor, child: Text("show")),
                    Container(
                        decoration: BoxDecoration(color: Colors.grey),
                        width: 400,
                        height: 400,
                        child: _codeView,
                    ),
                  ],
                ),
              ),
              */
            ),
          ) : ErrorPage(),
        ),
      );
  }
}



