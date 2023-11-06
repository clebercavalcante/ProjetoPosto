unit AbastecimentoDAO;

interface

uses
  Data.SqlExpr, SysUtils, Forms, Windows, uConexao, Abastecimento;

type
  TAbastecimentoDAO = class
  private
    { private declarations }
  public
    procedure Salvar(Abastecimento: TAbastecimento);
  end;

implementation

{ TAbastecimentoDAO }

procedure TAbastecimentoDAO.Salvar(Abastecimento: TAbastecimento);
var
  Query: TSQLQuery;
begin
  try
    TConexao.CriarQuery(Query);

    Query.SQL.Add('INSERT INTO Abastecimento');
    Query.SQL.Add('           (Data');
    Query.SQL.Add('           ,BombaId');
    Query.SQL.Add('           ,qtdLitros');
    Query.SQL.Add('           ,ValorTotal');
    Query.SQL.Add('           ,valorImposto)');
    Query.SQL.Add('     VALUES(:Data');
    Query.SQL.Add('           ,:BombaId');
    Query.SQL.Add('           ,:qtdLitros');
    Query.SQL.Add('           ,:ValorTotal');
    Query.SQL.Add('           ,:valorImposto)');

    Query.ParamByName('Data').AsDateTime := Abastecimento.Data;
    Query.ParamByName('BombaId').AsInteger := Abastecimento.Bomba.Id;
    Query.ParamByName('qtdLitros').AsCurrency := Abastecimento.Litros;
    Query.ParamByName('ValorTotal').AsCurrency := Abastecimento.Valor;
    Query.ParamByName('valorImposto').AsCurrency := Abastecimento.Imposto;

    Query.ExecSQL();

    TConexao.DestruirQuery(Query);
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.

