{ DiskMonitor (copyleft) 2006

  version of 2006/01/13 refacted in 2008, april

  CODA CODA NO REFACTORING !

  Refact progress    : ~70%
  Relooking progress : ~85%

  before refact :
    interface with bad design
    codes without comments
    codes without basic optimisations
    lot of interface bugs
    lot of memory leaks
    where is the about form ?
    files hierarchisation ...jackass inside!

  after refact :
    web2.0 design, with lot of beautifull png image ... wooooo!
    include the PNG API ... haaaaaa!
    added, basic comments ... mmmmm
    destroy the face of bugs ... BWAHAHAHA!
    added, basic optimisations, on the fly ... yupla!
    changed, defaults parameters ... really ?
    easter egg rulez! ... kanpai! 
}

unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, DiskUtils, StdCtrls, ExtCtrls, Menus;

type
  TFrmMain = class(TForm)
    ListBox1       : TListBox;
    Timer1         : TTimer;

    PopupMenu1     : TPopupMenu;
      Driveinfos1    : TMenuItem;
      N1             : TMenuItem;
      Rescan1        : TMenuItem;
      N3             : TMenuItem;
      Settings1      : TMenuItem;
        Divisionnorme1 : TMenuItem;
          N10241         : TMenuItem;
          N10001         : TMenuItem;
        Showedunit1    : TMenuItem;
          Bytes1         : TMenuItem;
          Octets1        : TMenuItem;
        Sizeformat1    : TMenuItem;
          Kilo1          : TMenuItem;
          Mega1          : TMenuItem;
          Giga1          : TMenuItem;
          Tera1          : TMenuItem;
        N4             : TMenuItem;
        Alphablending1 : TMenuItem;
        Stayontop1     : TMenuItem;
      N2             : TMenuItem;
      Exit1          : TMenuItem;
    Apropos1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure Rescan1Click(Sender: TObject);
    procedure Alphablending1Click(Sender: TObject);
    procedure Stayontop1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure N10241Click(Sender: TObject);
    procedure N10001Click(Sender: TObject);
    procedure Octets1Click(Sender: TObject);
    procedure Bytes1Click(Sender: TObject);
    procedure Kilo1Click(Sender: TObject);
    procedure Mega1Click(Sender: TObject);
    procedure Giga1Click(Sender: TObject);
    procedure Tera1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Driveinfos1Click(Sender: TObject);
    procedure Apropos1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FrmMain : TFrmMain;
  Disk  : TDisk;
  GSZFM : TSizeFormat = dsMega;
  iTCAP, iFCAP, iUCAP,
  oTCAP, oFCAP, oUCAP  : currency;

implementation

{$R *.dfm}

uses InfosForm, AboutForm, PNGImage;

function CreateRect(const L,T,R,B: integer): TRect; register;
begin
  result.Left  := L;
  result.Top   := T;
  result.Right := R;
  result.Bottom:= B;
end;

type
  TBlocItems = (enGaugeGoodLeft, enGaugeGoodMiddle,
                enGaugeHuhoMiddle, enGaugeHuhoRight,
                enGroundDrive, enGroundDriveSel,
                enGroundNetwork, enGroundNetworkSel,
                enGroundOther, enGroundOtherSel
                );
var
  BlocItems : array[TBlocItems] of TPNGObject;
  GaugeRect : TRect;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  N: TBlocItems;
const
  BlocItemsResName : array[TBlocItems] of string = ('GGOODL','GGOODM','GHUHOM','GHUHOR','GDRV','GDRVSL','GNET','GNETSL','GOTH','GOTHSL');
begin
  for N := Low(TBlocItems) to High(TBlocItems) do
  begin
    BlocItems[N] := TPNGObject.Create;
    BlocItems[N].LoadFromResourceName(0,BlocItemsResName[N]);
  end;

  DoubleBuffered := true;
  ClientWidth    := 369;
  ClientHeight   := 162;

  Gaugerect := CreateRect(159, 22, 361, 44);

  ListBox1.Left  := 0;
  ListBox1.Top   := 0;
  listbox1.Align := alTop;

  DiskUtils.LoadSymbolsArray(DiskUtils.ArSymbOctets);
  DiskUtils.LoadDivNormeArray(DiskUtils.ArNewNorme);

  Disk := TDisk.Create;

  Rescan1Click(Self);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
