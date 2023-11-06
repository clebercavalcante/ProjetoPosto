object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Controle de Posto de Combust'#237'vel'
  ClientHeight = 240
  ClientWidth = 478
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 478
    Height = 240
    ActivePage = tsRel
    Align = alClient
    TabOrder = 0
    object tsMov: TTabSheet
      Caption = 'Movimenta'#231#227'o'
      object lbBomba: TLabel
        Left = 24
        Top = 19
        Width = 44
        Height = 15
        Caption = 'Bomba :'
      end
      object lbLitros: TLabel
        Left = 24
        Top = 59
        Width = 58
        Height = 15
        Caption = 'Qtd. Litros:'
      end
      object lbValorTotal: TLabel
        Left = 168
        Top = 59
        Width = 57
        Height = 15
        Caption = 'Valor Total:'
      end
      object lbValorImposto: TLabel
        Left = 314
        Top = 59
        Width = 76
        Height = 15
        Caption = 'Valor Imposto:'
      end
      object Bevel1: TBevel
        Left = 0
        Top = 149
        Width = 457
        Height = 2
      end
      object cbBomba: TComboBox
        Left = 74
        Top = 16
        Width = 361
        Height = 23
        TabOrder = 0
        Text = 'Selecione uma Bomba'
        OnChange = cbBombaChange
      end
      object edtLitros: TEdit
        Left = 24
        Top = 80
        Width = 121
        Height = 23
        Enabled = False
        TabOrder = 1
        Text = '0,00'
        OnChange = edtLitrosChange
        OnKeyPress = edtLitrosKeyPress
      end
      object edtValorTotal: TEdit
        Left = 168
        Top = 80
        Width = 121
        Height = 23
        Enabled = False
        TabOrder = 2
        Text = '0,00'
        OnChange = edtValorTotalChange
        OnKeyPress = edtValorTotalKeyPress
      end
      object edtValorImposto: TEdit
        Left = 314
        Top = 80
        Width = 121
        Height = 23
        Color = 12369084
        Enabled = False
        TabOrder = 3
        Text = '0,00'
        OnKeyPress = edtValorImpostoKeyPress
      end
      object BitBtnIniciarAbastecimento: TBitBtn
        Left = 319
        Top = 173
        Width = 138
        Height = 25
        Caption = '&Efetuar Abastecimento'
        TabOrder = 4
        OnClick = BitBtnIniciarAbastecimentoClick
      end
    end
    object tsRel: TTabSheet
      Caption = 'Relat'#243'rio'
      ImageIndex = 2
      object LabelDataInicial: TLabel
        Left = 8
        Top = 17
        Width = 58
        Height = 15
        Caption = 'Data Inicial'
      end
      object LabelDataFinal: TLabel
        Left = 254
        Top = 17
        Width = 52
        Height = 15
        Caption = 'Data Final'
      end
      object Bevel3: TBevel
        Left = 7
        Top = 145
        Width = 457
        Height = 2
      end
      object DateTimePickerDataInicial: TDateTimePicker
        Left = 8
        Top = 38
        Width = 186
        Height = 24
        Date = 42812.000000000000000000
        Time = 0.517110393520852100
        TabOrder = 0
      end
      object DateTimePickerDataFinal: TDateTimePicker
        Left = 254
        Top = 39
        Width = 186
        Height = 24
        Date = 42812.000000000000000000
        Time = 0.517110393520852100
        TabOrder = 1
      end
      object BitBtn2: TBitBtn
        Left = 368
        Top = 155
        Width = 97
        Height = 25
        Caption = '&Imprimir'
        TabOrder = 2
        OnClick = BitBtn2Click
      end
      object StatusBar: TStatusBar
        Left = 0
        Top = 191
        Width = 470
        Height = 19
        Panels = <
          item
            Width = 50
          end>
      end
    end
    object tsConfig: TTabSheet
      Caption = 'Configura'#231#227'o'
      ImageIndex = 1
      object LabelValorLitroGasolina: TLabel
        Left = 9
        Top = 14
        Width = 97
        Height = 15
        Caption = 'Valor litro gasolina'
      end
      object LabelValorLitroOleoDiesel: TLabel
        Left = 136
        Top = 14
        Width = 109
        Height = 15
        Caption = 'Valor litro '#243'leo diesel'
      end
      object LabelValorImpostoAbastecimento: TLabel
        Left = 296
        Top = 14
        Width = 77
        Height = 15
        Caption = '% do Imposto '
      end
      object Bevel2: TBevel
        Left = 8
        Top = 157
        Width = 457
        Height = 2
      end
      object EditValorLitroGasolina: TEdit
        Left = 3
        Top = 35
        Width = 81
        Height = 23
        TabOrder = 0
        Text = '0,00'
        OnChange = EditValorLitroGasolinaChange
        OnKeyPress = EditValorLitroGasolinaKeyPress
      end
      object EditValorLitroOleoDiesel: TEdit
        Left = 136
        Top = 35
        Width = 81
        Height = 23
        TabOrder = 1
        Text = '0,00'
        OnChange = EditValorLitroOleoDieselChange
        OnKeyPress = EditValorLitroOleoDieselKeyPress
      end
      object EditValorIimpostoAbastecimento: TEdit
        Left = 296
        Top = 35
        Width = 81
        Height = 23
        TabOrder = 2
        Text = '0,00'
        OnChange = EditValorIimpostoAbastecimentoChange
        OnKeyPress = EditValorIimpostoAbastecimentoKeyPress
      end
      object BitBtn1: TBitBtn
        Left = 368
        Top = 171
        Width = 97
        Height = 25
        Caption = '&Salvar'
        TabOrder = 3
        OnClick = BitBtn1Click
      end
    end
  end
  object Conexao: TSQLConnection
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXFirebird'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver160.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=16.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFire' +
        'birdDriver160.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandF' +
        'actory,Borland.Data.DbxFirebirdDriver,Version=16.0.0.0,Culture=n' +
        'eutral,PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverINTERBASE'
      'LibraryName=dbxfb.dll'
      'LibraryNameOsx=libsqlfb.dylib'
      'VendorLib=fbclient.dll'
      'VendorLibWin64=fbclient.dll'
      'VendorLibOsx=/Library/Frameworks/Firebird.framework/Firebird'
      'Database='
      'User_Name=sysdba'
      'Password=123'
      'Role=RoleName'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'SQLDialect=3'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'TrimChar=False'
      'BlobSize=-1'
      'ErrorResourceFile='
      'RoleName=RoleName'
      'ServerCharSet='
      'Trim Char=False')
    Left = 650
    Top = 33
  end
end
