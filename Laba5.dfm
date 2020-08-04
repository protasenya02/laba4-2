object Animation: TAnimation
  Left = 0
  Top = 0
  Caption = 'Animation'
  ClientHeight = 410
  ClientWidth = 775
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object MediaPlayer1: TMediaPlayer
    Left = 136
    Top = 0
    Width = 253
    Height = 30
    Visible = False
    TabOrder = 0
  end
  object TimerRunner: TTimer
    OnTimer = TimerRunnerTimer
    Left = 64
    Top = 8
  end
end
