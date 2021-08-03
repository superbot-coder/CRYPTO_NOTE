program CryptoNote;

uses
  Vcl.Forms,
  UFrmMain in 'UFrmMain.pas' {FrmMain},
  UFrmConfig in 'UFrmConfig.pas' {FrmConfig},
  CryptMod in 'CryptMod.pas',
  UFrmMDIChild in 'UFrmMDIChild.pas' {FrmMDIChild},
  UFrmMasterPwd in 'UFrmMasterPwd.pas' {FrmMasterPwd},
  UFrmDlgFileName in 'UFrmDlgFileName.pas' {FrmDlgFileName},
  UFrmSelectEncrypt in 'UFrmSelectEncrypt.pas' {FrmSelectEncrypt},
  UFrmOldDecrypt in 'UFrmOldDecrypt.pas' {FrmOldDeCrypt},
  // UFrmColorParam in 'UFrmColorParam.pas' {FrmColorParam},
  UFrmDebugs in 'UFrmDebugs.pas' {FrmDebugs},
  UFrmSync in 'UFrmSync.pas' {FrmSync},
  UFrmSelectDir in 'UFrmSelectDir.pas' {FrmSelectDir},
  UFrmExt in 'UFrmExt.pas' {FrmExt},
  UFrmProgressBar in 'UFrmProgressBar.pas' {FrmProgressBar};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmConfig, FrmConfig);
  Application.CreateForm(TFrmMasterPwd, FrmMasterPwd);
  Application.CreateForm(TFrmDlgFileName, FrmDlgFileName);
  Application.CreateForm(TFrmSelectEncrypt, FrmSelectEncrypt);
  // Application.CreateForm(TFrmColorParam, FrmColorParam);
  Application.CreateForm(TFrmDebugs, FrmDebugs);
  //Application.CreateForm(TFrmSync, FrmSync);
  Application.CreateForm(TFrmSelectDir, FrmSelectDir);
  Application.CreateForm(TFrmExt, FrmExt);
  Application.CreateForm(TFrmProgressBar, FrmProgressBar);
  //Application.CreateForm(TFrmOldDeCrypt, FrmOldDeCrypt);
  // Application.CreateForm(TFrmMDIChild, FrmMDIChild);
  Application.Run;
end.
