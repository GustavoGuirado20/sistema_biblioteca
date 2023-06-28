unit ULivroEmprestado;

interface

uses ULivro;

type
  TLivroEmprestado = Record
    Livro: TLivro;
    DataEmprestimo: TDate;
    DataDevolucao: TDate;
  End;

  THistorico = Array of TLivroEmprestado;

  procedure AumentarHistorico(var aHistorico: THistorico);
  function PreencherLivroEmprestado(const aLivro: TLivro; const aDataEmprestimo,
                                    aDataDevolucao: TDate): TLivroEmprestado;
  procedure LimparLivroEmprestado(aEmprestado: TLivroEmprestado);
  procedure MostrarLivroEmprestado(aEmprestado: TLivroEmprestado);
  function RenovarPrazo(const aDataEmprestimo: TDate; const aDias: Integer): TDate;
  procedure EmprestarLivro(var aLivrosEmprestados: THistorico; const aBiblioteca: TBiblioteca);
  procedure MostrarHistorico(aHistorico: THistorico);

implementation

uses SysUtils, DateUtils;

{Procedure para aumentar o número de elementos da Array TBiblioteca em +1
quando o usuário incluir novo usuário}
procedure aumentarHistorico(var aHistorico: THistorico);
begin
  setLength(aHistorico, Length(aHistorico) + 1);
end;



function RenovarPrazo(const aDataEmprestimo: TDate; const aDias: Integer): TDate;
begin
  Result := IncDay(aDataEmprestimo, aDias);
end;
{Procedure para limpar todas as informações de livro emprestado de um usuário,
usada tanto para fazer a devolução de um livro como para registrar um usuário
novo}
procedure LimparLivroEmprestado(aEmprestado: TLivroEmprestado);
begin
  with aEmprestado.Livro do
  begin
    Cod        := 0;
    Titulo     := '';
    Autor      := '';
    Genero     := '';
    Prateleira := '';
    Disponivel := true;
  end;
  aEmprestado.DataEmprestimo := 0;
  aEmprestado.DataDevolucao  := 0;
end;

{Function que retorna um Record TLivroEmprestado}
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

{Procedure para escrever informações de um livro emprestado. Caso a data de
empréstimo for 0, ele escreverá que o usuário não emprestou nenhum livro}
procedure MostrarLivroEmprestado(aEmprestado: TLivroEmprestado);
begin
  if aEmprestado.DataEmprestimo > 0 then
  begin
    MostrarLivro(aEmprestado.Livro);
    writeln('Data de empréstimo: ' + DateToStr(aEmprestado.DataEmprestimo));
    writeln('Data de devolução: ' + DateToStr(aEmprestado.DataDevolucao));
  end;
  {else
    writeln('Nenhum livro emprestado no momento');}
end;

procedure MostrarHistorico(aHistorico: THistorico);
var
  I: Integer;
begin
  if Length(aHistorico) = 0 then
  begin
    writeln('Nenhum livro emprestado no momento');
    exit;
  end;
  writeln('Total de livros emprestados atualmente: ' + Length(aHistorico).ToString);
  for I := 0 to pred(Length(aHistorico)) do
  begin
    MostrarLivroEmprestado(aHistorico[I]);
  end;

end;

procedure EmprestarLivro(var aLivrosEmprestados: THistorico; const aBiblioteca: TBiblioteca);
var
  xCod, I: Integer;
  xLivro: TLivro;
  xConfirma: char;
begin
  if Length(aLivrosEmprestados) > 5 then
  begin
    writeln('O usuário já possui 5 livros emprestados');
    exit;
  end;

  AumentarHistorico(aLivrosEmprestados);
  Repeat
    write('Insira o código do livro a ser emprestado: ');
    readln(xCod);
    while (not BuscarLivroPorCod(xLivro, aBiblioteca, xCod)) do
    begin
      writeln('Livro de código ' + xCod.ToString + ' não localizado. Insira um ' +
      'número correto ou 0 para sair.');
      write('Código: ');
      readln(xCod);
      if xCod = 0 then
        exit;
    end;
    MostrarLivro(xLivro);
    writeln('Deseja emprestar o livro ' + xLivro.Titulo +'? (S/N)');
    readln(xConfirma);
  until UpCase(xConfirma) = 'S';
  aLivrosEmprestados[Length(aLivrosEmprestados) - 1] :=
    PreencherLivroEmprestado(xLivro, Date, RenovarPrazo(Date, 7));
end;

end.
