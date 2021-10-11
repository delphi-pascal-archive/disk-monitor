unit AboutForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, OleCtrls, SHDocVw, StdCtrls;

type
  TFrmAbout = class(TForm)
    Timer1: TTimer;
    WebBrowser1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure FormDblClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure WebBrowser1DocumentComplete(Sender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
  private
  public
    function Execute: boolean;
  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.dfm}

uses PNGImage, TinyHash;

{ TFrmAbout }

var PNG     : TPNGObject;
    PNGANIM : array[0..7] of TPNGObject;
    DEEZER  : string;
    EASTEREGG: boolean = false;
    EASTEREGGCOMUTATOR : TMD5Digest = ($38,$35,$cf,$79,$62,$6e,$ff,$f8,$56,$24,$e7,$9a,$56,$a7,$64,$b6);

procedure TFrmAbout.FormCreate(Sender: TObject);
var n: integer;
    Path : string;
begin
  if paramcount = 1 then
    EASTEREGG := TinyHash.MD5Compare(TinyHash.MD5(ParamStr(1)), EASTEREGGCOMUTATOR);

  DoubleBuffered := true;

  PNG := TPNGObject.Create;
  PNG.LoadFromResourceName(0,'ABOUT');

  self.ClientWidth := PNG.Width;
  self.Height      := PNG.Height;

  if EASTEREGG then
  begin
    WebBrowser1.Visible := true;
    WebBrowser1.Left    := -2;
    WebBrowser1.Top     := 384-25;
    Path := ExtractFilePath(paramStr(0));
    DEEZER := Path+'deezer.html';

    for n := 0 to 7 do
    begin
      PNGANIM[n] := TPNGObject.Create;
      PNGANIM[n].LoadFromResourceName(0,'DANCE'+IntToStr(n));
    end;

    if Not FileExists(DEEZER) then
      with TResourceStream.Create(0,'DEEZER', RT_RCDATA) do
      try
        SaveToFile(DEEZER);
      finally
        Free;
      end;
  end;
end;

procedure TFrmAbout.FormDestroy(Sender: TObject);
var n : integer;
begin
  if EASTEREGG then
  begin
    for n := 7 downto 0 do
      PNGANIM[n].Free;
    sysutils.DeleteFile(DEEZER);
  end;
  PNG.Free;
end;

function TFrmAbout.Execute: boolean;
begin
  BringToFront;

  if EASTEREGG then
  begin
    Timer1.Interval := round(60000/(130*4));
    WebBrowser1.Navigate('file:///'+DEEZER);
  end;

  result := (ShowModal = mrOk);

  if EASTEREGG then
  begin
    Timer1.Enabled := false;
    WebBrowser1.Navigate('about:blank');
  end;
end;

procedure TFrmAbout.Image1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

var AI : integer = 0;

procedure TFrmAbout.FormPaint(Sender: TObject);
begin
  Canvas.Draw(0,0,PNG);

  if EASTEREGG and Timer1.Enabled then
  begin
    Canvas.Draw(65, 115, PNGANIM[AI]);
    Canvas.Draw(201, 115, PNGANIM[AI]);
    Canvas.Draw(335, 115, PNGANIM[AI]);
    AI := (AI+1) mod 8;
  end;
end;

procedure TFrmAbout.FormClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmAbout.FormContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  ModalResult := mrOk;
end;

procedure TFrmAbout.FormDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TFrmAbout.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ModalResult := mrOk;
end;

var WR : boolean = false;
    WI : cardinal = 0;

procedure TFrmAbout.Timer1Timer(Sender: TObject);
begin
  case WR of
    true : invalidate;
    false :
    begin
      WI := WI + Timer1.Interval;
      WR := WI >= 1500;
    end;
  end;
end;

procedure TFrmAbout.WebBrowser1DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  WR := false;
  WI := 0;
  Timer1.Enabled := true;
end;

end.
