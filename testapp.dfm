object Ftestapp: TFtestapp
  Left = 300
  Top = 124
  Width = 752
  Height = 370
  Caption = #22522#20110'Delphi7'#30340#31246#25511#35843#29992#27979#35797#31383#21475
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 24
    Top = 40
    Width = 78
    Height = 13
    Caption = #24453#21457#36865#25968#25454'1'#65306
  end
  object Label4: TLabel
    Left = 56
    Top = 104
    Width = 36
    Height = 13
    Caption = #35760#24405#65306
  end
  object Label5: TLabel
    Left = 24
    Top = 72
    Width = 78
    Height = 13
    Caption = #24453#21457#36865#25968#25454'2'#65306
  end
  object BConnectServer: TButton
    Left = 584
    Top = 16
    Width = 137
    Height = 25
    Caption = #36830#25509
    TabOrder = 0
    OnClick = BConnectServerClick
  end
  object EdtData: TEdit
    Left = 104
    Top = 32
    Width = 401
    Height = 21
    TabOrder = 1
    Text = 
      '{"name":"'#39532#32487#29645'","totalprice":"2401.36","itemnum":1,"id":"12345","a' +
      'lldetail":"0","memo1":"'#22791#27880#65306#26376#31199' 80.00 '#26032#21151#33021' 0.00 '#22269#38469' '#24066#35805#65306'20.00 '#38271#35805' 0.00 ' +
      #36807#32593#25968#25454#36153' 0.00 '#20449#24687#36153' 0.00","memo2":"'#19978#26376#20313#39069#65306'51.12 '#26412#26376#20313#39069#65306'51.12 '#32047#35745#23454#25910#65306' 100.00' +
      ' '#21512#21516#21495#65306'P0022384 '#25910#36153#26399#38388':2011-01-01 00:00:00 2011-02-28 23:59:59 ","ch' +
      'ildren":[{"taxname": "'#30005#35805#36890#35805#36153'","taxnum":"2","taxunit":"'#20214'","taxpric' +
      'e":"500.68","price": "100","taxitem": "15"}]};'
  end
  object LbLog: TListBox
    Left = 104
    Top = 104
    Width = 401
    Height = 193
    ItemHeight = 13
    TabOrder = 2
  end
  object EdtData1: TEdit
    Left = 104
    Top = 72
    Width = 401
    Height = 21
    TabOrder = 3
    Text = 
      '{"name":"'#20013#22269#32929#20221#26377#38480#20844#21496'","totalprice":"2401.36","itemnum":2,"id":"1234' +
      '5","alldetail":"0","memo1":"'#22791#27880#65306#26376#31199' 80.00 '#26032#21151#33021' 0.00 '#22269#38469' '#24066#35805#65306'20.00 '#38271#35805' ' +
      '0.00 '#36807#32593#25968#25454#36153' 0.00 '#20449#24687#36153' 0.00","memo2":"'#19978#26376#20313#39069#65306'51.12 '#26412#26376#20313#39069#65306'51.12 '#32047#35745#23454#25910#65306' 1' +
      '00.00 '#21512#21516#21495#65306'P0022384 '#25910#36153#26399#38388':2011-01-01 00:00:00 2011-02-28 23:59:59 ' +
      '","children":[{"taxname": "'#32500#20462#36153'","taxnum":"2","taxunit":"'#20214'","taxp' +
      'rice":"500.68","price": "1001.36","taxitem": "15"},{"taxname": "' +
      #25910#35270#36153'","taxnum":"12","taxunit":"'#26376'","taxprice":"120","price": "1000' +
      '","taxitem":"15"}]};'
  end
  object BtnSend: TButton
    Left = 584
    Top = 64
    Width = 137
    Height = 25
    Caption = #21457#36865
    TabOrder = 4
    OnClick = BtnSendClick
  end
  object BSendTwoData: TButton
    Left = 584
    Top = 112
    Width = 137
    Height = 25
    Caption = #21457#36865#20004#26465#25968#25454#27979#35797
    TabOrder = 5
    OnClick = BSendTwoDataClick
  end
  object BtnDisconnect: TButton
    Left = 584
    Top = 160
    Width = 137
    Height = 25
    Caption = #26029#24320
    TabOrder = 6
    OnClick = BtnDisconnectClick
  end
  object Button3: TButton
    Left = 584
    Top = 208
    Width = 137
    Height = 25
    Caption = #28165#31354#28040#24687
    TabOrder = 7
    OnClick = Button3Click
  end
  object BClose: TButton
    Left = 584
    Top = 264
    Width = 139
    Height = 25
    Caption = #20851#38381
    TabOrder = 8
    OnClick = BCloseClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 319
    Width = 744
    Height = 19
    Panels = <>
  end
end
