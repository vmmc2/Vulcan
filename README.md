# Vulcan
RISC-V Instruction Set Simulator

## To do List
- [x] finish the home page layout
- [ ] finish the editor page layout
- [ ] integrate the editor page with codemirror

## Etapa Dificil: Conectar o CodeMirror com o Flutter Web
* No momento em que estou fazendo o projeto, a API do CodeMirror (ou o que quer que seja aquilo) ta disponivel apenas para Dart:HTML. Nao tem um package ou plugin ou qualquer coisa do tipo para gente plugar no nosso aplicativo Flutter Web. Ou seja, vamo ter que fazer todo esse procedimento na tora.
* Entretanto, a gente pode usar o plugin do HTML no Flutter Web usando um widget especifico chamado Html.Element.View() que tem suporte ao initState(). Depois disso, a gente registra o nosso HtmlElement nele e pode configurar e usar de boas. 
* A gente tem que declarar algumas variaveis importantes para poder fazer essa integracao:
  * code-mirrorID : Vai servir com o id do element no HTML.
  * DivElement: Pelo que eu entendi, isso vai ser responsavel por armazenar nossa instancia do CodeMirror de fato.
  * CodeMirror: Vai servir para fazer o processamento da chamada de retorno.
  * HtmlElementView: Vai ser o responsavel por cuidar da UI da nossa instancia do CodeMirror.
  * Options: Vai servir para gente configurar nossa instancia do CodeMirror. Provavelmente vamos usar um map.
