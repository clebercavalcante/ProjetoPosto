unit TanqueDAO;

interface

uses
  Data.SqlExpr, SysUtils, Forms, Windows, uConexao, Tanque;

type
  TTanqueDAO = class
  private
    { private declarations }
  public
    function ObterListaTanques(Descricao: String = ''):TSQLQuery;
    function ObterTanquePorId(Id :Integer):TTanque;
    function UltimoTanque:TTanque;
  end;

implementation

{ TTanqueDAO }

function TTanqueDAO.ObterListaTanques(Descricao: String = ''): TSQLQuery;
var
  Query: TSQLQuery;
begin
  try
    TConexao.CriarQuery(Query);

    Query.SQL.Add('SELECT t.Id');
    Query.SQL.Add('      ,t.Descricao');
    Query.SQL.Add('      ,t.Tipo');
    Query.SQL.Add('  FROM Tanque t');

    if (Trim(Descricao) <> '') then
    begin
      Query.SQL.Add(' WHERE t.Descricao LIKE ''%'+Trim(Descricao)+'%''');
    end;

    Query.SQL.Add(' ORDER BY t.Id');

    Query.Open();

    if not(Query.IsEmpty) then
    begin
      Result := Query;
    end
    else
    begin
      Result := nil;
      TConexao.DestruirQuery(Query);
    end;
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TTanqueDAO.ObterTanquePorId(Id: Integer): TTanque;
var
  Query: TSQLQuery;
  Tanque: TTanque;
begin
  try
    TConexao.CriarQuery(Query);

    Query.SQL.Add('SELECT t.Id');
    Query.SQL.Add('      ,t.Descricao');
    Query.SQL.Add('      ,t.Tipo');
    Query.SQL.Add('  FROM Tanque t');
    Query.SQL.Add(' WHERE t.Id = :Id');

    Query.ParamByName('Id').AsInteger := Id;

    Query.Open();

    if not(Query.IsEmpty) then
    begin
      Tanque := TTanque.Create;
      Tanque.Id := Query.FieldByName('Id').AsInteger;
      Tanque.Descricao := Trim(Query.FieldByName('Descricao').AsString);

      case (Query.FieldByName('Tipo').AsInteger) of
        0 : Tanque.Tipo := Gasolina;
        1 : Tanque.Tipo := OleoDiesel;
      end;

      Result := Tanque;
    end
    else
    begin
      Result := nil;
    end;

    TConexao.DestruirQuery(Query);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TTanqueDAO.UltimoTanque: TTanque;
var
  Query: TSQLQuery;
  Tanque: TTanque;
begin
  try
    TConexao.CriarQuery(Query);

    Query.SQL.Add('SELECT t.Id');
    Query.SQL.Add('      ,t.Descricao');
    Query.SQL.Add('      ,t.Tipo');
    Query.SQL.Add('  FROM Tanque t');
    Query.SQL.Add(' WHERE t.Id = (SELECT MAX(Id)');
    Query.SQL.Add('                 FROM Tanque)');

    Query.Open();

    if not(Query.IsEmpty) then
    begin
      Tanque := TTanque.Create;
      Tanque.Id := Query.FieldByName('Id').AsInteger;
      Tanque.Descricao := Trim(Query.FieldByName('Descricao').AsString);

      case (Query.FieldByName('Tipo').AsInteger) of
        0 : Tanque.Tipo := Gasolina;
        1 : Tanque.Tipo := OleoDiesel;
      end;

      Result := Tanque;
    end
    else
    begin
      Result := nil;
    end;

    TConexao.DestruirQuery(Query);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.

