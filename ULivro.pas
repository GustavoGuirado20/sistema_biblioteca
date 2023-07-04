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

  function PreencherLivro(const aCod: Integer; const aTitulo, aAutor, aGenero, aPrateleira: String;
                          const aDisponivel: Boolean): TLivro;
  function MostrarStatus(const aDisponivel: Boolean): String;

  function BibliotecaInicial: TBiblioteca;
  function ContarLivrosEmprestadosOuDisponiveis(aBiblioteca: TBiblioteca;
                                                aDisponivel: Boolean): Integer;
  {procedure MostrarPorcentagemLivros(const aBiblioteca: TBiblioteca);}
  procedure IncluirNovoLivro(var aBiblioteca: TBiblioteca);
  procedure AumentarBiblioteca(var aBiblioteca: TBiblioteca);
  procedure MostrarLivro(const aLivro: TLivro);
  procedure MostrarCatalogo(const aBiblioteca: TBiblioteca);
  procedure AlterarDisponibilidade(var aLivro: TLivro);
  function BuscarLivroPorCod(var aIndice: Integer; var aLivro: TLivro;
    const aBiblioteca: TBiblioteca; const aCod: Integer): Boolean;
  procedure MostrarLivrosDisponiveisOuEmprestados(const aBiblioteca: TBiblioteca;
    const aDisponivel: Boolean);
  function BuscarLivroPorNome(var aLivro:TLivro; Nome:string; aBiblioteca:TBiblioteca): boolean;
  procedure EscreverResultadoPorNomeLivro(const aBiblioteca: TBiblioteca);
  function CalcularQuantidadeEmprestados(aBiblioteca: TBiblioteca): Integer;
  procedure EscreverRelacaoLivrosDispEmp(aBiblioteca: TBiblioteca);

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

{Procedure para preencher a biblioteca quando o programa é iniciado com livros
pre-gerados}
function BibliotecaInicial: TBiblioteca;
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
  xBiblioteca: TBiblioteca;
begin
  SetLength(xBiblioteca, 20);
  for I := 0 to (Length(xBiblioteca) - 1) do
  begin
    xBiblioteca[I] := PreencherLivro(I + 1, LIVROS[I][0], LIVROS[I][1],
                      LIVROS[I][2], LIVROS[I][3], true);
  end;

  Result := xBiblioteca;
end;

procedure AlterarDisponibilidade(var aLivro: TLivro);
begin
  aLivro.Disponivel := not aLivro.Disponivel;
end;
{Procedure para aumentar o número de elementos da Array TBiblioteca em +1
quando o usuário incluir novo livro}
procedure AumentarBiblioteca(var aBiblioteca: TBiblioteca);
begin
  SetLength(aBiblioteca, Length(aBiblioteca) + 1);
end;

//Procedure para imprimir na tela informações de um TLivro
procedure MostrarLivro(const aLivro: TLivro);
begin
  writeln(Format('Título: %s, Autor: %s, Gênero: %s, Prateleira: %s, Status: %s',
              [aLivro.Titulo, aLivro.Autor, aLivro.Genero,
              aLivro.Prateleira, MostrarStatus(aLivro.Disponivel)]));
end;

//Procedure para imprimir na tela todo o acervo cadastrado no array TBiblioteca
procedure MostrarCatalogo(const aBiblioteca: TBiblioteca);
var
  I: Integer;
begin
  writeln('Acervo de ' + Length(aBiblioteca).ToString + ' livros');
  for I := 0 to pred(Length(aBiblioteca)) do
  begin
    writeln('Informações do livro ' + (I + 1).ToString);
    MostrarLivro(aBiblioteca[I]);
    writeln;
  end;
end;

{Procedure para escrever na tela todos os livros emprestados ou livres.}
procedure MostrarLivrosDisponiveisOuEmprestados(const aBiblioteca: TBiblioteca; const aDisponivel: Boolean);
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

{Procedure que permite ao usuário do sistema cadastrar um novo livro e o insere
no último elemento da array aBiblioteca}
procedure IncluirNovoLivro(var aBiblioteca: TBiblioteca);
var
  xTitulo, xAutor, xGenero: String;
  xPrateleira: String[2];
begin
  AumentarBiblioteca(aBiblioteca);
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

