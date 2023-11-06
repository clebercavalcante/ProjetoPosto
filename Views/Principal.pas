unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DBXFirebird, Data.DB, Data.SqlExpr, Vcl.ExtCtrls;

type
  TFrmPrincipal = class(TForm)
    PageControl1: TPageControl;
    tsMov: TTabSheet;
    tsConfig: TTabSheet;
    Conexao: TSQLConnection;
    LabelValorLitroGasolina: TLabel;
    EditValorLitroGasolina: TEdit;
    LabelValorLitroOleoDiesel: TLabel;
    EditValorLitroOleoDiesel: TEdit;
    LabelValorImpostoAbastecimento: TLabel;
    EditValorIimpostoAbastecimento: TEdit;
    lbBomba: TLabel;
    cbBomba: TComboBox;
    lbLitros: TLabel;
    edtLitros: TEdit;
    lbValorTotal: TLabel;
    edtValorTotal: TEdit;
    lbValorImposto: TLabel;
    edtValorImposto: TEdit;
    BitBtnIniciarAbastecimento: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    BitBtn1: TBitBtn;
    tsRel: TTabSheet;
    LabelDataInicial: TLabel;
    LabelDataFinal: TLabel;
    DateTimePickerDataInicial: TDateTimePicker;
    DateTimePickerDataFinal: TDateTimePicker;
    Bevel3: TBevel;
    BitBtn2: TBitBtn;
    StatusBar: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtLitrosChange(Sender: TObject);
    procedure cbBombaChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure EditValorLitroGasolinaChange(Sender: TObject);
    procedure EditValorLitroOleoDieselChange(Sender: TObject);
    procedure EditValorLitroOleoDieselKeyPress(Sender: TObject; var Key: Char);
    procedure EditValorLitroGasolinaKeyPress(Sender: TObject; var Key: Char);
    procedure EditValorIimpostoAbastecimentoKeyPress(Sender: TObject;
      var Key: Char);
    procedure EditValorIimpostoAbastecimentoChange(Sender: TObject);
    procedure edtValorTotalChange(Sender: TObject);
    procedure BitBtnIniciarAbastecimentoClick(Sender: TObject);
    procedure edtLitrosKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorTotalKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorImpostoKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
  private
    FBombaId: Integer;
    FValorLitro: Double;
    FPerImposto: Double;
    procedure SetBombaId(const Value: Integer);

    procedure CarregarConfiguracao;
    procedure ObterDadosBomba;

    procedure CarregarInformacoesBomba;
    procedure Abastecer;
    function ValidarAbastecimento:Boolean;
    procedure SetValorLitro(const Value: Double);
    function ValidarGravacao: Boolean;
    procedure SalvarConfiguracao;
    procedure LimparCampos;
    procedure AtivarCampos;
    procedure setPerImposto(const Value: Double);
    function ValidaImpressao: Boolean;
  public
    property BombaId: Integer read FBombaId write SetBombaId;
    property ValorLitro: Double read FValorLitro write SetValorLitro;
    property PerImposto: Double read FPerImposto write setPerImposto;

  end;

var
  FrmPrincipal: TFrmPrincipal;


implementation

uses uConexao, ConfigController, Configuracao, BombaController, Bomba, Tanque, Abastecimento, AbastecimentoController, ImpressaoAbastecimento;


{$R *.dfm}

procedure TFrmPrincipal.CarregarInformacoesBomba;
var
  BombaController: TBombaController;
  Bomba :TBomba;
  ConfigController :TConfigController;
  Configuracao :TConfiguracao;
begin
  try
    BombaController := TBombaController.Create;
    Bomba := BombaController.ObterBombaPorId(BombaId);
    FreeAndNil(BombaController);
    ConfigController := TConfigController.Create;
    Configuracao := ConfigController.ObterConfiguracao();
    FreeAndNil(ConfigController);
    setPerImposto(Configuracao.ValorImposto);
    case (Bomba.Tanque.Tipo) of
      Gasolina : begin
                   SetValorLitro(Configuracao.ValorLitroGasolina);
                 end;
      OleoDiesel : begin
                     SetValorLitro(Configuracao.ValorLitroOleoDiesel);
                   end;
    end;
    FreeAndNil(Bomba);
    FreeAndNil(Configuracao);
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.cbBombaChange(Sender: TObject);
begin
  SetBombaId(cbBomba.ItemIndex + 1);

  CarregarInformacoesBomba;

  AtivarCampos;
