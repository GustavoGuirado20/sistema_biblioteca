unit UController;


interface

uses
  UUsuario, ULivroEmprestado, ULivro, UOperacoes;

  procedure MenuProcedure;
implementation

uses
  SysUtils;

{procedure ControllerUsuario(var aBiblioteca: TBiblioteca; var aUsuario: TUsuario);
begin

end;


function MenuPrincipal: byte;
var
  xOPC: byte;
begin
  writeln('Menu principal');
  writeln('Selecione uma op��o abaixo:');
  writeln('1 - Usu�rios');
  writeln('2 - Acervo');
  writeln('0 - Sair');
  readln(xOpc);
  Result := xOPC;
  writeln;
end;

procedure ControllerPrincipal;
var
  opc: byte;
  xBiblioteca: TBiblioteca;
  xUsuarios: TUsuariosCadastrados;
begin
  xBiblioteca := BibliotecaInicial;
  xUsuarios := UsuariosCadastradosIniciais;
  writeln('Bem vindo ao sistema de biblioteca. ');
  opc := MenuPrincipal;
  while opc <> 0 do
  begin
    case opc of
      1:
      begin
      //  ControllerUsuario;
      end;
    end;
  end;
end;
}

function MenuPrincipal:byte;
var
  opc:byte;
begin
  Writeln('1 - Livro');
  Writeln('2 - Cliente');
  Writeln('0 - Sair');

  readln(opc);
  result := opc;
end;


function MenuLivro:byte;
var
  opc:byte;
begin
  Writeln('1 - Cadastrar Livro');
  Writeln('2 - Pesquisar Livro');
  Writeln('3 - Mostrar Cat�logo');
  Writeln('4 - Quantidade de Livros Emprestados x Dispon�veis');
  Writeln('5 - Pocentagem de Livros Emprestados x Dispon�veis');
  Writeln('6 - Mostrar Livros Dispon�veis ou Emprestados');
  Writeln('7 - Buscar Por C�digo');
  Writeln('0 - Sair');

  readln(opc);
  result := opc;
end;

function MenuCliente1:byte;
var
  opc:byte;
begin
  Writeln('1 - Cadastrar Usu�rio');
  Writeln('2 - Mostrar Todos os Usu�rios');
  Writeln('3 - Menu Usu�rio');
  Writeln('0 Sair');

  readln(opc);
  result := opc;
end;

function MenuCliente2:byte;
var
  opc:byte;
begin
  Writeln('1 - Dados Usu�rio');
  Writeln('2 - Bloquar Usu�rio');
  Writeln('3 - Livors Emprestados');
  Writeln('4 - Renovar Prazo Livro');
  Writeln('5 - Devolver Livro');
  Writeln('6 - Consultar Multas');
  Writeln('7 - Pagar Multas');
  Writeln('0 Sair');

  readln(opc);
  result := opc;
end;

procedure MenuProcedure;
var
  opc:byte;
  xBiblioteca:TBiblioteca;
  xLivro:TLivro;
  xLivroEmprestado:TLivroEmprestado;
  xusuarioscadastrados:TUsuariosCadastrados;
  xusuarios:Tusuario;
  xhistorico:Thistorico;
  nome:string;
  resultado:boolean;
  falso,i,respostas,indice:integer;
begin
  xbiblioteca := bibliotecainicial;
  xusuarioscadastrados := UsuariosCadastradosIniciais;
  opc := menuprincipal;
  while (opc <> 0) do
  begin
    case opc of
    1:
     begin
     opc := menulivro;
      while (MenuLivro <> 0) do
        case MenuLivro of
        1:incluirnovolivro(xBiblioteca);

        2:begin
            repeat
            Writeln('Escreva o nome do livro desejado');
            readln(nome);
            resultado := BuscarLivroPorNome(xLivro, nome,xBiblioteca);
            if (resultado = false) then
            writeln('N�o existe um livro catalogado com o nome informado');
            until resultado = true;
            MostrarLivro(xlivro);
          end;

        3:MostrarCatalogo(xBiblioteca);

        4:Writeln('A Biblioteca possui ' + CalcularQuantidades(xBiblioteca,falso).Tostring + ' livros dispon�veis e ' + falso.tostring + ' livros emprestados');

        5:Writeln((CalcularQuantidades(xBiblioteca,falso) * 100 / pred(length(xBiblioteca))).ToString	 + ' dos est�o dispon�veis e ' + (falso * 100 / pred(length(xBiblioteca))).ToString	 + ' est�o emprestados');

        6:begin
            Writeln('Digite 1 para livros emprestados e 2 para livors dipon�veis');
            readln(respostas);
            if falso = 1 then
              Writeln('A biblioteca possui ' + (falso * 100 / pred(length(xBiblioteca))).ToString + '% de Livros emprestados')
            else
              Writeln('A biblioteca possui ' + (CalcularQuantidades(xBiblioteca,falso) * 100 / pred(length(xBiblioteca))).ToString	 + '% de Livros dispon�veis');
          end;

        7:begin
            BuscarLivroPorCod(falso,xLivro,xBiblioteca,respostas);
            MostrarLivro(xlivro);
           end;
        end;
      end;
     2:begin
        opc := menucliente1;
        while (opc <> 0) do
          case (opc) of
          1:IncluirNovoUsuario(xusuarioscadastrados);

          2:MostrarUsuariosCastrados(xUsuarioscadastrados);

          3:begin
             Writeln('Digite o C�digo de um Cliente');
             readln(respostas);
              repeat
               repeat
                 BuscarUsuarioCodigo(indice,respostas,xusuarios,xusuarioscadastrados);
               until (BuscarUsuarioCodigo(indice,respostas,xusuarios,xusuarioscadastrados) = true);
              MostrarUsuario(xusuarios);
              Writeln('Voc� deseja confirmar esse usu�rios? 1 - Sim 2 - N�o');
              readln(falso);
              until (falso = 1);
                  xhistorico:= xusuarios.Historico;


             while(menucliente2 <> 0) do
              case (menucliente2) of

              1:MostrarUsuario(xusuarios);

              2:alterarBloqueio(xusuarios);

              3:EmprestarLivro(xhistorico,xbiblioteca);

              4:RenovarPrazo(xusuarios.LivrosEmprestados.DataEmprestimo,7);
          end;
        end;
    end;
  end;

 end;
end;
end;
END.