var
  N : TBlocItems;
begin
  Timer1.Enabled := false;
  ListBox1.Clear;
  Disk.Free;
  for N := High(TBlocItems) downto Low(TBlocItems) do
  begin
    BlocItems[N].Free;
  end;
end;

procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  ListBox1.Invalidate;
end;

procedure TFrmMain.ListBox1DrawItem(Control: TWinControl; Index: Integer;Rect: TRect; State: TOwnerDrawState);
var DSKL,DSKVN,DT,DF,DU,SUP,FST : string;
    UP       : integer;
begin
  DSKL := ListBox1.Items[index];

  if DSKL = '*' then
  begin
    DSKVN := 'LOCAL DISKS VALUE';
    DT    := format('%.2n %s',[iTCAP,DiskUtils.SizeGigaSymbol]);
    DF    := format('%.2n %s',[iFCAP,DiskUtils.SizeGigaSymbol]);
    DU    := format('%.2n %s',[iUCAP,DiskUtils.SizeGigaSymbol]);
    UP    := round(DiskUtils.ValueToPercent(iUCAP,iTCAP))*2;
    SUP   := format('%.1f %%',[UP*0.5]);
    FST   := '';
    Caption := 'DiskMonitor - Total: '+DT+' ('+SUP+' Free)';
  end
  else
  if DSKL = '#' then
  begin
    DSKVN := 'NETWORK DISKS VALUE';
    DT    := format('%.2n %s',[oTCAP,DiskUtils.SizeGigaSymbol]);
    DF    := format('%.2n %s',[oFCAP,DiskUtils.SizeGigaSymbol]);
    DU    := format('%.2n %s',[oUCAP,DiskUtils.SizeGigaSymbol]);
    UP    := round(DiskUtils.ValueToPercent(oUCAP,oTCAP))*2;
    SUP   := format('%.1f %%',[UP*0.5]);
    FST   := '';
  end
  else
  begin
    // recuperation de la lettre du lecteur a scanner
    Disk.DiskNumber := DiskLetterToNumber(Listbox1.Items[index][1]);

    // si il n'existe pas on rescanne tout les lecteurs
    if not disk.DiskExist then
    begin
      Rescan1Click(Self);
      exit;
    end;

    // on recupere les infos
    DSKL  := Disk.DiskLetter+':';
    DSKVN := Disk.VolumeName;

    // capacité totale
    DT    := GetDiskSizeStr(disk.DiskNumber,GSZFM,dsTotal,2);
    // capacité libre
    DF    := GetDiskSizeStr(disk.DiskNumber,GSZFM,dsFree ,2);
    // capacité utilisée
    DU    := GetDiskSizeStr(disk.DiskNumber,GSZFM,dsUsed ,2);
    // calcul de la taille de la gauge et du pourcentage
    UP    := round(Disk.PercentUsed)*2;
    SUP   := format('%.1f %%',[Disk.PercentUsed]);
    // mise en forme du systeme de fichier et type du lecteur
    FST   := '['+disk.FileSystem+' - '+disk.DriveTypeStr+']';
  end;

  with listbox1.Canvas do
  begin
    FillRect(rect);

    { Fond  ---- The CaseOf power! ^_^ }
    case (odSelected in State) of
      false : { not selected }
        if DSKL = '*' then
          Draw(Rect.Left, Rect.Top, BlocItems[enGroundDrive])
        else
        if DSKL = '#' then
          Draw(Rect.Left, Rect.Top, BlocItems[enGroundNetwork])
        else
          Draw(Rect.Left, Rect.Top, BlocItems[enGroundOther]);
      true : { selected }
        if DSKL = '*' then
          Draw(Rect.Left, Rect.Top, BlocItems[enGroundDriveSel])
        else
        if DSKL = '#' then
          Draw(Rect.Left, Rect.Top, BlocItems[enGroundNetworkSel])
        else
          Draw(Rect.Left, Rect.Top, BlocItems[enGroundOtherSel]);
    end;

    { Gauge ---- The InbricatedIfThen nightmare! >_< }
    if UP <> 0 then
    begin
      { Gauge left < 5% }
      Draw(Rect.Left+159, Rect.Top+22, BlocItems[enGaugeGoodLeft]);
      if UP > 9 then
      begin
        if UP < 151 then  { And now ... The StretchBlt parade! }
          { gauge middle < 75% }
          StretchBlt(Handle, Rect.Left+169, Rect.Top+22, UP-10, 22,
                     BlocItems[enGaugeGoodMiddle].Canvas.Handle, 0, 0, 1, 22, SRCCOPY)
        else
        begin
          { gauge middle > 75% }
          StretchBlt(Handle, Rect.Left+169, Rect.Top+22, 150, 22,
                     BlocItems[enGaugeGoodMiddle].Canvas.Handle, 0, 0, 1, 22, SRCCOPY);
          if UP < 191 then
            { gauge middle < 95% }
            StretchBlt(Handle, Rect.Left+319, Rect.Top+22, UP-160, 22,
                       BlocItems[enGaugeHuhoMiddle].Canvas.Handle, 0, 0, 1, 22, SRCCOPY)
          else
          begin
            { gauge middle > 95%}
            StretchBlt(Handle, Rect.Left+319, Rect.Top+22, 32, 22,
                       BlocItems[enGaugeHuhoMiddle].Canvas.Handle, 0, 0, 1, 22, SRCCOPY);
            { gauge right > 95% }
            Draw(Rect.Left+351, Rect.Top+22, BlocItems[enGaugeHuhoRight]);
          end;
        end;
      end;
    end;

    // textes
    brush.Style := bsclear;
    pen.Color   := clBlack;

    font.Color := clBlack;
    font.Style := [fsBold];
    // lettre lecteur
    if not ((DSKL='*') or (DSKL='#')) then
      TextOut(rect.Left+4, rect.Top+4, DSKL);

    // nom du lecteur
    TextOut(160, rect.Top+5, DSKVN);
    font.Style := [];   

    // systeme de fichier et type du lecteur
    TextOut(360-TextWidth(FST), rect.Top+5, FST);

    // taille totale
    TextOut(24, rect.Top+5, 'Total');
    TextOut(74+(80-TextWidth(DT)), rect.Top+4, DT);

    // taille libre
    TextOut(24, rect.Top+20, 'Free');
    TextOut(74+(80-TextWidth(DF)), rect.Top+20, DF);

    // taille utilisée
    TextOut(24, rect.Top+35, 'Used');
    TextOut(74+(80-TextWidth(DU)), rect.Top+35, DU);

    // pourcentage gauge
    font.color := clMaroon;
    TextOut(260-(TextWidth(SUP) shr 1), rect.Top+26, SUP);

    brush.Style := bssolid;
  end;