end;

procedure TFrmPrincipal.EditValorIimpostoAbastecimentoChange(Sender: TObject);
begin
  try
    if (Trim(EditValorIimpostoAbastecimento.Text) = '') then
    begin
      EditValorIimpostoAbastecimento.Text := '0,00';
      Exit
    end;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.EditValorIimpostoAbastecimentoKeyPress(Sender: TObject;
  var Key: Char);
begin
  try
    if not(Key in ['0'..'9',Char(8),Char(44)]) then
    begin
      Key := #0;
    end;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.EditValorLitroGasolinaChange(Sender: TObject);
begin
  try
    if (Trim(EditValorLitroGasolina.Text) = '') then
    begin
      EditValorLitroGasolina.Text := '0,00';
      Exit
    end;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.EditValorLitroGasolinaKeyPress(Sender: TObject;
  var Key: Char);
begin
  try
    if not(Key in ['0'..'9',Char(8),Char(44)]) then
    begin
      Key := #0;
    end;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.EditValorLitroOleoDieselChange(Sender: TObject);
begin
  try
    if (Trim(EditValorLitroOleoDiesel.Text) = '') then
    begin
      EditValorLitroOleoDiesel.Text := '0,00';
      Exit
    end;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.EditValorLitroOleoDieselKeyPress(Sender: TObject;
  var Key: Char);
begin
  try
    if not(Key in ['0'..'9',Char(8),Char(44)]) then
    begin
      Key := #0;
    end;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.edtLitrosChange(Sender: TObject);
begin
  try
    if (Trim(edtLitros.Text) = '') then
    begin
      edtLitros.Text := '0,00';
      edtValorTotal.Text := '0,00';
      Exit;
    end;
    edtValorTotal.Text := FormatFloat('#,##0.00', TConexao.StringEmCurrency(edtLitros.Text) * ValorLitro);
    edtValorImposto.Text := FormatFloat('#,##0.00', (TConexao.StringEmCurrency(edtValorTotal.Text) * (PerImposto / 100)));
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.edtLitrosKeyPress(Sender: TObject; var Key: Char);
begin
  try
    if not(Key in ['0'..'9',Char(8),Char(13)]) then
    begin
      Key := #0;
    end;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.edtValorImpostoKeyPress(Sender: TObject; var Key: Char);
begin
  try
    if not(Key in ['0'..'9',Char(8),Char(44)]) then
    begin
      Key := #0;
    end;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.edtValorTotalChange(Sender: TObject);
begin
  try
    if not(edtValorTotal.Enabled) then
    begin
      Exit;
    end;
    if (Trim(edtValorTotal.Text) = '') then
    begin
      edtLitros.Text := '0,00';
      edtValorTotal.Text := '0,00';
      edtValorImposto.Text := '0,00';
      Exit
    end;
    edtLitros.Text := FormatFloat('#,##0.00', TConexao.StringEmCurrency(edtValorTotal.Text) / ValorLitro);
    edtValorImposto.Text := FormatFloat('#,##0.00', (TConexao.StringEmCurrency(edtValorTotal.Text) * (PerImposto / 100)));
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.edtValorTotalKeyPress(Sender: TObject; var Key: Char);
begin
  try
    if not(Key in ['0'..'9',Char(8),Char(44)]) then
    begin
      Key := #0;
    end;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  try
    TConexao.ConectarBanco(Conexao);
    PageControl1.ActivePage:= tsMov;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  ObterDadosBomba;
  CarregarConfiguracao;

  DateTimePickerDataInicial.Date := Date();
  DateTimePickerDataFinal.Date := Date();
end;

procedure TFrmPrincipal.LimparCampos;
begin
  edtLitros.Text := '0,00';
  edtValorTotal.Text := '0,00';
  edtValorImposto.Text := '0,00';
  cbBomba.ItemIndex := -1;

  cbBomba.Text := 'Selecione uma Bomba';

  edtLitros.Enabled := False;
  edtValorTotal.Enabled := False;
  edtValorImposto.Enabled := False;
