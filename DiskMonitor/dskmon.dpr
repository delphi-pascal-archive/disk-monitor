program dskmon;


{$R 'addons.res' 'addons.rc'}

uses
  Forms,
  main in 'main.pas' {FrmMain},
  InfosForm in 'InfosForm.pas' {FrmDiskInfo},
  AboutForm in 'AboutForm.pas' {FrmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'DiskMonitor';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmDiskInfo, FrmDiskInfo);
  Application.CreateForm(TFrmAbout, FrmAbout);
  Application.Run;
end.
