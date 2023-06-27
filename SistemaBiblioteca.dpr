program SistemaBiblioteca;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UUsuario in 'UUsuario.pas',
  ULivro in 'ULivro.pas',
  UOperacoes in 'UOperacoes.pas';

{Procedure para aumentar o tamanho da TBiblioteca em +1 quando o usuário incluir
novo livro}
procedure AumentarTamanhoArray(var aBiblioteca: TBiblioteca);
begin
  SetLength(aBiblioteca, Length(aBiblioteca) + 1);
end;

//Procedure para imprimir na tela informações de um TLivro
procedure MostrarLivro(aLivro: TLivro);
begin
  writeln(Format('Título: %s, Autor: %s, Gênero: %s, Prateleira: %s, Status: %s',
              [aLivro.Titulo, aLivro.Autor, aLivro.Genero,
              aLivro.Prateleira, MostrarStatus(aLivro.Disponivel)]));
  writeln;
end;

//Procedure para imprimir na tela todo o acervo cadastrado no array TBiblioteca
procedure MostrarCatalogo(aBiblioteca: TBiblioteca);
var
  I: Integer;
begin
  writeln('Acervo de ' + Length(aBiblioteca).ToString + ' livros');
  for I := 0 to pred(Length(aBiblioteca)) do
  begin
    writeln('Informações do livro ' + (I + 1).ToString);
    MostrarLivro(aBiblioteca[I]);
  end;
end;

{Procedure para escrever na tela todos os livros emprestados ou livres.}
procedure MostrarLivrosDisponiveisOuEmprestados(aBiblioteca: TBiblioteca; aDisponivel: Boolean);
var
  xTexto: String;
  I, Contador: Integer;
begin
  writeln(Format('Total de livros com status %s: %d', [MostrarStatus(aDisponivel), ContarLivrosEmprestadosOuDisponiveis(aBiblioteca, aDisponivel)]));
  for I := 0 to pred(Length(aBiblioteca)) do
  begin
    if aBiblioteca[I].Disponivel = aDisponivel then
      MostrarLivro(aBiblioteca[I]);
  end;
end;

//Procedure para cadastrar um novo livro no acervo
procedure IncluirNovoLivro(var aBiblioteca: TBiblioteca);
var
  xTitulo, xAutor, xGenero: String;
  xPrateleira: String[2];
begin
  AumentarTamanhoArray(aBiblioteca);
  write('Insira o título do livro: ');
  readln(xTitulo);
  write('Insira o nome do autor: ');
  readln(xAutor);
  write('Insira o gênero da obra: ');
  readln(xGenero);
  write('Insira a prateleira do livro: ');
  readln(xPrateleira);
  aBiblioteca[Length(aBiblioteca) - 1] := PreencherLivro(Length(aBiblioteca), xTitulo, xAutor, xGenero, xPrateleira, true);
  writeln('Livro ' + xTitulo + ' cadastrado com sucesso');
  MostrarLivro(aBiblioteca[Length(aBiblioteca) - 1]);
end;

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
