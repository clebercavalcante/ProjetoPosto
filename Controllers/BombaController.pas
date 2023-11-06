unit BombaController;

interface

uses
  Data.SqlExpr, SysUtils, Forms, Windows, uConexao, BombaDAO, Bomba;

type
  TBombaController = class
  private
    { private declarations }
  public
    function ObterListaBombas(Descricao: String = ''):TSQLQuery;
    function ObterBombaPorId(Id :Integer):TBomba;
    function UltimaBomba:TBomba;
  end;

implementation

{ TBombaController }
function TBombaController.ObterBombaPorId(Id :Integer): TBomba;
var
  BombaDAO: TBombaDAO;
begin
  try
    BombaDAO := TBombaDAO.Create;
    Result := BombaDAO.ObterBombaPorId(Id);
    FreeAndNil(BombaDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TBombaController.ObterListaBombas(Descricao: String = ''): TSQLQuery;
var
  BombaDAO: TBombaDAO;
begin
  try
    BombaDAO := TBombaDAO.Create;
    Result := BombaDAO.ObterListaBombas(Descricao);
    FreeAndNil(BombaDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TBombaController.UltimaBomba: TBomba;
var
  BombaDAO: TBombaDAO;
begin
  try
    BombaDAO := TBombaDAO.Create;
    Result := BombaDAO.UltimaBomba();
    FreeAndNil(BombaDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
