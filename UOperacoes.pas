unit UOperacoes;

interface

  function ObterPorcentagem(aTotal, aValorParcial: Integer): Double;

implementation

function ObterPorcentagem(aTotal, aValorParcial: Integer): Double;
begin
  if aTotal = 0 then
  begin
    Result := 0;
    exit;
  end;
  Result := 100 * aValorParcial / aTotal;
end;

end.
