unit ULivroEmprestado;

interface

uses ULivro;

type
  TLivroEmprestado = Record
    Livro: TLivro;
    DataEmprestimo: TDate;
    DataDevolucao: TDate;
    Multa: double;
  End;

  THistorico = Array of TLivroEmprestado;

  function FormatarMulta(aMulta: double): String;
  function PreencherLivroEmprestado(const aLivro: TLivro; const aDataEmprestimo,
                                    aDataDevolucao: TDate): TLivroEmprestado;
  function RenovarPrazo(const aDataEmprestimo: TDate; const aDias: Integer): TDate;
  function FormatarData(aData: TDate): String;
  function EscolherLivroEmprestado(aLivrosEmprestados: THistorico): Byte;
  function CalcularMultasAbertas(aHistorico: THistorico): double;
  function CalcularMultasFechadas(aHistorico: THistorico): double;
  procedure MostrarOpcoesLivroEmprestado(aLivrosEmprestados: THistorico);
  procedure MostrarLivroEmprestado(aEmprestado: TLivroEmprestado);
  procedure AumentarHistorico(var aHistorico: THistorico);
  procedure LimparLivroEmprestado(aEmprestado: TLivroEmprestado);
  procedure EmprestarLivro(var aLivrosEmprestados: THistorico; const aBiblioteca: TBiblioteca);
  procedure MostrarHistorico(aHistorico: THistorico);
  procedure ReduzirHistorico(var aHistorico: THistorico);
  procedure DevolverLivro(var aLivrosEmprestados, aHistorico: THistorico;
    var aBiblioteca: TBiblioteca);
  procedure RegistrarDevolucaoLivro(var aHistorico: THistorico;
  aLivroEmprestado: TLivroEmprestado);
  function CalcularQuantidades(aBiblioteca: TBiblioteca; var emprestados:integer): integer;

implementation

uses SysUtils, DateUtils, UUsuario;

{Procedure para aumentar o n�mero de elementos da Array TBiblioteca em +1
quando o usu�rio incluir novo usu�rio}
procedure aumentarHistorico(var aHistorico: THistorico);
begin
  setLength(aHistorico, Length(aHistorico) + 1);
end;

procedure ReduzirHistorico(var aHistorico: THistorico);
begin
  setLength(aHistorico, Length(aHistorico) - 1);
end;

function FormatarData(aData: TDate): String;
begin
  Result := FormatDateTime('dd/mm/yyyy', aData);
end;

procedure PagarMulta(aEmprestado: TLivroEmprestado);
begin
  aEmprestado.Multa := 0;
end;

function CalcularMulta(aDataDevolucao: TDate): double;
begin
  if Date < aDataDevolucao then
    Result := 0
  else
    Result := 2 * (DaysBetween(Date, aDataDevolucao)).toDouble;
end;

function CalcularMultasFechadas(aHistorico: THistorico): double;
var
  I: Integer;
  xTotalMulta: double;
begin
  xTotalMulta := 0;
  for I := 0 to pred(Length(aHistorico)) do
  begin
    xTotalMulta := xTotalMulta + aHistorico[I].Multa;
  end;
  Result := xTotalMulta;
end;

function CalcularMultasAbertas(aHistorico: THistorico): double;
var
  I: Integer;
  xTotalMulta: double;
begin
  xTotalMulta := 0;
  for I := 0 to pred(Length(aHistorico)) do
  begin
    xTotalMulta := xTotalMulta + CalcularMulta(aHistorico[I].DataDevolucao);
  end;
  Result := xTotalMulta;
end;

procedure AtualizarMulta(aLivroEmprestado: TLivroEmprestado);
begin
  aLivroEmprestado.Multa := CalcularMulta(aLivroEmprestado.DataDevolucao);
end;

function FormatarMulta(aMulta: double): String;
begin
  Result := FormatFloat('R$ 0.00', aMulta);
end;

function RenovarPrazo(const aDataEmprestimo: TDate; const aDias: Integer): TDate;
begin
  Result := IncDay(aDataEmprestimo, aDias);
end;