{Function que retorna String informando se o livro está disponível ou não}
function MostrarStatus(const aDisponivel: Boolean): String;
begin
  if aDisponivel then
    Result := 'Disponível'
  else
    Result := 'Emprestado';
end;

{Function que retorna Integer correspondendte ao número de livros disponíveis ou
emprestados (aDisponível true para disponíveis e false para emprestados)}
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

{Procedure que mostra na tela o percentual de livros disponíveis  ou emprestados
de acordo com o parâmetro aDisponivel}
{procedure MostrarPorcentagemLivros(const aBiblioteca: TBiblioteca);
begin
  writeln(Format('Total de livros: %d', [Length(aBiblioteca)]));
  writeln(Format('Total de livros com status %s: %d', [MostrarStatus(true), ContarLivrosEmprestadosOuDisponiveis(aBiblioteca, aDisponivel)]));
  writeln(Format('Porcentagem de livros com status %s: %s%%', [MostrarStatus(true),
                  FormatFloat('#.##', ObterPorcentagem(ContarLivrosEmprestadosOuDisponiveis(aBiblioteca, aDisponivel),
                  Length(aBiblioteca)))]));
end;}

{Function que retorna um TLivro da array aBiblioteca cujo codigo corresponda ao parâmetro aCod}
function BuscarLivroPorCod(var aIndice: Integer; var aLivro: TLivro;
  const aBiblioteca: TBiblioteca; const aCod: Integer): Boolean;
var
  I: Integer;
begin
  for I := 0 to pred(Length(aBiblioteca)) do
  begin
    if aCod = aBiblioteca[I].cod then
    begin
      Result  := true;
      aLivro  := aBiblioteca[I];
      aIndice := I;
      exit;
    end;
  end;
  //writeln('Não foi possível localizar nenhum livro com o código ' + aCod.ToString);
  Result := false;
end;

function BuscarLivroPorNome(var aLivro:TLivro; Nome:string; aBiblioteca:TBiblioteca): boolean;
var
  I: Integer;
begin
  result := false;
  for i := 0 to pred(length(aBiblioteca)) do
    if (uppercase(aBiblioteca[i].Titulo) = uppercase(nome)) then
    begin
    result:= true;
    alivro := abiblioteca[i];
    exit;
    end;
end;

procedure EscreverResultadoPorNomeLivro(const aBiblioteca: TBiblioteca);
var
  xNome: String;
  xLivro: TLivro;
  xNovamente: char;
begin
  Repeat
    Writeln('Escreva o nome do livro desejado');
    readln(xNome);
    if not BuscarLivroPorNome(xLivro, xNome, aBiblioteca) then
      writeln('Não existe um livro catalogado com o nome ' + xNome)
    else
      MostrarLivro(xLivro);
    write('Deseja efetuar uma nova busca? (S/N)');
    readln(xNovamente);
  Until xNovamente <> UpCase('S');
end;

//Clacular quantidade de livros emprestados
function CalcularQuantidadeEmprestados(aBiblioteca: TBiblioteca): Integer;
var
  I, Cont: Integer;
begin
  cont := 0;
  for i := 0 to pred(length(aBiblioteca)) do
  begin
    if aBiblioteca[i].Disponivel = false then
    begin
      cont := cont + 1;
    end;
  end;
  result := cont;
end;

procedure EscreverRelacaoLivrosDispEmp(aBiblioteca: TBiblioteca);
var
  xQtdLivrosDisponiveis: Integer;
begin
  xQtdLivrosDisponiveis := Length(aBiblioteca) - CalcularQuantidadeEmprestados(aBiblioteca);
  writeln('Total de livros: ' + Length(aBiblioteca).ToString);
  writeln('Livros disponíveis: ' + xQtdLivrosDisponiveis.ToString);
  writeln('Porcentagem de livros disponíveis: ' + FormatFloat('#.##',
    ObterPorcentagem(Length(aBiblioteca), xQtdLivrosDisponiveis)));
  writeln('Livros emprestados: ' +
    CalcularQuantidadeEmprestados(aBiblioteca).ToString);
  writeln('Porcentagem de livros disponíveis: ' + FormatFloat('#.##',
    ObterPorcentagem(Length(aBiblioteca),
    CalcularQuantidadeEmprestados(aBiblioteca))));
end;


end.
