unit DxPicSkinReg;

interface
uses Windows,Classes,{$IFDEF VER130}DesignIntf{$ELSE}DesignIntf, DesignEditors{$ENDIF};


procedure register;
implementation
uses vcl.Dialogs,DxPngFormUI,DxPngEdit;

procedure register;
begin
  RegisterComponents('DxPngFormUI',[TDxFormPngUIEngine,TDxPngUIButton,TDxPngProgress,TDxPngLabel,TDxPngEdit,TDxPngFormControl,
    TDxUISkins,TDxButtonSkin,TDxEditSkin,TDxDropDownButton]);
end;

end.
