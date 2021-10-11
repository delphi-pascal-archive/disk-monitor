unit InfosForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, diskutils, ExtCtrls;

type
  TFrmDiskInfo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Panel3: TPanel;
    IDT1: TImage;
    IDT2: TImage;
    IDT3: TImage;
    IDT4: TImage;
    IDT5: TImage;
    IDT6: TImage;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
    SelDsk : TDisk;
  end;

var
  FrmDiskInfo  : TFrmDiskInfo;

implementation

{$R *.dfm}

procedure TFrmDiskInfo.FormCreate(Sender: TObject);
var ResFlux : TResourceStream;
    N : integer;
const
  RSN : array[1..6] of string = ('IDT1','IDT2','IDT3','IDT4','IDT5','IDT6');
begin
  SelDsk := TDisk.Create;

  for N := 1 to 6 do
  begin
    ResFlux := TResourceStream.Create(0,RSN[N],RT_RCDATA);
    try
      (Self.FindComponent(RSN[N]) as TImage).Picture.Icon.LoadFromStream(ResFlux);
    finally
      ResFlux.Free;
    end;
  end;
end;

procedure TFrmDiskInfo.FormShow(Sender: TObject);
begin
  with image1.Picture do
    case SelDsk.DriveType of
      1: Icon := IDT1.Picture.Icon;
      2: Icon := IDT2.Picture.Icon;
      3: Icon := IDT3.Picture.Icon;
      4: Icon := IDT4.Picture.Icon;
      5: Icon := IDT5.Picture.Icon;
      6: Icon := IDT6.Picture.Icon;
    end;

  if Length(SelDsk.VolumeName) > 0 then
    Label9.Caption := SelDsk.VolumeName
  else
    Label9.Caption := '(unnamed drive)';

  Label9.Caption := format('%s [%s:]',[Label9.Caption,SelDsk.DiskLetter]);
  
  label4.Caption := format('%.0n %s',[SelDsk.SizeTotal*1.0,SizeBaseSymbol]);
  label5.Caption := format('%.0n %s',[SelDsk.SizeFree*1.0,SizeBaseSymbol]);
  label6.Caption := format('%.0n %s',[SelDsk.SizeUsed*1.0,SizeBaseSymbol]);

  label7.Caption := format('%.2f %%',[SelDsk.PercentFree]);
  label8.Caption := format('%.2f %%',[SelDsk.PercentUsed]);

  label11.Caption := SelDsk.FileSystem;
  Label13.Caption := format('%s [ %d ] [ %d ]',[SelDsk.DriveTypeStr,SelDsk.DriveType,GetDiskTypeX(SelDsk.DiskLetter)]);
  Label15.Caption := format('[ %s ] [ %u ]',[SelDsk.DriveSerialStr,SelDsk.DriveSerial]);
end;

procedure TFrmDiskInfo.FormDestroy(Sender: TObject);
begin
  SelDsk.Free;
end;

end.