end;

procedure TFrmPrincipal.ObterDadosBomba;
var
  Query: TSQLQuery;
  BombaController: TBombaController;
begin
  Query := BombaController.ObterListaBombas;

  try
    while not(Query.Eof) do
    begin
      cbBomba.Items.Add(Trim(Query.FieldByName('Id').AsString) + ' - ' + Trim(Query.FieldByName('Descricao').AsString));
      Query.Next();
    end;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;

end;

procedure TFrmPrincipal.SetBombaId(const Value: Integer);
begin
  FBombaId := Value;
end;

procedure TFrmPrincipal.setPerImposto(const Value: Double);
begin
  FPerImposto := Value;
end;

procedure TFrmPrincipal.SetValorLitro(const Value: Double);
begin
  FValorLitro := Value;
end;

procedure TFrmPrincipal.Abastecer;
var
  BombaController :TBombaController;
  ConfigController :TConfigController;
  Configuracao :TConfiguracao;
  AbastecimentoController :TAbastecimentoController;
  Abastecimento :TAbastecimento;
begin
  try
    BombaController := TBombaController.Create;
    ConfigController := TConfigController.Create;
    Configuracao := ConfigController.ObterConfiguracao();
    FreeAndNil(ConfigController);
    Abastecimento := TAbastecimento.Create;
    Abastecimento.Data := Date;
    Abastecimento.Bomba := BombaController.ObterBombaPorId(BombaId);
    Abastecimento.Litros := TConexao.StringEmCurrency(Trim(edtLitros.Text));
    Abastecimento.Valor := TConexao.StringEmCurrency(Trim(edtValorTotal.Text));
    Abastecimento.Imposto := ((Configuracao.ValorImposto * Abastecimento.Valor) / 100);
    AbastecimentoController := TAbastecimentoController.Create;
    AbastecimentoController.Salvar(Abastecimento);
    FreeAndNil(AbastecimentoController);
    FreeAndNil(BombaController);
    FreeAndNil(Abastecimento);
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;

end;

function TFrmPrincipal.ValidarAbastecimento: Boolean;
begin

end;

procedure TFrmPrincipal.AtivarCampos;
begin
  edtLitros.Enabled := True;
  edtValorTotal.Enabled := True;
  edtValorImposto.Enabled := True;
end;

procedure TFrmPrincipal.BitBtn1Click(Sender: TObject);
begin
  try
    EditValorLitroGasolinaChange(Sender);
    EditValorLitroOleoDieselChange(Sender);
    EditValorIimpostoAbastecimentoChange(Sender);
    if not(ValidarGravacao()) then
    begin
      Exit;
    end;
    SalvarConfiguracao();
    TConexao.Mensagem('Configuração gravada com sucesso.');
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.BitBtn2Click(Sender: TObject);
  var
  Query: TSQLQuery;
  DataSource: TDataSource;
