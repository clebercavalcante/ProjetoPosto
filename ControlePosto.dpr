program ControlePosto;

uses
  Vcl.Forms,
  Principal in 'Views\Principal.pas' {FrmPrincipal},
  Abastecimento in 'Models\Abastecimento.pas',
  Bomba in 'Models\Bomba.pas',
  Configuracao in 'Models\Configuracao.pas',
  Tanque in 'Models\Tanque.pas',
  BombaController in 'Controllers\BombaController.pas',
  uConexao in 'uConexao.pas',
  ConfigController in 'Controllers\ConfigController.pas',
  TanqueController in 'Controllers\TanqueController.pas',
  AbastecimentoController in 'Controllers\AbastecimentoController.pas',
  AbastecimentoDAO in 'DAO\AbastecimentoDAO.pas',
  BombaDAO in 'DAO\BombaDAO.pas',
  ConfiguracaoDAO in 'DAO\ConfiguracaoDAO.pas',
  TanqueDAO in 'DAO\TanqueDAO.pas',
  ImpressaoAbastecimento in 'Views\ImpressaoAbastecimento.pas' {FormImpressaoAbastecimento};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TFormImpressaoAbastecimento, FormImpressaoAbastecimento);
  Application.Run;
end.
