object Frm: TFrm
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Local RDP Checker by sebaxakerhtc'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RDP: TMsRdpClient9NotSafeForScripting
    Left = 0
    Top = 0
    Width = 800
    Height = 600
    TabOrder = 0
    ControlData = {0003000008000200000000000B0000000B000000}
  end
end
