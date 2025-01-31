object AppRDGoogleAIExmplMainForm: TAppRDGoogleAIExmplMainForm
  Left = 0
  Top = 0
  Caption = 'Google AI Gemini Test Application'
  ClientHeight = 547
  ClientWidth = 515
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
    Top = 200
    Width = 39
    Height = 15
    Caption = 'Models'
  end
  object Label2: TLabel
    Left = 8
    Top = 256
    Width = 40
    Height = 15
    Caption = 'Prompt'
  end
  object Label3: TLabel
    Left = 8
    Top = 320
    Width = 100
    Height = 15
    Caption = 'Generated Content'
  end
  object Label4: TLabel
    Left = 8
    Top = 464
    Width = 25
    Height = 15
    Caption = 'Error'
  end
  object Label5: TLabel
    Left = 8
    Top = 152
    Width = 45
    Height = 15
    Caption = 'BaseURL'
  end
  object Label6: TLabel
    Left = 8
    Top = 104
    Width = 37
    Height = 15
    Caption = 'ApiKey'
  end
  object Label7: TLabel
    Left = 8
    Top = 8
    Width = 84
    Height = 15
    Caption = '!!! Attention !!!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 24
    Top = 29
    Width = 465
    Height = 60
    AutoSize = False
    Caption = 
      'This example was developed when the GoogleAI API for Germany had' +
      ' not yet been released. The calls work with online API REST test' +
      'ing tools. The models can be loaded, but are not yet functional ' +
      'in v1beta except for "gemini-pro". As soon as the API is release' +
      'd, I will continue to tinker with it and fix bugs. But it should' +
      ' work somewhat.'
    WordWrap = True
  end
  object Button1: TButton
    Left = 295
    Top = 271
    Width = 50
    Height = 25
    Caption = 'Go'
    TabOrder = 0
    OnClick = Button1Click
  end
  object edPrompt: TEdit
    Left = 8
    Top = 272
    Width = 281
    Height = 23
    TabOrder = 1
    Text = 'How are you?'
  end
  object comboModels: TComboBox
    Left = 8
    Top = 216
    Width = 281
    Height = 23
    Style = csDropDownList
    TabOrder = 2
  end
  object Button2: TButton
    Left = 296
    Top = 216
    Width = 201
    Height = 25
    Caption = 'Get Models'
    TabOrder = 3
    OnClick = Button2Click
  end
  object MemoContent: TMemo
    Left = 8
    Top = 341
    Width = 489
    Height = 117
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object MemoError: TMemo
    Left = 8
    Top = 480
    Width = 489
    Height = 49
    ScrollBars = ssVertical
    TabOrder = 5
  end
  object edBaseURL: TEdit
    Left = 8
    Top = 168
    Width = 489
    Height = 23
    TabOrder = 6
    Text = 'https://generativelanguage.googleapis.com/v1'
  end
  object edApiKey: TEdit
    Left = 8
    Top = 120
    Width = 489
    Height = 23
    TabOrder = 7
  end
  object Button3: TButton
    Left = 351
    Top = 271
    Width = 146
    Height = 25
    Caption = 'Go (relating on model)'
    Enabled = False
    TabOrder = 8
    OnClick = Button3Click
  end
  object RDGoogleAIGemini1: TRDGoogleAIGemini
    URL = 'https://generativelanguage.googleapis.com/v1'
    Model = 'models/gemini-pro'
    OnModelsLoaded = RDGoogleAIGemini1ModelsLoaded
    OnError = RDGoogleAIGemini1Error
    OnCandidatesLoaded = RDGoogleAIGemini1CandidatesLoaded
    Left = 184
    Top = 384
  end
end
