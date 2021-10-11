object FrmDiskInfo: TFrmDiskInfo
  Left = 596
  Top = 115
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Informations du disque'
  ClientHeight = 185
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object IDT6: TImage
    Left = 325
    Top = 219
    Width = 32
    Height = 32
    AutoSize = True
    Center = True
    Proportional = True
    Transparent = True
  end
  object IDT5: TImage
    Left = 290
    Top = 219
    Width = 32
    Height = 32
    AutoSize = True
    Center = True
    Proportional = True
    Transparent = True
  end
  object IDT4: TImage
    Left = 255
    Top = 219
    Width = 32
    Height = 32
    AutoSize = True
    Center = True
    Proportional = True
    Transparent = True
  end
  object IDT3: TImage
    Left = 220
    Top = 219
    Width = 32
    Height = 32
    AutoSize = True
    Center = True
    Proportional = True
    Transparent = True
  end
  object IDT2: TImage
    Left = 185
    Top = 219
    Width = 32
    Height = 32
    AutoSize = True
    Center = True
    Proportional = True
    Transparent = True
  end
  object IDT1: TImage
    Left = 150
    Top = 220
    Width = 32
    Height = 32
    AutoSize = True
    Center = True
    Proportional = True
    Transparent = True
  end
  object Panel1: TPanel
    Left = 5
    Top = 50
    Width = 356
    Height = 66
    BevelOuter = bvLowered
    TabOrder = 0
    object Label8: TLabel
      Left = 290
      Top = 45
      Width = 56
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0 %'
    end
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 24
      Height = 13
      Caption = 'Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 5
      Top = 25
      Width = 23
      Height = 13
      Caption = 'Libre'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 5
      Top = 45
      Width = 34
      Height = 13
      Caption = 'Utilis'#233'e'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 90
      Top = 5
      Width = 186
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0 Bytes'
    end
    object Label5: TLabel
      Left = 90
      Top = 25
      Width = 186
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0 Bytes'
    end
    object Label6: TLabel
      Left = 90
      Top = 45
      Width = 186
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0 Bytes'
    end
    object Label7: TLabel
      Left = 290
      Top = 25
      Width = 56
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = '0 %'
    end
  end
  object Panel2: TPanel
    Left = 5
    Top = 5
    Width = 356
    Height = 41
    BevelOuter = bvLowered
    Color = clWhite
    TabOrder = 1
    object Label9: TLabel
      Left = 40
      Top = 15
      Width = 311
      Height = 13
      Alignment = taCenter
      AutoSize = False
      Caption = '(unnamed drive)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Image1: TImage
      Left = 5
      Top = 5
      Width = 32
      Height = 32
      AutoSize = True
      Center = True
      Proportional = True
      Transparent = True
    end
  end
  object Panel3: TPanel
    Left = 5
    Top = 120
    Width = 356
    Height = 61
    BevelOuter = bvLowered
    TabOrder = 2
    object Label15: TLabel
      Left = 106
      Top = 43
      Width = 54
      Height = 13
      Caption = 'Not aviable'
    end
    object Label10: TLabel
      Left = 5
      Top = 3
      Width = 93
      Height = 13
      Caption = 'Systeme de fichiers'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 106
      Top = 3
      Width = 54
      Height = 13
      Caption = 'Not aviable'
    end
    object Label12: TLabel
      Left = 5
      Top = 23
      Width = 24
      Height = 13
      Caption = 'Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 106
      Top = 23
      Width = 38
      Height = 13
      Caption = 'Unknow'
    end
    object Label14: TLabel
      Left = 5
      Top = 43
      Width = 78
      Height = 13
      Caption = 'Numero de serie'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
end