end;

procedure TFrmMain.Rescan1Click(Sender: TObject);
var x : integer;
begin
  Listbox1.Clear;
  Listbox1.Items.Add('*');
  Listbox1.Items.Add('#');

  iTCAP := 0;
  iFCAP := 0;
  iUCAP := 0;

  oTCAP := 0;
  oFCAP := 0;
  oUCAP := 0;

  for x := 1 to 26 do
  begin
    Disk.DiskNumber := x;
    if Disk.DiskExist then
    begin
      Listbox1.Items.Add(format('%s',[Disk.DiskLetter]));
      if Disk.DriveType = 3 then
      begin
        iTCAP := iTCAP + DiskUtils.DivSizeTo(Disk.SizeTotal,dsGiga);
        iFCAP := iFCAP + DiskUtils.DivSizeTo(Disk.SizeFree,dsGiga);
        iUCAP := iUCAP + DiskUtils.DivSizeTo(Disk.SizeUsed,dsGiga);
      end
      else
      if Disk.DriveType = 4 then
      begin
        oTCAP := oTCAP + DiskUtils.DivSizeTo(Disk.SizeTotal,dsGiga);
        oFCAP := oFCAP + DiskUtils.DivSizeTo(Disk.SizeFree,dsGiga);
        oUCAP := oUCAP + DiskUtils.DivSizeTo(Disk.SizeUsed,dsGiga);
      end;
    end;
  end;

  ListBox1.Height := ListBox1.Count * 54;
  Self.Constraints.MaxWidth := Self.Width;
