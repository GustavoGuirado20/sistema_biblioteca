unit UController;


interface

uses
  UUsuario, ULivroEmprestado, ULivro;

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
  Writeln('8 - Emprestar Livro');
  Writeln('9 - Renovar Prazo de Emprestimo');
  Writeln('0 - Sair');

  readln(opc);
  result := opc;
end;

function MenuCliente:byte;
var
  opc:byte;
begin
  Writeln('1 - Cadastrar Usuário');
  Writeln('2 - Pesquisar Usuário');
  Writeln('3 - Mostrar Todos os Usuários');
  Writeln('4 - Bloquear Usuário');
  Writeln('0 Sair');

  readln(opc);
  result := opc;
end;

procedure MenuProcedure;
var
  opc:byte;
  xBiblioteca:TBiblioteca;
  xLivro:TLivro;
  nome:string;
  resultado:boolean;
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

        3:

        end;
     end
    end;


  end;
end;
END.
