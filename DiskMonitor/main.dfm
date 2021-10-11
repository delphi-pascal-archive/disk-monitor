object FrmMain: TFrmMain
  Left = 215
  Top = 120
  Width = 393
  Height = 217
  VertScrollBar.Smooth = True
  VertScrollBar.Tracking = True
  AlphaBlendValue = 180
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'DiskMonitor'
  Color = clBtnFace
  Constraints.MinHeight = 108
  Constraints.MinWidth = 369
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ScreenSnap = True
  SnapBuffer = 15
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 369
    Height = 169
    Style = lbOwnerDrawVariable
    Align = alTop
    BorderStyle = bsNone
    Color = 15790320
    Constraints.MaxWidth = 369
    Constraints.MinHeight = 108
    Constraints.MinWidth = 369
    ExtendedSelect = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 54
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDblClick = ListBox1DblClick
    OnDrawItem = ListBox1DrawItem
  end
  object Timer1: TTimer
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 13
    Top = 5
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 43
    Top = 5
    object Driveinfos1: TMenuItem
      Caption = 'Disk info ...'
      OnClick = Driveinfos1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Rescan1: TMenuItem
      Caption = 'Regresh'
      OnClick = Rescan1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Settings1: TMenuItem
      Caption = 'Options'
      object Divisionnorme1: TMenuItem
        Caption = 'Norme des octets'
        object N10241: TMenuItem
          AutoCheck = True
          Caption = '1024'
          RadioItem = True
          OnClick = N10241Click
        end
        object N10001: TMenuItem
          AutoCheck = True
          Caption = '1000'
          Checked = True
          RadioItem = True
          OnClick = N10001Click
        end
      end
      object Showedunit1: TMenuItem
        Caption = 'Unite de capacite'
        object Bytes1: TMenuItem
          AutoCheck = True
          Caption = 'Bytes'
          GroupIndex = 1
          RadioItem = True
          OnClick = Bytes1Click
        end
        object Octets1: TMenuItem
          AutoCheck = True
          Caption = 'Octets'
          Checked = True
          GroupIndex = 1
          RadioItem = True
          OnClick = Octets1Click
        end
      end
      object Sizeformat1: TMenuItem
        Caption = 'Format de capacite'
        object Kilo1: TMenuItem
          AutoCheck = True
          Caption = 'Kilo'
          GroupIndex = 2
          RadioItem = True
          OnClick = Kilo1Click
        end
        object Mega1: TMenuItem
          AutoCheck = True
          Caption = 'Mega'
          GroupIndex = 2
          RadioItem = True
          OnClick = Mega1Click
        end
        object Giga1: TMenuItem
          AutoCheck = True
          Caption = 'Giga'
          Checked = True
          GroupIndex = 2
          RadioItem = True
          OnClick = Giga1Click
        end
        object Tera1: TMenuItem
          AutoCheck = True
          Caption = 'Tera'
          GroupIndex = 2
          RadioItem = True
          OnClick = Tera1Click
        end
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Alphablending1: TMenuItem
        AutoCheck = True
        Caption = 'Transparence'
        OnClick = Alphablending1Click
      end
      object Stayontop1: TMenuItem
        AutoCheck = True
        Caption = 'Stay on Top'
        OnClick = Stayontop1Click
      end
    end
    object Apropos1: TMenuItem
      Caption = 'About...'
      OnClick = Apropos1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Exit1: TMenuItem
      Caption = 'Exit'
      OnClick = Exit1Click
    end
  end
end
