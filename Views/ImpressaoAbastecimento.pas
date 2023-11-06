unit ImpressaoAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.SqlExpr, RLReport, Data.FMTBcd,
  Data.DBXFirebird, Data.DB;

type
  TFormImpressaoAbastecimento = class(TForm)
    RLReportAbastecimentoBombas: TRLReport;
    RLBandTitle: TRLBand;
    RLDrawTitle: TRLDraw;
    RLLabelPostoABC: TRLLabel;
    RLSystemInfoData: TRLSystemInfo;
    RLLabelData: TRLLabel;
    RLSystemInfoPagina: TRLSystemInfo;
    RLLabelPagina: TRLLabel;
    RLGroup: TRLGroup;
    RLBandDetail: TRLBand;
    RLBandHeader: TRLBand;
    RLLabelTanqueGrupo: TRLLabel;
    RLDrawGrupo: TRLDraw;
    RLLabelGrupo: TRLLabel;
    RLDrawColunaData: TRLDraw;
    RLLabelColunaData: TRLLabel;
    RLDrawColunaBomba: TRLDraw;
    RLLabelColunaBomba: TRLLabel;
    RLDrawColunaValor: TRLDraw;
    RLLabelColunaValor: TRLLabel;
    RLLabelBomba: TRLLabel;
    RLDrawBomba: TRLDraw;
    RLDrawDataAbastecimento: TRLDraw;
    RLLabelDataAbastecimento: TRLLabel;
    RLDrawValor: TRLDraw;
    RLLabelValor: TRLLabel;
    RLBandSummary02: TRLBand;
    RLDrawValorTotalCaption: TRLDraw;
    RLDrawValorTotal: TRLDraw;
    RLLabelValorTotalCaption: TRLLabel;
    RLLabelValorTotal: TRLLabel;
    RLLabelImpressaoAbastecimentos: TRLLabel;
    RLBandSummary01: TRLBand;
    RLDrawValorTotalTanqueCaption: TRLDraw;
    RLDrawValorTotalTanque: TRLDraw;
    RLLabelValorTotalTanqueCaption: TRLLabel;
    RLLabelValorTotalTanque: TRLLabel;
    procedure RLBandHeaderBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBandDetailBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBandSummary01BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure RLBandSummary02BeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    ValorTotal: Currency;
    ValorTotalTanque: Currency;

    FQuery: TSQLQuery;
    procedure SetQuery(const Value: TSQLQuery);
  public
    property Query :TSQLQuery read FQuery write SetQuery;
  end;

var
  FormImpressaoAbastecimento: TFormImpressaoAbastecimento;

implementation

{$R *.dfm}

{ TFormImpressaoAbastecimento }

procedure TFormImpressaoAbastecimento.RLBandDetailBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  RLLabelBomba.Caption := Trim(Query.FieldByName('Bomba').AsString);
  RLLabelDataAbastecimento.Caption := FormatDateTime('dd/mm/yyyy',Query.FieldByName('DataAbastecimento').AsDateTime);
  RLLabelValor.Caption := 'R$ ' + FormatFloat('#,##0.00',Query.FieldByName('ValorTotal').AsCurrency);
  ValorTotal := ValorTotal + Query.FieldByName('ValorTotal').AsCurrency;
  ValorTotalTanque := ValorTotalTanque + Query.FieldByName('ValorTotal').AsCurrency;
end;

procedure TFormImpressaoAbastecimento.RLBandHeaderBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  RLLabelGrupo.Caption := Trim(Query.FieldByName('Tanque').AsString);
end;

procedure TFormImpressaoAbastecimento.RLBandSummary01BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  RLLabelValorTotalTanque.Caption := 'R$ ' + FormatFloat('#,##0.00',ValorTotalTanque);
  ValorTotalTanque := 0;
end;

procedure TFormImpressaoAbastecimento.RLBandSummary02BeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  RLLabelValorTotal.Caption := 'R$ ' + FormatFloat('#,##0.00',ValorTotal);
  ValorTotal := 0;
end;

procedure TFormImpressaoAbastecimento.SetQuery(const Value: TSQLQuery);
begin
  FQuery := Value;
end;

end.