begin
  try
    if not(ValidaImpressao()) then
    begin
      Exit;
    end;
    TConexao.CriarQuery(Query);
    DataSource := TDataSource.Create(Self);
    DataSource.DataSet := Query;
    Query.SQL.Add('SELECT b.Descricao AS Bomba');
    Query.SQL.Add('      ,a.Data AS DataAbastecimento');
    Query.SQL.Add('      ,t.Descricao AS Tanque');
    Query.SQL.Add('      ,a.ValorTotal');
    Query.SQL.Add('  FROM Abastecimento a');
    Query.SQL.Add(' INNER JOIN Bomba b');
    Query.SQL.Add('    ON a.BombaId = b.Id');
    Query.SQL.Add(' INNER JOIN Tanque t');
    Query.SQL.Add('    ON b.TanqueId = t.Id');
    Query.SQL.Add(' WHERE Data >= '''+FormatDateTime('yyyy-mm-dd',DateTimePickerDataInicial.Date)+'''');
    Query.SQL.Add('   AND Data <= '''+FormatDateTime('yyyy-mm-dd',DateTimePickerDataFinal.Date)+'''');
    Query.SQL.Add(' ORDER BY b.Descricao');
    Query.Open();
    if (Query.IsEmpty) then
    begin
      TConexao.Mensagem('Não existem abastecimentos para serem impressos nesse período.');
      TConexao.DestruirQuery(Query);
      Exit;
    end;
    if (FormImpressaoAbastecimento = nil) then
    begin
      Application.CreateForm(TFormImpressaoAbastecimento, FormImpressaoAbastecimento);
    end;
    FormImpressaoAbastecimento.RLReportAbastecimentoBombas.DataSource := DataSource;
    FormImpressaoAbastecimento.Query := Query;
    FormImpressaoAbastecimento.RLReportAbastecimentoBombas.Preview();
    Application.RemoveComponent(FormImpressaoAbastecimento);
    FormImpressaoAbastecimento.Destroy;
    FormImpressaoAbastecimento := nil;
    FreeAndNil(DataSource);
    TConexao.DestruirQuery(Query);
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.BitBtnIniciarAbastecimentoClick(Sender: TObject);
begin
  try
    if not(ValidarAbastecimento()) then
    begin
      Exit;
    end;
    Abastecer();
    TConexao.Mensagem('Abastecimento realizado com sucesso.');

    LimparCampos;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.SalvarConfiguracao;
var
  ConfigController: TConfigController;
  Configuracao: TConfiguracao;
begin
  try
    Configuracao := TConfiguracao.Create;
    Configuracao.ValorLitroGasolina := TConexao.StringEmCurrency(Trim(EditValorLitroGasolina.Text));
    Configuracao.ValorLitroOleoDiesel := TConexao.StringEmCurrency(Trim(EditValorLitroOleoDiesel.Text));
    Configuracao.ValorImposto := TConexao.StringEmCurrency(Trim(EditValorIimpostoAbastecimento.Text));
    ConfigController := TConfigController.Create;
    ConfigController.Salvar(Configuracao);
    FreeAndNil(ConfigController);
    FreeAndNil(Configuracao);
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

function TFrmPrincipal.ValidarGravacao: Boolean;
begin
  try
    Result := False;
    if (Trim(EditValorLitroGasolina.Text) = '0,00') or (Trim(EditValorLitroGasolina.Text) = '0') then
    begin
      TConexao.Mensagem('Informe o valor do litro da gasolina.');
      EditValorLitroGasolina.SetFocus;
      Exit;
    end;
    if (Trim(EditValorLitroOleoDiesel.Text) = '0,00') or (Trim(EditValorLitroOleoDiesel.Text) = '0') then
    begin
      TConexao.Mensagem('Informe o valor do litro do óleo diesel.');
      EditValorLitroOleoDiesel.SetFocus;
      Exit;
    end;
    if (Trim(EditValorIimpostoAbastecimento.Text) = '0,00') or (Trim(EditValorIimpostoAbastecimento.Text) = '0') then
    begin
      TConexao.Mensagem('Informe o percentual do imposto');
      EditValorIimpostoAbastecimento.SetFocus;
      Exit;
    end;
    Result := True;
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

procedure TFrmPrincipal.CarregarConfiguracao;
var
  ConfiguracaoBO: TConfigController;
  Configuracao: TConfiguracao;
begin
  try
    ConfiguracaoBO := TConfigController.Create;
    Configuracao := ConfiguracaoBO.ObterConfiguracao();
    FreeAndNil(ConfiguracaoBO);
    EditValorLitroGasolina.Text := FormatFloat('#,##0.00', Configuracao.ValorLitroGasolina);
    EditValorLitroOleoDiesel.Text := FormatFloat('#,##0.00', Configuracao.ValorLitroOleoDiesel);
    EditValorIimpostoAbastecimento.Text := FormatFloat('#,##0.00', Configuracao.ValorImposto);
    FreeAndNil(Configuracao);
  except on E: Exception do
    begin
      TConexao.Mensagem(e.Message);
    end;
  end;
end;

function TFrmPrincipal.ValidaImpressao: Boolean;
begin
  try
    Result := False;
    if (DateTimePickerDataInicial.Date > DateTimePickerDataFinal.Date) then
    begin
      TConexao.Mensagem('A data inicial não pode ser maior que a data final.');
      Exit;
    end;
    Result := True;
  except on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

end.
