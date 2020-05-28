# Vulcan
RISC-V Instruction Set Simulator Built For Education

## Execução das Instruções:
* Vou ter que usar C interop por meio da library: Dart:ffi

## Observações:
* O que vai acontecer quando o cara apertar o botao "Simulate" na pagina Editor?
  * Primeiro, a gente vai salvar todas as linhas que ele colocou no CodeEditor de alguma forma (Numa lista com as linhas ou algo do tipo).
  * Em seguida, a gente vai passar essa lista como um conjunto de dados para a pagina Simulator. Chegando na pagina do Simulator, a primeira coisa que a gente vai fazer vai ser rodar o Assembler para ver se acha erro. Se achar, ja avisa ao usuario por meio de um AlertDialog() ou coisa do tipo, para ele voltar para a pagina do Editor e reescrever o codigo dele. Se nao achar erro, pega o codigo de maquina obtido depois de chamar o Assembler (no caso o codigo de maquina, que pode ta em hex, bin ou decimal, tanto faz). Carrega ele, seta o PC e a partir dai comeca a executar todas as instrucoes ate acabar as instrucoes que foram carregadas na memoria. Ao final disso tudo, os registradores vao ta com os valores referentes a execucao do codigo, bem como a memoria vai ta com os valores referentes a execucao do codigo.
  * Ou seja, o usuario nao vai poder mexer manualmente nos registradores e nem na memoria. Pelo menos nao agora. Se quiser alterar, vai ter que deixar tudo indicado no seu codigo. (Talvez eu mude isso depois por questoes de flexibilidade).
  * Outra coisa, o codigo vai ser executado tudo de uma vez na pagina Simulator. Nao vai ficar mostrando a execucao passo a passo nao. Novamente, talvez depois eu mude isso para permitir uma execucao passo a passo para que seja mais facil o usuario debugar seu proprio codigo, mas por enquanto vai ficar assim.

## Sobre a forma como o Vênus lida com instruções de Branch e Jump
* __Basicamente, a política do Vênus é de permitir Branches e Jumps apenas quando o operando offset é uma label.__ Ou seja, a label tem que tá escrita no código, se não o programa não vai ser executado.
* É uma abordagem interessante pois evita que o programador faça merda mexendo no PC ao somar constantes a ele. Por outro lado, isso tira um pouco da sua liberdade. Vou ter que refletir sobre como vou implementar essa parte.
* __Observação/Atualização: Depois de dar uma olhada em exemplos de código presentes no livro RISC-V Atlas, dá pra ver essa é a convenção mesmo (tem que usar as labels como offset para impedir o programador de fazer merda no código).__

## Como o Vênus lida com loops infinitos?
* Se a gente tem um código Assembly RISC-V que possui um loop infinito, quando a gente for executar ele no simulador. O Vênus simplesmente vai ficar com um "ícone" de loading, indicando que o código/programa está sendo executado. Vai ficar assim ad. eternum mas o usuário pode interagir com outras partes do programa sem problemas.

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
