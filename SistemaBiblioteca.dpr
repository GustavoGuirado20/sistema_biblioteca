program SistemaBiblioteca;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UUsuario in 'UUsuario.pas',
  ULivro in 'ULivro.pas',
  UOperacoes in 'UOperacoes.pas',
  ULivroEmprestado in 'ULivroEmprestado.pas',
  UController in 'UController.pas';

//Procedure para testar outros procedures e functions
procedure ControladorTeste;
var
  xBiblioteca: TBiblioteca;
  xUsuariosCadastrados: TUsuariosCadastrados;
begin
  xBiblioteca := BibliotecaInicial;
  xUsuariosCadastrados := UsuariosCadastradosIniciais;
  //MostrarUsuariosCastrados(xUsuariosCadastraddos);
{  EmprestarLivro(xUsuariosCadastrados[0].LivrosEmprestados, xBiblioteca);
  MostrarUsuario(xUsuariosCadastrados[0]);
  writeln('LIVRO EMPRESTADO AQUI');
  MostrarLivro(xUsuariosCadastrados[0].LivrosEmprestados[0].Livro);
  MostrarLivro(xBiblioteca[2]);
  //MostrarCatalogo(xBiblioteca);
  //writeln(Length(xBiblioteca));
  //EscreverPorcentagemLivros(xBiblioteca, false);   }
end;

Function Menu: byte;
var
  opc: byte;
begin
  writeln('Selecione uma opção');
  writeln('1 - Incluir novo livro');
  writeln('2 - Consultar acervo');
  writeln('3 - Consultar livros por gênero');
  writeln('4 - Consultar quantidade de livros por autor');
  writeln('5 - Consultar disponibilidade de um título');
  writeln('6 - Consultar disponibilidade de livros por gênero');
  writeln('0 - Sair');
  writeln;
  readln(opc);
  Result := opc;
end;

procedure Controller;
var
  xBiblioteca: TBiblioteca;
  xUsuariosCadastraddos: TUsuariosCadastrados;
begin

end;

begin
  try
   {  TODO -oUser -cConsole Main : Insert code here }
    ControladorTeste;
    ControllerPrincipal;
    readln;
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      readln;
    end;
  end;
 ControllerPrincipal;
end.
