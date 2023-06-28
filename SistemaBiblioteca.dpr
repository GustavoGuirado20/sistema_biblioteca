program SistemaBiblioteca;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UUsuario in 'UUsuario.pas',
  ULivro in 'ULivro.pas',
  UOperacoes in 'UOperacoes.pas',
  ULivroEmprestado in 'ULivroEmprestado.pas';

//Procedure para testar outros procedures e functions
procedure ControladorTeste;
var
  xBiblioteca: TBiblioteca;
  xUsuariosCadastraddos: TUsuariosCadastrados;
begin
  preencherBibliotecaInicial(xBiblioteca);
  PreencherUsuariosCadastradosIniciais(xUsuariosCadastraddos);
  MostrarUsuariosCastrados(xUsuariosCadastraddos);
  //MostrarCatalogo(xBiblioteca);
  //writeln(Length(xBiblioteca));
  //EscreverPorcentagemLivros(xBiblioteca, false);
end;

Function Menu: byte;
var
  opc: byte;
begin
  writeln('Selecione uma op��o');
  writeln('1 - Incluir novo livro');
  writeln('2 - Consultar acervo');
  writeln('3 - Consultar livros por g�nero');
  writeln('4 - Consultar quantidade de livros por autor');
  writeln('5 - Consultar disponibilidade de um t�tulo');
  writeln('6 - Consultar disponibilidade de livros por g�nero');
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
    { TODO -oUser -cConsole Main : Insert code here }
    ControladorTeste;
    readln;
  except
    on E: Exception do
    begin
      Writeln(E.ClassName, ': ', E.Message);
      readln;
    end;
  end;
end.
