unit UFindFiles;

interface

Uses
  Windows,SysUtils,Classes,ComCtrls,Forms, masks;

procedure FindFilesMsk(StartFolder, Mask: string; Var ListOut: TStrings; AddStartFolder, ScanSubFolders: Boolean);
procedure FindFilesMskTV(StartFolder, Mask: string; Var TNParent: TTreeNode;  Var TV: TTreeView; ScanSubFolders: Boolean);

implementation

procedure FindFilesMsk(StartFolder,  Mask: string; Var ListOut: TStrings; AddStartFolder, ScanSubFolders: Boolean);
var
  SR: TSearchRec;
  MaskStrings: TStrings;
  i: integer;
begin
  StartFolder := IncludeTrailingBackslash(StartFolder);
  try
    MaskStrings := TStringList.Create;
    if Mask = '' then MaskStrings.Add('*.*')
    else MaskStrings.Text := StringReplace(Mask,'|',#13,[rfReplaceAll,rfIgnoreCase]);

    if FindFirst(Startfolder+'*.*',$3f,SR) = 0 then
    Repeat
      Application.ProcessMessages;
      if (SR.Attr and faDirectory) <> 0 then
      begin
        if ScanSubFolders and (SR.Name <> '.') and (SR.Name <> '..') then
          FindFilesMsk(StartFolder + SR.Name, Mask, ListOut, AddStartFolder, ScanSubFolders);
      end
        else
      begin
        for i := 0 to MaskStrings.Count-1 do
        begin
          if MatchesMask(SR.Name, MaskStrings[i]) then
            if  AddStartFolder then ListOut.Add(StartFolder + SR.Name)
            else ListOut.Add(SR.Name);
        end;
      end;

    until FindNext(SR) <> 0;
    //Result:=True;
  finally
    MaskStrings.Free;
    FindClose(SR);
  end;
end;

procedure FindFilesMskTV(StartFolder,  Mask: string; Var TNParent: TTreeNode; Var TV: TTreeView; ScanSubFolders: Boolean);
var
  SR: TSearchRec;
  MaskStrings: TStrings;
  i: integer;
  TN: TTreeNode;
begin
  StartFolder := IncludeTrailingBackslash(StartFolder);
  try
    MaskStrings := TStringList.Create;
    if Mask = '' then MaskStrings.Add('*.*')
    else MaskStrings.Text := StringReplace(Mask,'|',#13,[rfReplaceAll,rfIgnoreCase]);

    if FindFirst(Startfolder+'*.*',$3f,SR) = 0 then
    Repeat

      Application.ProcessMessages;
      if (SR.Attr and faDirectory) <> 0 then
      begin
        if ScanSubFolders and (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          TN := TV.Items.Add(TNParent, SR.Name);
          FindFilesMskTV(StartFolder + SR.Name, Mask, TN, TV, ScanSubFolders);
        end;
      end
        else
      begin
        for i := 0 to MaskStrings.Count-1 do
        begin
          if MatchesMask(SR.Name, MaskStrings[i]) then
          begin
            if TV.Items.Count > 0 then
            TN := TV.Items.Add(TV.Items[TV.Items.Count-1], SR.Name)
            else   TN := TV.Items.Add(Nil, SR.Name);
          end;
        end;
      end;

    until FindNext(SR) <> 0;
  finally
    MaskStrings.Free;
    FindClose(SR);
  end;
end;

end.
