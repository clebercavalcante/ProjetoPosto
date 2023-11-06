unit uConexao;

interface

uses
  Data.SqlExpr, SysUtils, Forms, Windows, IniFiles;

type

  TConexao = class
  private
    class function VerificarBanco(Caminho: String): Boolean;
    class function VerificarConf(): Boolean;
    class function LerConf(Chave: String):String;
    class procedure GravarConf(Chave, Valor: string);
  public
    class procedure ConectarBanco(var Conexao: TSQLConnection);
    class procedure Mensagem(Texto: String);
    class procedure CriarQuery(var Query: TSQLQuery);
    class procedure DestruirQuery(var Query: TSQLQuery);
    class function Confirmacao(Texto: String):Boolean;
    class function StringEmCurrency(Texto: String):Currency;
  end;

implementation

{ TConexao }

uses Principal;

class procedure TConexao.ConectarBanco(var Conexao: TSQLConnection);
Var
  CaminhoBaseDados: string;
begin
  try
    if not(VerificarConf()) then
    begin
      GravarConf('CaminhoBanco','');
      GravarConf('Usuario','');
      GravarConf('Senha','');
      raise Exception.Create('O arquivo de configuração não foi encontrado, o sistema criara um novo arquivo, por favor configure com as informações necessárias.');
    end;
    CaminhoBaseDados :=  LerConf('CaminhoBanco');
    if CaminhoBaseDados <> '' then
    begin
      if not VerificarBanco(CaminhoBaseDados) then
        raise Exception.Create('O arquivo do banco de dados deve estar junto do executável do sistema.');
    end;
    Conexao.Params.Values['Database'] := CaminhoBaseDados;
    Conexao.Params.Values['User_Name'] := LerConf('Usuario');
    Conexao.Params.Values['Password'] := LerConf('Senha');
    Conexao.Connected := True;
  except on E: Exception do
    raise Exception.Create('Não foi possível estabelecer a conexão com o banco de dados.'+#13+
                           'Verifique as configurações do arquivo de Conf que se encontra junto do executável.');
  end;
end;

class function TConexao.Confirmacao(Texto: String): Boolean;
begin
  try
    Result := Application.MessageBox(PWideChar(Texto),'Posto ABC', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class procedure TConexao.CriarQuery(var Query: TSQLQuery);
begin
  try
    Query := TSQLQuery.Create(FrmPrincipal);
    Query.SQLConnection := FrmPrincipal.Conexao;
    Query.Close;
    Query.SQL.Clear;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class procedure TConexao.DestruirQuery(var Query: TSQLQuery);
begin
  try
    Query.Close;
    Query.Free;
    Query := nil;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class procedure TConexao.GravarConf(Chave, Valor: string);
var
  arquivo: TIniFile;
begin
  try
    arquivo := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\Conf.ini');
    arquivo.WriteString('Configuracoes', chave, valor);
    arquivo.Free;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class function TConexao.LerConf(Chave: String): String;
var
  arquivo: TIniFile;
begin
  try
    arquivo := TIniFile.Create(ExtractFileDir(Application.ExeName) + '\Conf.ini');
    Result := arquivo.ReadString('Configuracoes', chave, '');
    arquivo.Free;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class procedure TConexao.Mensagem(Texto: String);
begin
  try
    Application.MessageBox(PWideChar(Texto),'Posto ABC',MB_OK + MB_ICONINFORMATION);
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class function TConexao.StringEmCurrency(Texto: String): Currency;
begin
  try
    Texto := StringReplace(Trim(Texto),'.','',[rfReplaceAll, rfIgnoreCase]);
    Result := StrToCurr(Texto);
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

class function TConexao.VerificarBanco(Caminho: String): Boolean;
begin
  try
    Result := FileExists(Caminho);
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;


class function TConexao.VerificarConf: Boolean;
begin
  try
    Result := (FileExists(ExtractFileDir(Application.ExeName) + '\Conf.ini'));
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;
end.
