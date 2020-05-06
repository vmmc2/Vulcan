# Vulcan
RISC-V Instruction Set Simulator

## To do List
- [x] finish the home page layout
- [ ] finish the editor page layout
- [ ] integrate the editor page with codemirror
- [ ] finish the simulator page layout
- [ ] finish the reference page layout

## Etapa Dificil: Conectar o CodeMirror com o Flutter Web
* No momento em que estou fazendo o projeto, a API do CodeMirror (ou o que quer que seja aquilo) ta disponivel apenas para Dart:HTML. Nao tem um package ou plugin ou qualquer coisa do tipo para gente plugar no nosso aplicativo Flutter Web. Ou seja, vamo ter que fazer todo esse procedimento na tora.
* Entretanto, a gente pode usar o plugin do HTML no Flutter Web usando um widget especifico chamado Html.Element.View() que tem suporte ao initState(). Depois disso, a gente registra o nosso HtmlElement nele e pode configurar e usar de boas. 
* Tem que declarar o nosso widget como Stateful Widget.
* A gente tem que declarar algumas variaveis importantes para poder fazer essa integracao:
  * code-mirrorID : Vai servir com o id do element no HTML.
  * DivElement: Pelo que eu entendi, isso vai ser responsavel por armazenar nossa instancia do CodeMirror de fato.
  * CodeMirror: Vai servir para fazer o processamento da chamada de retorno.
  * HtmlElementView: Vai ser o responsavel por cuidar da UI da nossa instancia do CodeMirror.
  * Options: Vai servir para gente configurar nossa instancia do CodeMirror. Provavelmente vamos usar um map.
* Feito isso, a gente vai se registrar dentro do Stateful Widget e gerar um HtmlElementView.
  * Importe a library dart:ui.
  * Ignore: undefined_prefixed_name é usado pelo registerViewFactory para ignorar undefined (nao entendi muito bem essa parte mas ok).
* Agora a gente tem que colocar _codeView dentro do metodo de construcao (build method).
* Ate ai tudo bem...
* Agora a gente tem que fazer umas paradinhas a respeito do CodeView, que ta dentro do CodeMirror.
* Tem que fazer alguma coisa a respeito do _codeView presente no .html correspondente (seria o index.html que ja vem quando a gente cria um projeto do tipo flutter web? Nao sei ainda, tem que perguntar ao cara).
* Tem que adicionar uma coisa chamada shadowRoot para fazer o isolamento... mas isolamento de que?
* Tambem tem que adicionar CSS ao file index.html Mas tem que adicionar oq exatamente?
* Aparentemente nao pode usar JS dentro do shadowRoot. Precisamos encontrar outra maneira de resolver o problema.
* Eu nao entendi essa parte... mas ela ta detalhada no inicio do capitulo 4 do tutorial fornecido pelo cara.. Eu so copiei as linhas de codigo.. Nao manjo nada muito aprofundado de HTML, DOM, JS ou qualquer coisa de web e afins...
* Depois de tudo isso, tem que instanciar CodeMirror em um DivElement.
* Aparentemente, tem que botar as linhas referentes a secao 4.1 dentro do initState()
* Agora tem que importar CSS e JS de terceiro para a gente poder usar...
* O cara usou os arquivos de JS e de CSS de um site chamado 'cdn.bootcss.com' mas eu nao consigo acessar o site.
* Depois daqui meio que fudeu. 
