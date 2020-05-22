import 'dart:async';
import 'dart:js';
import 'dart:ui' as ui;

import 'package:after_layout/after_layout.dart';
import 'package:codemirror/codemirror.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart';

class CodeEditor extends StatefulWidget {
  final Function(CodeMirror) onEditorCreated;
  final double width;
  final double height;
  final String editorId; //vai ser o ID do editor no arquivo HTML.
  final Map initialOptions; //Configuaracao do editor
  final FocusNode focusNode;

  const CodeEditor(
      {Key key,
        @required this.onEditorCreated,
        @required this.width,
        @required this.height,
        @required this.editorId,
        @required this.initialOptions, this.focusNode})
      : super(key: key);

  @override
  _CodeEditorState createState() => _CodeEditorState();
}

class _CodeEditorState extends State<CodeEditor> with AfterLayoutMixin {
  DivElement _codeContent = DivElement(); //Serve para armazenamento
  CodeMirror _codeMirror; //Vai servir para o retorno da chamada

  //Para poder usar o plug-in de HTML nativo no Flutter Web eh necessario
  //usar o suporte ao componente HtmlElementView abaixo
  //Tem que registrar esse componente no initState e configurar o componente
  HtmlElementView _codeView; //Parte de UI do Editor
  //Esse _codeView usa um ngc chamado shadowRoot para isolamento ao HTML
  //correspondente. Nao da para adicionar CSS e JS ao cabecalho do index.html
  //Tem que fazer isso de outro jeito
  //O jeito eh obter o shadowRoot do _codeView.

  @override
  void initState() {
    //Aqui a gente tem que registrar e gerar o HtmlElementView
    super.initState();
    //Abaixo a gente ta fazendo o registro do componente HtmlElementView
    //E tambem ta dando um assign para ele. Esse assign vai ser a ID do elemento no HTML
    //Registrar a tag codemirror
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(widget.editorId, (int viewId) => _codeContent);
    _codeView = HtmlElementView(
      viewType: widget.editorId,
    );
    //Desativar tecla da guia/tab
    document.onKeyDown.listen((event) {
      if (event.keyCode == 9) { //ISSO AQUI TA INDICANDO QUAL EH A TECLA QUE TEM QUE APERTAR PARA ATIVAR O EDITOR!!!!
        event.preventDefault();
      }
    });
  }

  @override
  void dispose() {
    _codeMirror?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Aqui dentro a gente tem que por o _codeView
    return RawKeyboardListener(
      autofocus: true,
      focusNode: widget.focusNode,
      child: Container(
        color: Color(0xFF02143D),
        width: widget.width,
        height: widget.height,
        child: _codeView,
      ),
      onKey: (RawKeyEvent event) {
        if (event.runtimeType == RawKeyDownEvent /* &&
            (event.logicalKey.keyId == KeyCode.SPACE || //descomentei o conteudo dessa linha.
                event.logicalKey.keyId == KeyCode.TAB)*/) {
          _codeMirror.focus();
          debugPrint("focus!");
        }
      },
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    buildCodeMirror();
  }

  void buildCodeMirror() {
    var headElement = HeadElement();
    final NodeValidatorBuilder _htmlValidator =
    new NodeValidatorBuilder.common()
      ..allowElement('link', attributes: ["rel", "href"])
      ..allowElement('script', attributes: ["src"]);
    rootBundle.loadString("codemirror_header.html").then((value) {
      // create codeMirror
      _codeMirror =
          CodeMirror.fromElement(_codeContent, options: widget.initialOptions);
      debugPrint("insert root");
      widget.onEditorCreated(_codeMirror);
      // add headers
      debugPrint("property: $value");
      debugPrint("options: ${widget.initialOptions.toString()}");
      headElement.setInnerHtml(value, validator: _htmlValidator);
      // Localizar...
      Future.delayed(const Duration(milliseconds: 500), () {
        var node;
        while (true) {
          var array = document.getElementsByTagName("flt-platform-view");
          if (array.length != 0) {
            node = array[0] as HtmlElement; //tava 0 antes
            break;
          }
        }
        node.shadowRoot.children.insert(0, headElement);
      });
    });
  }
}

//Por fim, tem que importar CSS e JS de terceiros para serem usados
