unit CryptMod;

interface

Uses
  System.SysUtils, Classes, Dialogs, System.Math, DCPrc4, DCPSha1, DCPSha256,
  DCPSha512, DCPMD5, DeviceSN;
// MsgLog;

Type
  TCryptDlgMode = (DLG_ECRYPT, DLG_DECRYPT);

Type
  TAlgoType = (UNTYPE, RC4_SHA1, RC4_SHA256, RC4_SHA512);

type
  TSignature = record
    hash_uncrypt: AnsiString;
    hash_encrypt: AnsiString;
    Algo: TAlgoType;
    Checked: Boolean;
  end;

  PSignature = ^TSignature;

Var
  SignMaxLength: SmallInt = 72;

const
  AlgoName: array [TAlgoType] of string = ('UNTYPE', 'RC4_SHA1', 'RC4_SHA256',
    'RC4_SHA512');

function GetKey: AnsiString;
function CheckHash(hash: AnsiString; l: integer): Boolean;
function DigestToTxt(Digest: Array of byte): AnsiString;
function GetMD5Hash(AStrData: AnsiString): AnsiString;
function GetTrashStr(Count: integer): AnsiString;
function GetAlgoType(StrAlgo: String): TAlgoType;
function GetSignature(Sign: String; PSign: PSignature): Boolean;
function EncryptRC4_SHA1(AKey, AStrValue: AnsiString): AnsiString;
function EncryptRC4_SHA256(AKey, AStrValue: AnsiString): AnsiString;
function EncryptRC4_SHA512(AKey, AStrValue: AnsiString): AnsiString;
function DecryptRC4_SHA1(AKey, AStrValue: AnsiString): AnsiString;
function DecryptRC4_SHA256(AKey, AStrValue: AnsiString): AnsiString;
function DecryptRC4_SHA512(AKey, AStrValue: AnsiString): AnsiString;

implementation

function GetKey: AnsiString;
var
  VolumeSN: String;
  WinUserName: String;
  ComputerName: String;
begin
  VolumeSN := GetVolumeDriveSN(GetSystemDrive + '\');
  WinUserName := GetWinUserName;
  ComputerName := GetComputerNetName;
  Result := GetMD5Hash(AnsiLowerCase(WinUserName + ':' + ComputerName + ':' +
    VolumeSN));
end;

function CheckHash(hash: AnsiString; l: integer): Boolean;
var
  sh: set of AnsiChar;
  i: integer;
begin
  Result := false;
  sh := ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D',
    'E', 'F', 'a', 'b', 'c', 'd', 'e', 'f'];
  if Length(hash) <> l then
    Exit;
  for i := 1 to Length(hash) do
    if Not(hash[i] in sh) then
      Exit;
  Result := True;
end;

function DigestToTxt(Digest: Array of byte): AnsiString;
var
  i: integer;
begin
  for i := 0 to Length(Digest) - 1 do
    Result := Result + IntToHex(Digest[i], 2);
end;

function GetMD5Hash(AStrData: AnsiString): AnsiString;
var
  MD5: TDCP_md5;
  Digest: array [0 .. 15] of byte;
begin
  try
    MD5 := TDCP_md5.Create(Nil);
    MD5.Init;
    MD5.UpdateStr(AStrData);
    MD5.Final(Digest);
    Result := DigestToTxt(Digest);
  finally
    MD5.Free;
  end;
end;

function EncryptRC4_SHA1(AKey, AStrValue: AnsiString): AnsiString;
var
  RC4: TDCP_rc4;
begin
  try
    RC4 := TDCP_rc4.Create(Nil);
    RC4.InitStr(AKey, TDCP_sha1);
    Result := RC4.EncryptString(AStrValue);
  finally
    RC4.Free;
  end;
end;

function EncryptRC4_SHA256(AKey, AStrValue: AnsiString): AnsiString;
var
  RC4: TDCP_rc4;
begin
  try
    RC4 := TDCP_rc4.Create(Nil);
    RC4.InitStr(AKey, TDCP_sha1);
    Result := RC4.EncryptString(AStrValue);
  finally
    RC4.Free;
  end;
end;

function EncryptRC4_SHA512(AKey, AStrValue: AnsiString): AnsiString;
var
  RC4: TDCP_rc4;
begin
  try
    RC4 := TDCP_rc4.Create(Nil);
    RC4.InitStr(AKey, TDCP_sha1);
    Result := RC4.EncryptString(AStrValue);
  finally
    RC4.Free;
  end;
end;

function DecryptRC4_SHA1(AKey, AStrValue: AnsiString): AnsiString;
var
  RC4: TDCP_rc4;
begin
  try
    RC4 := TDCP_rc4.Create(Nil);
    RC4.InitStr(AKey, TDCP_sha1);
    Result := RC4.DecryptString(AStrValue);
  finally
    RC4.Free;
  end;
end;

function DecryptRC4_SHA256(AKey, AStrValue: AnsiString): AnsiString;
var
  RC4: TDCP_rc4;
begin
  try
    RC4 := TDCP_rc4.Create(Nil);
    RC4.InitStr(AKey, TDCP_sha256);
    Result := RC4.DecryptString(AStrValue);
  finally
    RC4.Free;
  end;
end;

function DecryptRC4_SHA512(AKey, AStrValue: AnsiString): AnsiString;
var
  RC4: TDCP_rc4;
begin
  try
    RC4 := TDCP_rc4.Create(Nil);
    RC4.InitStr(AKey, TDCP_sha512);
    Result := RC4.DecryptString(AStrValue);
  finally
    RC4.Free;
  end;
end;

function GetTrashStr(Count: integer): AnsiString;
var
  i: integer;
begin
  Randomize;
  for i := 1 to Count do
    Result := Result + AnsiChar(Chr(RandomRange(33, 126)))
end;

function GetAlgoType(StrAlgo: String): TAlgoType;
var
  i: ShortInt;
begin
  Result := UNTYPE;
  for i := 0 to Length(AlgoName) - 1 do
    if StrAlgo = AlgoName[TAlgoType(i)] then
    begin
      Result := TAlgoType(i);
      Exit;
    end;
end;

function GetSignature(Sign: String; PSign: PSignature): Boolean;
var
  st: TStrings;
begin
  Result := false;
  PSign.Checked := false;

  if Length(Sign) < SignMaxLength then
  begin
    Exit;
  end;

  if 'sign:' <> copy(Sign, 1, Length('sign:')) then
  begin
    Exit;
  end;

  try
    st := TStringList.Create;
    st.Text := StringReplace(Sign, ';', #13, [rfReplaceAll]);

    if st.Count < 4 then
    begin
      Exit;
    end;

    if CheckHash(st.Strings[1], 32) then
    begin
      PSign.hash_uncrypt := st.Strings[1];
    end
    else
      Exit;

    if CheckHash(st.Strings[2], 32) then
    begin
      PSign.hash_encrypt := st.Strings[2]
    end
    else
      Exit;

    if GetAlgoType(st.Strings[3]) <> UNTYPE then
    begin
      PSign.Algo := GetAlgoType(st.Strings[3]);
    end
    else
      Exit;

  finally
    st.Free;
  end;
  PSign.Checked := True;
  Result := True;
end;

end.
