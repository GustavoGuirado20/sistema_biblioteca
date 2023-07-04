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
    Bloqueado: Boolean;
    LivrosEmprestados: THistorico;
    Historico: THistorico;
  End;

  TUsuariosCadastrados = Array of TUsuario;

  procedure AumentarUsuariosCadastrados(var aUsuariosCadastrados
    : TUsuariosCadastrados);
  procedure MostrarUsuario(aUsuario: TUsuario);
  function MostrarBloqueio(aBloqueio: Boolean): String;
  function PreencherUsuario(const aNome, aEmail, aCPF, aTelefone: String;
    const aCod: Integer): TUsuario;
  function NumeroAleatorio: String;
  function UsuariosCadastradosIniciais: TUsuariosCadastrados;
  procedure MostrarUsuariosCastrados(const aUsuarios: TUsuariosCadastrados);
  procedure BloquearOuDesbloquearUsuario(var aUsuario: TUsuario);
  procedure EscreverResultadoPorNomeUsuario(const aUsuarios: TUsuariosCadastrados);
  procedure ConfirmarBloqueioDesbloqueio(var aUsuario: TUsuario);
  function IdentificarUsuarioPorCod(aUsuarios: TUsuariosCadastrados): Integer;
  procedure EfetuarBloqueioDesbloqueio(var aUsuarios: TUsuariosCadastrados);
  procedure TelaPagarMulta(var aUsuario: TUsuario);
  procedure IncluirNovoUsuario(var aCadastrados: TUsuariosCadastrados);

implementation

uses SysUtils, UOperacoes;

{ Procedure para aumentar o n�mero de elementos da Array TUsuariosCadastrados em
  +1 quando o usu�rio incluir novo usu�rio }
procedure AumentarUsuariosCadastrados(var aUsuariosCadastrados
  : TUsuariosCadastrados);
begin
  setLength(aUsuariosCadastrados, Length(aUsuariosCadastrados) + 1);
end;

{ Function para receber gerar um novo TUsuario. }
function PreencherUsuario(const aNome, aEmail, aCPF, aTelefone: String;
  const aCod: Integer): TUsuario;
var
  xUsuario: TUsuario;
begin
  xUsuario.Cod       := aCod;
  xUsuario.Nome      := aNome;
  xUsuario.Telefone  := aTelefone;
  xUsuario.Email     := aEmail;
  xUsuario.CPF       := aCPF;
  xUsuario.Bloqueado := false;
  // LimparLivroEmprestado(xUsuario.LivrosEmprestados);
  Result              := xUsuario;
end;

{ Function para gerar n�meros aleat�rios para preencher Telefone e CPF de usu�rios }
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

function MostrarBloqueio(aBloqueio: Boolean): String;
begin
  if aBloqueio then
    Result := 'bloqueado. Deseja desbloque�-lo?'
  else
    Result := 'desbloqueado. Deseja bloque�-lo?';
end;

{ Procedure para popular a Array de usu�rios automaticamente para n�o termos que
  preenche-la toda hora }
function UsuariosCadastradosIniciais: TUsuariosCadastrados;
const
  NOME_EMAIL: array [0 .. 14, 0 .. 1] of String = (('Emilia Azevedo Silva',
    'emiliasilva72@hmail.com'), ('Kau� Goncalves Pinto',
    'kaue.pinto20@gotmail.com'), ('Samuel Cavalcanti Barbosa',
    'samuelzim99@gotmail.com'), ('Isabela Dias Carvalho',
    'isah_gatinha2002@hmail.com'), ('Brenda Castro Ribeiro',
    'brendacribeiro32@hmail.com'), ('Vin�cius Ferreira Costa',
    'macinhademodela@gotmail.com'), ('Elizeu Drummond',
    'drummondaum@ig.com.br'), ('Carolina Cardoso', 'carol_4356@yahoo.com.br'),
    ('Laura Martins Araujo', 'lmaraujo@hmail.com'),
    ('Leticia Correa', 'correaleticia23@jmail.com'),
    ('Jo�o Carlos de Souza', 'joaum_do_feijaum@ig.com.br'),
    ('Lucas Azevedo', 'seu_luquinhas@hmail.com'),
    ('Estevan Castro', 'estevan_castro9543@gotmail.com'),
    ('Vit�ria Pinto Dias', 'vividias@gotmail.com'),
    ('Julio Fernandes', 'juju_fefe@ig.com.br'));
