unit AbastecimentoController;

interface

uses
  Data.SqlExpr, SysUtils, Forms, Windows, uConexao, AbastecimentoDAO, Abastecimento;
type
  TAbastecimentoController = class
  private
    { private declarations }
  public
    procedure Salvar(Abastecimento: TAbastecimento);
  end;
implementation
{ AbastecimentoController }
procedure TAbastecimentoController.Salvar(Abastecimento: TAbastecimento);
var
  AbastecimentoDAO: TAbastecimentoDAO;
begin
  try
    AbastecimentoDAO := TAbastecimentoDAO.Create;
    AbastecimentoDAO.Salvar(Abastecimento);
    FreeAndNil(AbastecimentoDAO);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;
end.
