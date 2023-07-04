unit UController;


interface



implementation

uses
  UUsuario, ULivroEmprestado, ULivro, UOperacoes, SysUtils;

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
  Writeln('4 - Informa��es de Livros Emprestados x Dispon�veis');
  Writeln('5 - Mostrar Livros Dispon�veis');
  Writeln('6 - Mostrar Livros Emprestados');
  Writeln('0 - Sair');

  readln(opc);
  result := opc;
end;

function MenuCliente:byte;
var
  opc:byte;
begin
  Writeln('1 - Cadastrar Usu�rio');
  Writeln('2 - Pesquisar Usu�rio');
  Writeln('3 - Mostrar Todos os Usu�rios');
  Writeln('4 - Bloquear Usu�rio');
  Writeln('5 - Empr�stimos, devolu��es e multas');
  Writeln('0 - Sair');

  readln(opc);
  result := opc;
end;

procedure ControllerCliente(var aBiblioteca: TBiblioteca;
  var aUsuarios: TUsuariosCadastrados);
var
  xOpc: Byte;
begin
  xOpc := MenuCliente;
  while xOpc <> 0 do
  begin
    case xOpc of
      1: IncluirNovoUsuario(aUsuarios);
      2: EscreverResultadoPorNomeUsuario(aUsuarios);
    end;
  end;
end;
procedure ControllerLivro(var aBiblioteca: TBiblioteca);
var
  xOpc: Byte;
begin
  xOpc := MenuLivro;
  while (xOpc <> 0) do
  begin
    case xOpc of
      1: Incluirnovolivro(aBiblioteca);
      2: EscreverResultadoPorNomeLivro(aBiblioteca);
      3: MostrarCatalogo(aBiblioteca);
      4: EscreverRelacaoLivrosDispEmp(aBiblioteca);
      5: MostrarLivrosDisponiveisOuEmprestados(aBiblioteca, true);
      6: MostrarLivrosDisponiveisOuEmprestados(aBiblioteca, false);
    end;
  end;
end;

procedure ControllerPrincipal;
var
  xOpc: Byte;
  xBiblioteca: TBiblioteca;
  xUsuarios: TUsuariosCadastrados;
begin
  xBiblioteca := BibliotecaInicial;
  xUsuarios := UsuariosCadastradosIniciais;
  xOpc := MenuPrincipal;
  while (xOpc <> 0) do
  begin
    case xOpc of
    1: ControllerLivro(xBiblioteca);

    end;
    xOpc := MenuPrincipal;
  end;
end;



end.
