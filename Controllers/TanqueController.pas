unit TanqueController;

interface

uses
  Data.SqlExpr, SysUtils, Forms, Windows, uConexao, TanqueDAO, Tanque;

type
  TTanqueController = class
  private
    { private declarations }
  public
    function ObterListaTanques(Descricao: String = ''):TSQLQuery;
    function ObterTanquePorId(Id :Integer):TTanque;
    function UltimoTanque:TTanque;
  end;

implementation

{ TTanqueController }


function TTanqueController.ObterListaTanques(Descricao: String = ''): TSQLQuery;
var
  TanqueDAO: TTanqueDAO;
begin
  try
    TanqueDAO := TTanqueDAO.Create;
    Result := TanqueDAO.ObterListaTanques(Descricao);
    FreeAndNil(TanqueDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TTanqueController.ObterTanquePorId(Id :Integer): TTanque;
var
  TanqueDAO: TTanqueDAO;
begin
  try
    TanqueDAO := TTanqueDAO.Create;
    Result := TanqueDAO.ObterTanquePorId(Id);
    FreeAndNil(TanqueDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TTanqueController.UltimoTanque: TTanque;
var
  TanqueDAO: TTanqueDAO;
begin
  try
    TanqueDAO := TTanqueDAO.Create;
    Result := TanqueDAO.UltimoTanque();
    FreeAndNil(TanqueDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
