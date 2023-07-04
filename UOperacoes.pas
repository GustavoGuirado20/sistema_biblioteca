unit UOperacoes;

interface

uses UUsuario, ULivro, ULivroEmprestado;
  function ObterPorcentagem(aTotal, aValorParcial: Integer): Double;
  function RetornarInteger: Integer;
  function RetornarChar: char;
  function RetornarByte: byte;
  procedure OperacoesIniciais(var aBiblioteca: TBiblioteca;
    var aUsuarios:TUsuariosCadastrados);

implementation

uses SysUtils;

function ObterPorcentagem(aTotal, aValorParcial: Integer): Double;
begin
  if aTotal = 0 then
  begin
    Result := 0;
    exit;
  end;
  Result := 100 * aValorParcial / aTotal;
end;

function RetornarChar: char;
var
  xValor: String;

begin
  readln(xValor);
  Result := xValor[1];
end;

function RetornarByte: byte;
var
  xValor: String;
  xInteger: Integer;
begin
  readln(xValor);
  if not TryStrToInt(xValor, xInteger) then
    Result := 255
  else
    Result := Byte(xInteger);
end;

function RetornarInteger: Integer;
var
  xValor: String;
begin
  readln(xValor);
  if not TryStrToInt(xValor, Result) then
    Result := -1;
end;

procedure EmprestarLivroInicial(aIdL, aIdU: Integer;
  var aB: TBiblioteca; var aU: TUsuariosCadastrados;
  DataE, DataD: TDate);
begin
  AumentarHistorico(aU[aIdU].LivrosEmprestados);
  aU[aIdU].LivrosEmprestados[Length(aU[aIdU].LivrosEmprestados) - 1] :=
    PreencherLivroEmprestado(aB[aIdL], DataE, DataD);
  AlterarDisponibilidade(aB[aIdL]);
end;

procedure DevolverLivroInicial(aIdL, aIdU, aIdLE: Integer;
  var aB: TBiblioteca; var aU: TUsuariosCadastrados;
  DataE, DataD: TDate);
begin
  //ChecarMultaLivro(aU[aIdU].LivrosEmprestados[aIdLE]);
  RegistrarDevolucaoLivro(aU[aIdU].Historico, aU[aIdU].LivrosEmprestados[aIdLE]);
  BuscarLivroPorCod(aIdL, aU[aIdU].LivrosEmprestados[aIdLE].Livro,
    aB,aU[aIdU].LivrosEmprestados[aIdLE].Livro.Cod);
  AlterarDisponibilidade(aB[aIdL]);
  ReduzirHistorico(aU[aIdU].LivrosEmprestados);
end;

procedure OperacoesIniciais(var aBiblioteca: TBiblioteca;
  var aUsuarios:TUsuariosCadastrados);
var
  xIdL, xIdU: Integer;
begin
  EmprestarLivroInicial(4, 14, aBiblioteca, aUsuarios,
    EncodeDate(2023, 05, 20), EncodeDate(2023, 05, 27));
  EmprestarLivroInicial(6, 14, aBiblioteca, aUsuarios,
    EncodeDate(2023, 05, 21), EncodeDate(2023, 05, 30));
   EmprestarLivroInicial(19, 14, aBiblioteca, aUsuarios,
    EncodeDate(2023, 04, 20), EncodeDate(2023, 04, 26));
end;

end.