end;

procedure TFrmMain.Alphablending1Click(Sender: TObject);
begin
  AlphaBlend := Alphablending1.Checked;
end;

procedure TFrmMain.Stayontop1Click(Sender: TObject);
begin
  if Stayontop1.Checked then
  begin
    FormStyle := fsStayOnTop;
    BringToFront;
  end
  else
    FormStyle := fsNormal;
end;

procedure TFrmMain.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.ListBox1DblClick(Sender: TObject);
begin
  listbox1.ItemIndex := -1;
end;

procedure TFrmMain.N10241Click(Sender: TObject);
begin
  DiskUtils.LoadDivNormeArray(DiskUtils.ArOldNorme);
  Rescan1Click(nil);
end;

procedure TFrmMain.N10001Click(Sender: TObject);
begin
  DiskUtils.LoadDivNormeArray(DiskUtils.ArNewNorme);
  Rescan1Click(nil);
end;

procedure TFrmMain.Octets1Click(Sender: TObject);
begin
  DiskUtils.LoadSymbolsArray(DiskUtils.ArSymbOctets);
  Rescan1Click(nil);
end;

procedure TFrmMain.Bytes1Click(Sender: TObject);
begin
  DiskUtils.LoadSymbolsArray(DiskUtils.ArSymbBytes);
  Rescan1Click(nil);
end;

procedure TFrmMain.Kilo1Click(Sender: TObject);
begin
  GSZFM := dsKilo;
  Rescan1Click(nil);
end;

procedure TFrmMain.Mega1Click(Sender: TObject);
begin
  GSZFM := dsMega;
  Rescan1Click(nil);
end;

procedure TFrmMain.Giga1Click(Sender: TObject);
begin
  GSZFM := dsGiga;
  Rescan1Click(nil);
end;

procedure TFrmMain.Tera1Click(Sender: TObject);
begin
  GSZFM := dsTera;
  Rescan1Click(nil);
end;

procedure TFrmMain.PopupMenu1Popup(Sender: TObject);
begin
  with listbox1 do
    if (ItemIndex >= -1) and (ItemIndex <=1) then
    begin
      DriveInfos1.Visible := false;
      N1.Visible          := false;
    end
    else
    begin
      DriveInfos1.Visible := true;
      N1.Visible          := true;
    end;
end;

procedure TFrmMain.Driveinfos1Click(Sender: TObject);
begin
  with listbox1 do
    if (ItemIndex >= -1) and (ItemIndex <=1) then
      exit;

  with InfosForm.FrmDiskInfo do
  begin
    SelDsk.DiskNumber := DiskLetterToNumber(Listbox1.Items[listbox1.itemindex][1]);

    if Showing then
      FormShow(Self)
    else
      Show;
  end;
end;

procedure TFrmMain.Apropos1Click(Sender: TObject);
begin
  AboutForm.FrmAbout.Execute;
end;


procedure TFrmMain.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if WheelDelta > 0 then
    VertScrollBar.Position:= VertScrollBar.Position-VertScrollBar.Increment
  else
  if WheelDelta < 0 then
    VertScrollBar.Position:= VertScrollBar.Position+VertScrollBar.Increment;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  FrmMain.ClientHeight:= listbox1.Height;
end;

end.