var
  I: Integer;
  xUsuarios: TUsuariosCadastrados;
begin
  setLength(xUsuarios, 15);
  for I := 0 to 14 do
  begin
    xUsuarios[I] := PreencherUsuario(NOME_EMAIL[I][0], NOME_EMAIL[I][1],
      NumeroAleatorio, NumeroAleatorio, (I + 1));
  end;

  Result := xUsuarios;
end;

{ Function para retornar o telefone de TUsuario na formata��o (##) #####-####
  e muda o terceiro algarismo para 9 para simular um n�mero de telefone real
  caso possua 11 caracteres, sen�o retorna a string original }
function FormatarTelefone(aTel: String): String;
begin
  if aTel.Length = 11 then
  begin
    aTel[3] := '9';
    Result := Format('(%2.2s) %5.5s-%4.4s', [Copy(aTel, 1, 2), Copy(aTel, 3, 5),
      Copy(aTel, 8, 4)]);
  end
  else
    Result := aTel;
end;

{ Function para retornar o telefone de TUsuario na formata��o ###.###.###-##
  caso possua 11 caracteres, sen�o retorna a string original }
function FormatarCPF(aCPF: String): String;
begin
  if aCPF.Length = 11 then
    Result := Format('%3.3s.%3.3s.%3.3s-%2.2s',
      [Copy(aCPF, 1, 3), Copy(aCPF, 4, 3), Copy(aCPF, 7, 3), Copy(aCPF, 10, 2)])
  else
    Result := aCPF;
end;

{ Procedure para escrever as informa��es de um usu�rio na tela }
procedure MostrarUsuario(aUsuario: TUsuario);
begin
  writeln('C�digo  : ' + aUsuario.Cod.ToString);
  writeln('Nome    : ' + aUsuario.Nome);
  writeln('Telefone: ' + FormatarTelefone(aUsuario.Telefone));
  writeln('CPF     : ' + FormatarCPF(aUsuario.CPF));
  writeln('Email   : ' + aUsuario.Email);
  // MostrarLivroEmprestado(aUsuario.LivrosEmprestados);
  writeln;
  writeln('Livros emprestados');
  MostrarHistorico(aUsuario.LivrosEmprestados);
  writeln;
  writeln('Hist�rico de empr�stimos');
  MostrarHistorico(aUsuario.Historico);
  writeln;
  if aUsuario.Bloqueado then
    writeln('USU�RIO BLOQUEADO');
end;

{ Procedure para escrever as informa��es de todos os usu�rios cadastrados na tela }
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

procedure BloquearOuDesbloquearUsuario(var aUsuario: TUsuario);
begin
  aUsuario.Bloqueado := not aUsuario.Bloqueado;
end;
{ Procedure para que o usu�rio do sistema cadastre um novo usu�rio da biblioteca }
procedure IncluirNovoUsuario(var aCadastrados: TUsuariosCadastrados);
var
  xNome, xTelefone, xEmail, xCPF: String;
begin
  writeln;
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
  writeln('Usu�rio ' + aCadastrados[Length(aCadastrados) - 1].Nome +
    ' cadastrado com sucesso.');
  writeln;
end;

function BuscarUsuarioPorNome(var aUsuario: TUsuario; const aNome: string;
  aUsuarios: TUsuariosCadastrados): boolean;
var
  I: Integer;
begin
  result := false;
  for i := 0 to pred(length(aUsuarios)) do
    if (uppercase(aUsuarios[I].Nome) = uppercase(aNome)) then
    begin
      result:= true;
      aUsuario := aUsuarios[I];
      exit;
    end;
end;

procedure EscreverResultadoPorNomeUsuario(const aUsuarios: TUsuariosCadastrados);
var
  xNome: String;
  xUsuario: TUsuario;
  xNovamente: char;
begin
  Repeat
    Writeln('Escreva o nome do livro desejado');
    readln(xNome);
    if not BuscarUsuarioPorNome(xUsuario, xNome, aUsuarios) then
      writeln('N�o existe nenhum usuario com o nome ' + xNome)
    else
      MostrarUsuario(xUsuario);
    write('Deseja efetuar uma nova busca? (S/N)');
    xNovamente := RetornarChar;
  Until UpCase(xNovamente) <> 'S';
end;

function BuscarUsuarioPorCod(var aIndice: Integer;
  const aUsuarios: TUsuariosCadastrados; const aCod: Integer): Boolean;
var
  I: Integer;
begin
  for I := 0 to pred(Length(aUsuarios)) do
  begin
    if aCod = aUsuarios[I].Cod then
    begin
      aIndice := I;
      Result := true;
      Exit;
    end;
  end;
  Result := false;
end;

function IdentificarUsuarioPorCod(aUsuarios: TUsuariosCadastrados): Integer;
var
  xIndice, xCod: Integer;
  xConfirma: char;
begin
  Repeat
    write('Insira o c�digo do Usu�rio: ');
    xCod := RetornarInteger;
    while not BuscarUsuarioPorCod(xIndice, aUsuarios, xCod) do
    begin
      writeln('Usu�rio de c�digo ' + xCod.ToString + ' n�o localizado. Insira um ' +
      'n�mero correto.');
      write('C�digo: ');
      xCod := RetornarInteger;
    end;
    MostrarUsuario(aUsuarios[xIndice]);
    writeln('Deseja selecionar o usu�rio ' + aUsuarios[xIndice].Nome +'? (S/N)');
    xConfirma := RetornarChar;
  until UpCase(xConfirma) = 'S';
  Result := xIndice;
end;

procedure ConfirmarBloqueioDesbloqueio(var aUsuario: TUsuario);
var
  xConfirmar: char;
begin
  write('O usu�rio ' + aUsuario.nome + ' est� '
    + MostrarBloqueio(aUsuario.Bloqueado) + ' (S/N)');
  xConfirmar := RetornarChar;
  if UpCase(xConfirmar)  = 'S' then
  begin
    BloquearOuDesbloquearUsuario(aUsuario);
    MostrarUsuario(aUsuario);
  end
  else
    writeln('Opera��o cancelada.');

end;

procedure EfetuarBloqueioDesbloqueio(var aUsuarios: TUsuariosCadastrados);
var
  xId: Integer;
begin
  xId := IdentificarUsuarioPorCod(aUsuarios);
  ConfirmarBloqueioDesbloqueio(aUsuarios[xId]);
end;

procedure TelaPagarMulta(var aUsuario: TUsuario);
var
  xConfirma: char;
begin
  writeln('Total de multa de livros devolvidos ou com prazo renovado: ' +
    formatarMulta(CalcularMultasFechadas(aUsuario.LivrosEmprestados) +
    CalcularMultasFechadas(aUsuario.Historico)));
  writeln('Efetuar pagamento do d�bito de ' + aUsuario.nome + '? (S/N)');
  xConfirma := RetornarChar;
  if UpCase(xConfirma) = 'S' then
  begin
    ZerarMultas(aUsuario.Historico, aUsuario.LivrosEmprestados);
    writeln('As multas de ' + aUsuario.nome + ' foram pagas.');

    if CalcularMultasAbertas(aUsuario.LivrosEmprestados) > 0 then
    begin
      writeln('Aviso: Ainda existem d�bitos de livros n�o devolvidos ou ' +
      'renovados. Valor atual: ' +
      formatarMulta(calcularMultasAbertas(aUsuario.LivrosEmprestados)));
    end;

    if aUsuario.Bloqueado = true then
      ConfirmarBloqueioDesbloqueio(aUsuario);
  end;


end;
end.
