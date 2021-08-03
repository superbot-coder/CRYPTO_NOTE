unit FindFilesMask;

interface

Uses Windows,SysUtils,Classes, masks;

Function findfilesMsk(Startfolder: string; Var MaskList, list: TStrings; ScanSubFolders: Boolean): Boolean;

implementation

Function findfilesMsk(Startfolder: string; Var MaskList, list: TStrings; ScanSubFolders: Boolean): Boolean;
var
  SR: TSearchRec;
  i: integer;
begin
  StartFolder := IncludeTrailingBackslash(StartFolder);
  try
    if True then

    if FindFirst(Startfolder+'*.*',$3f,SR) = 0 then
    Repeat

      if (SR.Attr and faDirectory) <> 0 then
      begin
        if ScanSubFolders and (SR.Name <> '.') and (SR.Name <> '..') then
          findfilesMsk(StartFolder + SR.Name, MaskList, List, ScanSubFolders);
      end
        else
      begin
        for i := 0 to MaskList.Count-1 do
        begin
          if MatchesMask(SR.Name, MaskList[i]) then List.Add(StartFolder + SR.Name);
        end;
      end;

    until FindNext(SR) <> 0;
    Result:=True;
  finally
    FindClose(SR);
  end;
end;

end.
