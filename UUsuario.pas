unit UUsuario;

interface

uses ULivro;

type
  THistorico = Array of TLivroEmprestado;

  TUsuario = Record
    Cod: Integer;
    Nome: String;
    Telefone: String;
    Email: String;
    CPF: String;
    LivroEmprestado: TLivroEmprestado;
    Historico: THistorico;
  End;

  TUsuariosCadastrados = Array of TUsuario;

  procedure MostrarUsuario(aUsuario: TUsuario);
  function PreencherUsuario(const aNome, aEmail, aCPF, aTelefone: String;
    const aCod: Integer): TUsuario;
  function NumeroAleatorio: String;
  procedure PreencherUsuariosCadastradosIniciais(var aUsuarios: TUsuariosCadastrados);
  procedure MostrarUsuariosCastrados(aUsuarios: TUsuariosCadastrados);


implementation

uses SysUtils;

function PreencherUsuario(const aNome, aEmail, aCPF, aTelefone: String;
  const aCod: Integer): TUsuario;
var
  xUsuario: TUsuario;
begin
  xUsuario.Cod      := aCod;
  xUsuario.Nome     := aNome;
  xUsuario.Telefone := aTelefone;
  xUsuario.Email    := aEmail;
  xUsuario.CPF      := aCPF;
  Result := xUsuario;
end;

//Gera números aleatórios para preencher Telefone e CPF de usuários
function NumeroAleatorio: String;
var
  xNumeroString: String;
  I, xDigito: Integer;
begin
  Randomize;
  xNumeroString := '';
  for I := 1 to 11 do
  begin
    xDigito := Random(9);
    if xDigito < 0 then
      xDigito := xDigito * -1;
    xNumeroString := xNumeroString + xDigito.ToString;
  end;
  Result := xNumeroString;
end;

procedure PreencherUsuariosCadastradosIniciais(var aUsuarios: TUsuariosCadastrados);
const
  NOME_EMAIL: array[0..14,0..1] of String =
  (
    ('Emilia Azevedo Silva', 'emiliasilva72@hmail.com'),
    ('Kauê Goncalves Pinto', 'kaue.pinto20@gotmail.com'),
    ('Samuel Cavalcanti Barbosa', 'samuelzim99@gotmail.com'),
    ('Isabela Dias Carvalho', 'isah_gatinha2002@hmail.com'),
    ('Brenda Castro Ribeiro', 'brendacribeiro32@hmail.com'),
    ('Vinícius Ferreira Costa', 'macinhademodela@gotmail.com'),
    ('Elizeu Drummond', 'drummondaum@ig.com.br'),
    ('Carolina Cardoso', 'carol_4356@yahoo.com.br'),
    ('Laura Martins Araujo', 'lmaraujo@hmail.com'),
    ('Leticia Correa', 'correaleticia23@jmail.com'),
    ('João Carlos de Souza', 'joaum_do_feijaum@ig.com.br'),
    ('Lucas Azevedo', 'seu_luquinhas@hmail.com'),
    ('Estevan Castro', 'estevan_castro9543@gotmail.com'),
    ('Vitória Pinto Dias', 'vividias@gotmail.com'),
    ('Julio Fernandes', 'juju_fefe@ig.com.br')
   );
var
  I: Integer;
begin
  SetLength(aUsuarios, 15);
  for I := 0 to 14 do
  begin
    aUsuarios[I] := PreencherUsuario(NOME_EMAIL[I][0], NOME_EMAIL[I][1], NumeroAleatorio, NumeroAleatorio, (I + 1));
  end;
end;

function FormatarTelefone(aTel: String): String;
begin
  if aTel.Length = 11 then
  begin
    aTel[3] := '9';
    Result := Format('(%2.2s) %5.5s-%4.4s',
    [Copy(aTel, 1, 2), Copy(aTel, 3, 5), Copy(aTel, 8, 4)]);
  end
  else
    Result := aTel;
end;

function FormatarCPF(aCPF: String): String;
begin
  if aCPF.Length = 11 then
    Result := Format('%3.3s.%3.3s.%3.3s-%2.2s',
    [Copy(aCPF, 1, 3), Copy(aCPF, 4, 3), Copy(aCPF, 7, 3), Copy(aCPF, 10, 2)])
  else
    Result := aCPF;
end;

procedure MostrarUsuario(aUsuario: TUsuario);
begin
  writeln('Código  : ' + aUsuario.Cod.ToString);
  writeln('Nome    : ' + aUsuario.Nome);
  writeln('Telefone: ' + FormatarTelefone(aUsuario.Telefone));
  writeln('CPF     : ' + FormatarCPF(aUsuario.CPF));
  writeln('Email   : ' + aUsuario.Email);
  writeln;
end;

procedure MostrarUsuariosCastrados(aUsuarios: TUsuariosCadastrados);
var
  I: Integer;
begin
  writeln('Total de usuários: ' + Length(aUsuarios).ToString);
  for I := 0 to pred(Length(aUsuarios)) do
  begin
    MostrarUsuario(aUsuarios[I]);
  end;
end;

end.
