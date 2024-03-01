object AppRDGoogleAIExmplMainForm: TAppRDGoogleAIExmplMainForm
  Left = 0
  Top = 0
  Caption = 'Google AI Gemini Test Application'
  ClientHeight = 560
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 104
    Width = 39
    Height = 15
    Caption = 'Models'
  end
  object Label2: TLabel
    Left = 8
    Top = 160
    Width = 40
    Height = 15
    Caption = 'Prompt'
  end
  object Label3: TLabel
    Left = 8
    Top = 224
    Width = 100
    Height = 15
    Caption = 'Generated Content'
  end
  object Label4: TLabel
    Left = 8
    Top = 424
    Width = 25
    Height = 15
    Caption = 'Error'
  end
  object Label5: TLabel
    Left = 8
    Top = 56
    Width = 45
    Height = 15
    Caption = 'BaseURL'
  end
  object Label6: TLabel
    Left = 8
    Top = 8
    Width = 37
    Height = 15
    Caption = 'ApiKey'
  end
  object Button1: TButton
    Left = 295
    Top = 175
    Width = 75
    Height = 25
    Caption = 'Go'
    TabOrder = 0
    OnClick = Button1Click
  end
  object edPrompt: TEdit
    Left = 8
    Top = 176
    Width = 281
    Height = 23
    TabOrder = 1
    Text = 'How are you?'
  end
  object comboModels: TComboBox
    Left = 8
    Top = 120
    Width = 281
    Height = 23
    Style = csDropDownList
    TabOrder = 2
  end
  object Button2: TButton
    Left = 296
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Get Models'
    TabOrder = 3
    OnClick = Button2Click
  end
  object MemoContent: TMemo
    Left = 8
    Top = 240
    Width = 361
    Height = 169
    Lines.Strings = (
      'MemoContent')
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object MemoError: TMemo
    Left = 8
    Top = 440
    Width = 361
    Height = 81
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object edBaseURL: TEdit
    Left = 8
    Top = 72
    Width = 363
    Height = 23
    TabOrder = 6
    Text = 'https://generativelanguage.googleapis.com/v1beta'
  end
  object edApiKey: TEdit
    Left = 8
    Top = 24
    Width = 363
    Height = 23
    TabOrder = 7
  end
  object RDGoogleAIGemini1: TRDGoogleAIGemini
    Proxy = '1'
    URL = 'https://generativelanguage.googleapis.com/v1beta'
    Model = 'models/gemini-pro'
    OnModelsLoaded = RDGoogleAIGemini1ModelsLoaded
    OnError = RDGoogleAIGemini1Error
    OnCandidatesLoaded = RDGoogleAIGemini1CandidatesLoaded
    Left = 144
    Top = 296
  end
end
