program CryptoNote;

uses
  Vcl.Forms,
  UFrmMain in 'UFrmMain.pas' {FrmMain} ,
  UFrmConfig in 'UFrmConfig.pas' {FrmConfig} ,
  CryptMod in 'CryptMod.pas',
  UFrmMDIChild in 'UFrmMDIChild.pas' {FrmMDIChild} ,
  UFrmMasterPwd in 'UFrmMasterPwd.pas' {FrmMasterPwd} ,
  UFrmDlgFileName in 'UFrmDlgFileName.pas' {FrmDlgFileName} ,
  UFrmSelectEncrypt in 'UFrmSelectEncrypt.pas' {FrmSelectEncrypt} ,
  UFrmOldDecrypt in 'UFrmOldDecrypt.pas' {FrmOldDeCrypt} ,
  UFrmDebugs in 'UFrmDebugs.pas' {FrmDebugs} ,
  UFrmSync in 'UFrmSync.pas' {FrmSync} ,
  UFrmSelectDir in 'UFrmSelectDir.pas' {FrmSelectDir} ,
  UFrmExt in 'UFrmExt.pas' {FrmExt} ,
  UFrmProgressBar in 'UFrmProgressBar.pas' {FrmProgressBar} ,
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amakrits');
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmConfig, FrmConfig);
  Application.CreateForm(TFrmMasterPwd, FrmMasterPwd);
  Application.CreateForm(TFrmDlgFileName, FrmDlgFileName);
  Application.CreateForm(TFrmSelectEncrypt, FrmSelectEncrypt);
  Application.CreateForm(TFrmDebugs, FrmDebugs);
  // Application.CreateForm(TFrmSync, FrmSync);
  Application.CreateForm(TFrmSelectDir, FrmSelectDir);
  Application.CreateForm(TFrmExt, FrmExt);
  Application.CreateForm(TFrmProgressBar, FrmProgressBar);
  // Application.CreateForm(TFrmOldDeCrypt, FrmOldDeCrypt);
  // Application.CreateForm(TFrmMDIChild, FrmMDIChild);
  Application.Run;

end.
