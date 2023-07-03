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
  writeln('Selecione uma opção abaixo:');
  writeln('1 - Usuários');
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
  Writeln('3 - Mostrar Catálogo');
  Writeln('4 - Quantidade de Livros Emprestados x Disponíveis');
  Writeln('5 - Pocentagem de Livros Emprestados x Disponíveis');
  Writeln('6 - Mostrar Livros Disponíveis ou Emprestados');
  Writeln('7 - Buscar Por Código');
  Writeln('0 - Sair');

  readln(opc);
  result := opc;
end;

function MenuCliente1:byte;
var
  opc:byte;
begin
  Writeln('1 - Cadastrar Usuário');
  Writeln('2 - Mostrar Todos os Usuários');
  Writeln('3 - Menu Usuário');
  Writeln('0 Sair');

  readln(opc);
  result := opc;
end;

function MenuCliente2:byte;
var
  opc:byte;
begin
  Writeln('1 - Dados Usuário');
  Writeln('2 - Bloquar Usuário');
  Writeln('3 - Desbloquear Usuário');
  Writeln('4 - Livors Emprestados');
  Writeln('5 - Renovar Prazo Livro');
  Writeln('6 - Devolver Livro');
  Writeln('7 - Consultar Multas');
  Writeln('8 - Pagar Multas');
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
  nome:string;
  resultado:boolean;
  falso,i,respostas:integer;
begin

  while (MenuPrincipal <> 0) do
  begin
    case MenuPrincipal of
    1:
     begin
      while (MenuLivro <> 0) do
        case MenuLivro of
        1:incluirnovolivro(xBiblioteca);

        2:begin
            repeat
            Writeln('Escreva o nome do livro desejado');
            readln(nome);
            BuscarLivroPorNome(xLivro, nome,xBiblioteca);
            if (resultado = false) then
            writeln('Não existe um livro catalogado com o nome informado');
            until resultado = true;
            MostrarLivro(xlivro);
          end;

        3:MostrarCatalogo(xBiblioteca);

        4:Writeln('A Biblioteca possui ' + CalcularQuantidades(xBiblioteca,falso).Tostring + ' livros disponíveis e ' + falso.tostring + ' livros emprestados');

        5:Writeln((CalcularQuantidades(xBiblioteca,falso) * 100 / pred(length(xBiblioteca))).ToString	 + ' dos estão disponíveis e ' + (falso * 100 / pred(length(xBiblioteca))).ToString	 + ' estão emprestados');

        6:begin
            Writeln('Digite 1 para livros emprestados e 2 para livors diponíveis');
            readln(respostas);
            if falso = 1 then
              Writeln('A biblioteca possui ' + (falso * 100 / pred(length(xBiblioteca))).ToString + '% de Livros emprestados')
            else
              Writeln('A biblioteca possui ' + (CalcularQuantidades(xBiblioteca,falso) * 100 / pred(length(xBiblioteca))).ToString	 + '% de Livros disponíveis');
          end;

        7:begin
            BuscarLivroPorCod(falso,xLivro,xBiblioteca,respostas);
            MostrarLivro(xlivro);
           end;
        end;
      end;
     2:begin
        while (MenuCliente1 <> 0) do
          case (MenuCliente1) of
        //  1:

          2:MostrarUsuariosCastrados(xUsuarioscadastrados);

          3:begin
             Writeln('Digite o Código de um Cliente');
             readln(respostas);
             while(MenuCliente2 <> 0) do
              case (MenuCliente2) of

              1:begin
                for I := 0 to pred(length(xBiblioteca)) do
                  if xusuarioscadastrados[i].Cod = respostas then
                  xusuarios := xusuarioscadastrados[i];
                  break;
                MostrarUsuario(xusuarios);


              end;
              end;

            end;
          end;
    end;
  end;
 end;
end;
END.
