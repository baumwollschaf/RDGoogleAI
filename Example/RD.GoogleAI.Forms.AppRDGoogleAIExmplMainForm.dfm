object AppRDGoogleAIExmplMainForm: TAppRDGoogleAIExmplMainForm
  Left = 0
  Top = 0
  Caption = 'AppRDGoogleAIExmplMainForm'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Button1: TButton
    Left = 280
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object RDGoogleAIGemini1: TRDGoogleAIGemini
    Proxy = '1'
    URL = 'https://generativelanguage.googleapis.com/v1beta'
    Model = 'models/gemini-pro'
    OnError = RDGoogleAIGemini1Error
    Left = 264
    Top = 152
  end
end
