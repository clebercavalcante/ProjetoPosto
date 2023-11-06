unit BombaDAO;

interface

uses
  Data.SqlExpr, SysUtils, Forms, Windows, uConexao, Bomba, TanqueController;

type
  TBombaDAO = class
  private
    { private declarations }
  public
    function ObterListaBombas(Descricao: String = ''):TSQLQuery;
    function ObterBombaPorId(Id :Integer):TBomba;
    function UltimaBomba:TBomba;
  end;

implementation

{ TBombaDAO }

function TBombaDAO.ObterBombaPorId(Id: Integer): TBomba;
var
  Query: TSQLQuery;
  TanqueController :TTanqueController;
  Bomba: TBomba;
begin
  try
    TConexao.CriarQuery(Query);

    Query.SQL.Add('SELECT b.Id');
    Query.SQL.Add('      ,b.Descricao');
    Query.SQL.Add('      ,b.TanqueId');
    Query.SQL.Add('  FROM Bomba b');
    Query.SQL.Add(' WHERE b.Id = :Id');

    Query.ParamByName('Id').AsInteger := Id;

    Query.Open();

    if not(Query.IsEmpty) then
    begin
      TanqueController := TTanqueController.Create;

      Bomba := TBomba.Create;
      Bomba.Id := Query.FieldByName('Id').AsInteger;
      Bomba.Descricao := Trim(Query.FieldByName('Descricao').AsString);
      Bomba.Tanque := TanqueController.ObterTanquePorId(Query.FieldByName('TanqueId').AsInteger);

      FreeAndNil(TanqueController);
      Result := Bomba;
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

function TBombaDAO.ObterListaBombas(Descricao: String = ''): TSQLQuery;
var
  Query: TSQLQuery;
begin
  try
    TConexao.CriarQuery(Query);

    Query.SQL.Add('SELECT b.Id');
    Query.SQL.Add('      ,b.Descricao');
    Query.SQL.Add('      ,t.Tipo');
    Query.SQL.Add('  FROM Bomba b');
    Query.SQL.Add(' INNER JOIN Tanque t');
    Query.SQL.Add('    ON b.TanqueId = t.Id');

    if (Trim(Descricao) <> '') then
    begin
      Query.SQL.Add(' WHERE b.Descricao LIKE ''%'+Trim(Descricao)+'%''');
    end;

    Query.SQL.Add(' ORDER BY b.Id');

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

function TBombaDAO.UltimaBomba: TBomba;
var
  Query: TSQLQuery;
  TanqueController :TTanqueController;
  Bomba: TBomba;
begin
  try
    TConexao.CriarQuery(Query);

    Query.SQL.Add('SELECT b.Id');
    Query.SQL.Add('      ,b.Descricao');
    Query.SQL.Add('      ,b.TanqueId');
    Query.SQL.Add('  FROM Bomba b');
    Query.SQL.Add(' WHERE b.Id = (SELECT MAX(Id)');
    Query.SQL.Add('                 FROM Bomba)');

    Query.Open();

    if not(Query.IsEmpty) then
    begin
      TanqueController := TTanqueController.Create;

      Bomba := TBomba.Create;
      Bomba.Id := Query.FieldByName('Id').AsInteger;
      Bomba.Descricao := Trim(Query.FieldByName('Descricao').AsString);
      Bomba.Tanque := TanqueController.ObterTanquePorId(Query.FieldByName('TanqueId').AsInteger);

      FreeAndNil(TanqueController);
      Result := Bomba;
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
