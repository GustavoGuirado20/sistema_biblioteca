unit UUsuario;

interface

uses ULivro, ULivroEmprestado;

type

  TUsuario = Record
    Cod: Integer;
    Nome: String;
    Telefone: String[11];
    Email: String;
    CPF: String[11];
    LivrosEmprestados:THistorico;
    Historico: THistorico;
  End;

  TUsuariosCadastrados = Array of TUsuario;

  procedure AumentarUsuariosCadastrados(var aUsuariosCadastrados: TUsuariosCadastrados);
  procedure MostrarUsuario(aUsuario: TUsuario);
  function PreencherUsuario(const aNome, aEmail, aCPF, aTelefone: String;
    const aCod: Integer): TUsuario;
  function NumeroAleatorio: String;
  procedure PreencherUsuariosCadastradosIniciais(var aUsuarios: TUsuariosCadastrados);
  procedure MostrarUsuariosCastrados(const aUsuarios: TUsuariosCadastrados);

implementation

uses SysUtils;
{Procedure para aumentar o n�mero de elementos da Array TUsuariosCadastrados em
+1 quando o usu�rio incluir novo usu�rio}
procedure AumentarUsuariosCadastrados(var aUsuariosCadastrados: TUsuariosCadastrados);
begin
  setLength(aUsuariosCadastrados, Length(aUsuariosCadastrados) + 1);
end;

{Function para receber gerar um novo TUsuario.}
function PreencherUsuario(const aNome, aEmail, aCPF, aTelefone: String;
  const aCod: Integer): TUsuario;
var
  xUsuario: TUsuario;
begin
  xUsuario.Cod                       := aCod;
  xUsuario.Nome                      := aNome;
  xUsuario.Telefone                  := aTelefone;
  xUsuario.Email                     := aEmail;
  xUsuario.CPF                       := aCPF;
  //LimparLivroEmprestado(xUsuario.LivrosEmprestados);
  Result := xUsuario;
end;

{Function para gerar n�meros aleat�rios para preencher Telefone e CPF de usu�rios}
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

{Procedure para popular a Array de usu�rios automaticamente para n�o termos que
preenche-la toda hora}
procedure PreencherUsuariosCadastradosIniciais(var aUsuarios: TUsuariosCadastrados);
const
  NOME_EMAIL: array[0..14,0..1] of String =
  (
    ('Emilia Azevedo Silva', 'emiliasilva72@hmail.com'),
    ('Kau� Goncalves Pinto', 'kaue.pinto20@gotmail.com'),
    ('Samuel Cavalcanti Barbosa', 'samuelzim99@gotmail.com'),
    ('Isabela Dias Carvalho', 'isah_gatinha2002@hmail.com'),
    ('Brenda Castro Ribeiro', 'brendacribeiro32@hmail.com'),
    ('Vin�cius Ferreira Costa', 'macinhademodela@gotmail.com'),
    ('Elizeu Drummond', 'drummondaum@ig.com.br'),
    ('Carolina Cardoso', 'carol_4356@yahoo.com.br'),
    ('Laura Martins Araujo', 'lmaraujo@hmail.com'),
    ('Leticia Correa', 'correaleticia23@jmail.com'),
    ('Jo�o Carlos de Souza', 'joaum_do_feijaum@ig.com.br'),
    ('Lucas Azevedo', 'seu_luquinhas@hmail.com'),
    ('Estevan Castro', 'estevan_castro9543@gotmail.com'),
    ('Vit�ria Pinto Dias', 'vividias@gotmail.com'),
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


{Function para retornar o telefone de TUsuario na formata��o (##) #####-####
e muda o terceiro algarismo para 9 para simular um n�mero de telefone real
caso possua 11 caracteres, sen�o retorna a string original}
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

{Function para retornar o telefone de TUsuario na formata��o ###.###.###-##
caso possua 11 caracteres, sen�o retorna a string original}
function FormatarCPF(aCPF: String): String;
begin
  if aCPF.Length = 11 then
    Result := Format('%3.3s.%3.3s.%3.3s-%2.2s',
    [Copy(aCPF, 1, 3), Copy(aCPF, 4, 3), Copy(aCPF, 7, 3), Copy(aCPF, 10, 2)])
  else
    Result := aCPF;
end;

{Procedure para escrever as informa��es de um usu�rio na tela}
procedure MostrarUsuario(aUsuario: TUsuario);
begin
  writeln('C�digo  : ' + aUsuario.Cod.ToString);
  writeln('Nome    : ' + aUsuario.Nome);
  writeln('Telefone: ' + FormatarTelefone(aUsuario.Telefone));
  writeln('CPF     : ' + FormatarCPF(aUsuario.CPF));
  writeln('Email   : ' + aUsuario.Email);
  //MostrarLivroEmprestado(aUsuario.LivrosEmprestados);
  MostrarHistorico(aUsuario.LivrosEmprestados);
  writeln;
end;

{Procedure para escrever as informa��es de todos os usu�rios cadastrados na tela}
procedure MostrarUsuariosCastrados(const aUsuarios: TUsuariosCadastrados);
var
  I: Integer;
begin
  writeln('Total de usu�rios: ' + Length(aUsuarios).ToString);
  for I := 0 to pred(Length(aUsuarios)) do
  begin
    MostrarUsuario(aUsuarios[I]);
  end;
end;

{Procedure para que o usu�rio do sistema cadastre um novo usu�rio da biblioteca}
procedure IncluirNovoUsuario(aCadastrados: TUsuariosCadastrados);
var
  xNome, xTelefone, xEmail, xCPF: String;
begin
  AumentarUsuariosCadastrados(aCadastrados);
  writeln('Insira os dados do usu�rio:');
  write('Nome: ');
  readln(xNome);
  write('Telefone com DDD: ');
  readln(xTelefone);
  write('E-mail: ');
  readln(xEmail);
  write('CPF: ');
  readln(xCPF);
  aCadastrados[Length(aCadastrados) - 1] := PreencherUsuario(xNome, xEmail,
    xCPF, xTelefone, Length(aCadastrados));
end;

end.
