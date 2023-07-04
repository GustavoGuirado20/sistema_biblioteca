unit UOperacoes;

interface

  function ObterPorcentagem(aTotal, aValorParcial: Integer): Double;
  function RetornarInteger: Integer;
  function RetornarChar: char;
  function RetornarByte: byte;

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

end.
