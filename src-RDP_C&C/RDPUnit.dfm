object RDPForm: TRDPForm
  Left = 0
  Top = 0
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Integrated Local RDP Checker by sebaxakerhtc'
  ClientHeight = 192
  ClientWidth = 192
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object RDPmstsc: TMsRdpClient9NotSafeForScripting
    Left = 0
    Top = 0
    Width = 192
    Height = 192
    TabOrder = 0
    ControlData = {0003000008000200000000000B0000000B000000}
  end
end
