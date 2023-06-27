unit UOperacoes;

interface

  function ObterPorcentagem(aValorParcial, aTotal: Integer): Double;

implementation

function ObterPorcentagem(aValorParcial, aTotal: Integer): Double;
begin
  Result := 100 * aValorParcial / aTotal;
end;

end.
