unit ULivro;

interface

type
  TLivro = Record
    Cod: Integer;
    Titulo: String;
    Genero: String;
    Autor: String;
    Prateleira: String[2];
    Disponivel: Boolean;
  End;

  TBiblioteca = Array of TLivro;

  TLivroEmprestado = Record
    Livro: TLivro;
    DataEmprestimo: TDate;
    DataDevolucao: TDate;
  End;

  function PreencherLivro(const aCod: Integer; const aTitulo, aAutor, aGenero, aPrateleira: String;
                          const aDisponivel: Boolean): TLivro;
  function MostrarStatus(aDisponivel: Boolean): String;
  function PreencherLivroEmprestado(const aLivro: TLivro; const aDataEmprestimo,
                                    aDataDevolucao: TDate): TLivroEmprestado;
  procedure PreencherBibliotecaInicial(var aBiblioteca: TBiblioteca);
  function ContarLivrosEmprestadosOuDisponiveis(aBiblioteca: TBiblioteca;
                                                aDisponivel: Boolean): Integer;
  procedure EscreverPorcentagemLivros(aBiblioteca: TBiblioteca; aDisponivel: Boolean);
  procedure IncluirNovoLivro(var aBiblioteca: TBiblioteca);
  procedure AumentarTamanhoArray(var aBiblioteca: TBiblioteca);
  procedure MostrarLivro(aLivro: TLivro);
  procedure MostrarCatalogo(aBiblioteca: TBiblioteca);

implementation

uses SysUtils, UOperacoes;
{Function para returnar TLivro usado para preencher a biblioteca quando o
programa é iniciado ou quando o usuário adiciona um novo livro}
function PreencherLivro(const aCod: Integer; const aTitulo, aAutor, aGenero, aPrateleira: String;
                        const aDisponivel: Boolean): TLivro;
var xLivro: TLivro;
begin
  xLivro.Cod        := aCod;
  xLivro.Titulo     := aTitulo;
  xLivro.Autor      := aAutor;
  xLivro.Genero     := aGenero;
  xLivro.Prateleira := aPrateleira;
  xLivro.Disponivel := aDisponivel;
  Result := xLivro;
end;

function PreencherLivroEmprestado(const aLivro: TLivro; const aDataEmprestimo,
  aDataDevolucao: TDate): TLivroEmprestado;
var
  xLivroEmprestado: TLivroEmprestado;
begin
  xLivroEmprestado.Livro          := aLivro;
  xLivroEmprestado.DataEmprestimo := aDataEmprestimo;
  xLivroEmprestado.DataDevolucao  := aDataDevolucao;
  Result := xLivroEmprestado;
end;

{Procedure para preencher a biblioteca quando o programa é iniciado com livros
pre-gerados}
procedure PreencherBibliotecaInicial(var aBiblioteca: TBiblioteca);
const
  LIVROS: Array[0..19,0..3] of String =
    (
      ('O Labirinto das Sombras', 'Mariana Oliveira', 'Suspense', 'A1'),
      ('O Despertar da Magia', 'Sofia Lemos', 'Fantasia', 'B2'),
      ('Entre o Céu e o Inferno', 'Gabriel Silva', 'Romance', 'C3'),
      ('A Busca pelo Tesouro Perdido', 'Laura Fernandes', 'Aventura', 'D4'),
      ('O Segredo do Passado', 'Pedro Carvalho', 'Mistério', 'E1'),
      ('O Código das Estrelas', 'Ana Santos', 'Ficção Científica', 'F2'),
      ('Amor em Paris', 'Isabela Almeida', 'Romance', 'G3'),
      ('O Último Suspiro', 'Thiago Gomes', 'Suspense', 'H4'),
      ('A Maldição do Espelho', 'Mariana Oliveira', 'Terror', 'A2'),
      ('O Legado dos Antigos', 'Lucas Fernandes', 'Fantasia','B3'),
      ('Cidade das Sombras', 'Carolina Costa', 'Suspense', 'C4'),
      ('O Mistério da Mansão', 'Ana Santos', 'Mistério', 'D1'),
      ('O Portal Encantado', 'Sofia Lemos', 'Fantasia', 'E2'),
      ('No Limite da Razão', 'Felipe Almeida', 'Drama', 'F3'),
      ('O Segredo das Águas', 'Carolina Costa', 'Aventura', 'G4'),
      ('A Queda dos Reinos', 'Mariana Oliveira', 'Fantasia', 'H1'),
      ('O Silêncio da Noite', 'Sofia Lemos', 'Romance', 'A3'),
      ('O Despertar das Trevas', 'Matheus Silva', 'Fantasia', 'B4'),
      ('O Mistério do Relógio', 'Ana Santos', 'Mistério', 'C1'),
      ('O Portal Perdido', 'Lucas Fernandes', 'Aventura', 'D2')
    );
var
  I: Integer;
begin
  SetLength(aBiblioteca, 20);
  for I := 0 to (Length(aBiblioteca) - 1) do
  begin
    aBiblioteca[I] := PreencherLivro(I + 1, LIVROS[I][0], LIVROS[I][1],
                      LIVROS[I][2], LIVROS[I][3], true);
  end;
end;

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

function MostrarStatus(aDisponivel: Boolean): String;
begin
  if aDisponivel then
    Result := 'Disponível'
  else
    Result := 'Emprestado';
end;

function ContarLivrosEmprestadosOuDisponiveis(aBiblioteca: TBiblioteca;
  aDisponivel: Boolean): Integer;
var
I, Contador: Integer;
begin
  Contador := 0;
  for I := 0 to pred(Length(aBiblioteca)) do
  begin
    if aBiblioteca[I].Disponivel = aDisponivel then
      Inc(Contador);
  end;
  Result := Contador;
end;

procedure EscreverPorcentagemLivros(aBiblioteca: TBiblioteca; aDisponivel: Boolean);
begin
  writeln(Format('Total de livros: %d', [Length(aBiblioteca)]));
  writeln(Format('Total de livros com status %s: %d', [MostrarStatus(aDisponivel), ContarLivrosEmprestadosOuDisponiveis(aBiblioteca, aDisponivel)]));
  writeln(Format('Porcentagem de livros com status %s: %s%%', [MostrarStatus(aDisponivel),
                  FormatFloat('#.##', ObterPorcentagem(ContarLivrosEmprestadosOuDisponiveis(aBiblioteca, aDisponivel),
                  Length(aBiblioteca)))]));
end;

end.
