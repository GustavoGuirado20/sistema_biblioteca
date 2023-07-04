unit UController;


interface

uses
  UUsuario, ULivroEmprestado, ULivro, UOperacoes;

  procedure ControllerPrincipal;
implementation

uses
  SysUtils;

{procedure ControllerUsuario(var aBiblioteca: TBiblioteca; var aUsuario: TUsuario);
begin

end;


function MenuPrincipal: byte;
var
  xOPC: byte;
begin
  writeln('Menu principal');
  writeln('Selecione uma opção abaixo:');
  writeln('1 - Usuários');
  writeln('2 - Acervo');
  writeln('0 - Sair');
  readln(xOpc);
  Result := xOPC;
  writeln;
end;

procedure ControllerPrincipal;
var
  opc: byte;
  xBiblioteca: TBiblioteca;
  xUsuarios: TUsuariosCadastrados;
begin
  xBiblioteca := BibliotecaInicial;
  xUsuarios := UsuariosCadastradosIniciais;
  writeln('Bem vindo ao sistema de biblioteca. ');
  opc := MenuPrincipal;
  while opc <> 0 do
  begin
    case opc of
      1:
      begin
      //  ControllerUsuario;
      end;
    end;
  end;
end;
}

function MenuPrincipal:byte;
var
  opc:byte;
begin
  Writeln('1 - Livro');
  Writeln('2 - Cliente');
  Writeln('0 - Sair');

  readln(opc);
  result := opc;
end;


function MenuLivro:byte;
var
  opc:byte;
begin
  Writeln('1 - Cadastrar Livro');
  Writeln('2 - Pesquisar Livro');
  Writeln('3 - Mostrar Catálogo');
  Writeln('4 - Quantidade de Livros Emprestados x Disponíveis');
  Writeln('5 - Porcentagem de Livros Emprestados x Disponíveis');
  Writeln('6 - Mostrar Livros Disponíveis ou Emprestados');
  Writeln('7 - Buscar Por Código');
  Writeln('0 - Sair');

  readln(opc);
  result := opc;
end;

function MenuCliente:byte;
var
  opc:byte;
begin
  Writeln('1 - Cadastrar Usuário');
  Writeln('2 - Pesquisar Usuário');
  Writeln('3 - Mostrar Todos os Usuários');
  Writeln('4 - Bloquear Usuário');
  Writeln('0 - Sair');

  readln(opc);
  result := opc;
end;

procedure ControllerLivro(var aBiblioteca: TBiblioteca);
var
  xOpc: Byte;
begin
  xOpc := MenuLivro;
  while (xOpc <> 0) do
  begin
    case xOpc of
      1: Incluirnovolivro(aBiblioteca);
      2: EscreverResultadoPesquisaPorNome(aBiblioteca);
      3: MostrarCatalogo(aBiblioteca);
      4: EscreverRelacaoLivrosDispEmp
      5: Writeln((CalcularQuantidades(xBiblioteca,falso) * 100 / pred(length(xBiblioteca))).ToString	 + ' dos estão disponíveis e ' + (falso * 100 / pred(length(xBiblioteca))).ToString	 + ' estão emprestados');

        6:begin
            Writeln('Digite 1 para livros emprestados e 2 para livors diponíveis');
            readln(respostas);
            if falso = 1 then
              Writeln('A biblioteca possui ' + (falso * 100 / pred(length(xBiblioteca))).ToString + '% de Livros emprestados')
            else
              Writeln('A biblioteca possui ' + (CalcularQuantidades(xBiblioteca,falso) * 100 / pred(length(xBiblioteca))).ToString	 + '% de Livros disponíveis');
          end;

        7:begin
            BuscarLivroPorCod(falso,xLivro,xBiblioteca,respostas);
            MostrarLivro(xlivro);
           end;
        end;
  end;


end;

procedure ControllerPrincipal;
var
  xOpc: Byte;
  xBiblioteca: TBiblioteca;
  xUsuarios: TUsuariosCadastrados;
  xLivro: TLivro;
  xLivroEmprestado: TLivroEmprestado;
  xNome: String;
  xResultado: Boolean;
  xFalso,xRespostas: Integer;
begin
  xBiblioteca := BibliotecaInicial;
  xUsuarios := UsuariosCadastradosIniciais;
  xOpc := MenuPrincipal;
  while (xOpc <> 0) do
  begin
    case xOpc of
    1:
     begin

    end;
  end;
 end;
end;
END.