{Procedure para limpar todas as informa��es de livro emprestado de um usu�rio,
usada tanto para fazer a devolu��o de um livro como para registrar um usu�rio
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
  aEmprestado.Multa          := 0;
end;

procedure MostrarOpcoesLivroEmprestado(aLivrosEmprestados: THistorico);
var
  I: Integer;
begin
  for I := 0 to pred(Length(aLivrosEmprestados)) do
  begin
    writeln('Op��o' + (I + 1).ToString);
    writeln(aLivrosEmprestados[I].Livro.Titulo);
    writeln('Data de empr�stimo: ' + FormatarData(aLivrosEmprestados[I]
      .DataEmprestimo));
    writeln('Data de devolu��o: ' + FormatarData(aLivrosEmprestados[I]
      .DataDevolucao));
    writeln;
  end;
end;

procedure ReorganizarHistorico(var aHistorico: THistorico);
var
  I: Integer;
begin
  for I := 0 to pred(Length(aHistorico)) do
  begin
    if (aHistorico[I].DataEmprestimo = 0) and (aHistorico[I].DataDevolucao = 0)
      and (Length(aHistorico) > 1) then
    begin
      aHistorico[I] :=  aHistorico[I + 1];
      LimparLivroEmprestado(aHistorico[I + 1]);
    end;
  end;
end;

procedure RegistrarDevolucaoLivro(var aHistorico: THistorico;
  aLivroEmprestado: TLivroEmprestado);
begin
  AumentarHistorico(aHistorico);
  aHistorico[pred(Length(aHistorico))]               := aLivroEmprestado;
  aHistorico[pred(Length(aHistorico))].DataDevolucao := Date;
  LimparLivroEmprestado(aLivroEmprestado);
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
  xLivroEmprestado.Multa          := CalcularMulta(aDataDevolucao);
  Result := xLivroEmprestado;
end;

{Procedure para escrever informa��es de um livro emprestado. Caso a data de
empr�stimo for 0, ele escrever� que o usu�rio n�o emprestou nenhum livro}
procedure MostrarLivroEmprestado(aEmprestado: TLivroEmprestado);
begin
  if aEmprestado.DataEmprestimo > 0 then
  begin
    MostrarLivro(aEmprestado.Livro);
    writeln('Data de empr�stimo: ' + DateToStr(aEmprestado.DataEmprestimo));
    writeln('Data de devolu��o: ' + DateToStr(aEmprestado.DataDevolucao));
    if aEmprestado.Multa > 0 then
    begin
      writeln('Multa: ' + FormatarMulta(aEmprestado.Multa));
    end;
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
  writeln('-----------------------------------------------------');
  writeln('Total de livros emprestados: ' + Length(aHistorico).ToString);
  for I := 0 to pred(Length(aHistorico)) do
  begin
    MostrarLivroEmprestado(aHistorico[I]);
  end;
  writeln('-----------------------------------------------------');

end;

procedure EmprestarLivro(var aLivrosEmprestados: THistorico; const aBiblioteca: TBiblioteca);
var
  xIndice, xCod, I: Integer;
  xLivro: TLivro;
  xConfirma: char;
begin
  if Length(aLivrosEmprestados) > 5 then
  begin
    writeln('O usu�rio j� possui 5 livros emprestados');
    exit;
  end;

  Repeat
    write('Insira o c�digo do livro a ser emprestado: ');
    readln(xCod);
    while (BuscarLivroPorCod(xIndice, xLivro, aBiblioteca, xCod) = false) do
    begin
      writeln('Livro de c�digo ' + xCod.ToString + ' n�o localizado. Insira um ' +
      'n�mero correto ou 0 para sair.');
      write('C�digo: ');
      readln(xCod);
      if xCod = 0 then
        exit;
    end;
    MostrarLivro(xLivro);
    if xLivro.Disponivel = false then
    begin
      writeln('O livro n�o est� dispon�vel. Selecione outro');
      continue;
    end;
    writeln('Deseja emprestar o livro ' + xLivro.Titulo +'? (S/N)');
    readln(xConfirma);
  until UpCase(xConfirma) = 'S';
  AumentarHistorico(aLivrosEmprestados);
  aLivrosEmprestados[Length(aLivrosEmprestados) - 1] :=
    PreencherLivroEmprestado(xLivro, Date, RenovarPrazo(Date, 7));
  AlterarDisponibilidade(aBiblioteca[xIndice]);
end;

function EscolherLivroEmprestado(aLivrosEmprestados: THistorico): Byte;
var
  I: Integer;
  xOpc: Byte;
begin
  MostrarOpcoesLivroEmprestado(aLivrosEmprestados);
  write('Op��o: ');
  readln(xOpc);
  while (xOpc < 1) or (xOpc > Length(aLivrosEmprestados)) do
  begin
    writeln('Op��o inv�lida. Selecione uma das op��es:');
    MostrarOpcoesLivroEmprestado(aLivrosEmprestados);
    write('Op��o: ');
    readln(xOpc);
  end;
  Result := xOpc  + 1;
end;

procedure ChecarMultaLivro(var aEmprestado: TLivroEmprestado);
var
  xEscolha: char;
  xLivro: TLivro;
begin
  writeln('Data prevista de devolu��o: ' + formatarData(aEmprestado.DataDevolucao));
  writeln('Data atual: ' + formatarData(Date));
  AtualizarMulta(aEmprestado);
  if aEmprestado.Multa > 0 then
  begin
    writeln('O atraso gerou uma multa de ' + FormatarMulta(aEmprestado.Multa) + '.');
    write('Deseja pagar a multa agora? (S/N)');
    readln(xEscolha);
    if upCase(xEscolha) = 'S' then
      PagarMulta(aEmprestado)
  end;
end;

procedure DevolverLivro(var aLivrosEmprestados, aHistorico: THistorico; var aBiblioteca: TBiblioteca);
var
  xOpc: Byte;
  xIndice: Integer;
begin
  writeln('Selecione uma op��o');
  xOpc := EscolherLivroEmprestado(aLivrosEmprestados);
  ChecarMultaLivro(aLivrosEmprestados[xOpc]);
  RegistrarDevolucaoLivro(aHistorico, aLivrosEmprestados[xOpc]);
  LimparLivroEmprestado(aLivrosEmprestados[xOpc]);
  ReduzirHistorico(aLivrosEmprestados);
  BuscarLivroPorCod(xIndice, aLivrosEmprestados[xOpc].Livro,
    aBiblioteca,aLivrosEmprestados[xOpc].Livro.Cod);
  AlterarDisponibilidade(aBiblioteca[xIndice]);
  writeln('Livro ' + aLivrosEmprestados[xOpc].Livro.Titulo +
    ' devolvido com sucesso');
end;

//Clacular quantidade de livros emprestados
function CalcularQuantidades(aBiblioteca: TBiblioteca; var emprestados:integer): integer;
var
  i,cont:integer;
begin
  cont :=0;
  emprestados := 0;
  for i := 0 to pred(length(aBiblioteca)) do
    if aBiblioteca[i].Disponivel = true then
    cont := cont + 1
    else
    emprestados := emprestados + 1;

  result := cont;

end;
end.
