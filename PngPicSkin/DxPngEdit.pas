{PNG�༭���ؼ�}
unit DxPngEdit;
{
  ��Դ������DxPngPicSkin��Ŀ����Ȩ�鲻����(QQ:75492895)���С�
  (1)ʹ����ɼ�����
  ���������ɸ��ơ��ַ����޸ı�Դ�룬�������޸�Ӧ�÷��������ߣ������������ڱ�Ҫʱ��
  �ϲ�������Ŀ���Թ�ʹ�ã��ϲ����Դ��ͬ����ѭDxPngPicSkin��Ȩ�������ơ�
  ���Ĳ�Ʒ�Ĺ����У�Ӧ�������µİ汾����:
  ����Ʒʹ�õ�����UI����DxPngPicSkin��Ŀ�У���Ȩ���������С�
  (2)������֧��
  �м������⣬��������ϵ���ߣ���ʱû�йٷ�Ⱥ����
  (3)������
  ����������ʹ�ñ�Դ�������Ҫ֧���κη��á���������ñ�Դ������а�������������
  ������Ŀ����ǿ�ƣ���
  ������ʽ��
  ֧������ 75492895@qq.com ��������ƽ
  (4)������
  ����Ʒ���õ���ë��ǰ����GDIPlus�ķ�װ�⡣��лë��ǰ����
}

{
 ����Ԫ��Ҫ��ʵ����һ��DirectUIģʽ�ı༭���ؼ������ܲ���̫ǿ����ǿ���ðѡ�
 �Ժ��ٸģ����Ż�
}
interface
uses Windows,Messages,SysUtils,Classes,vcl.Controls,DxPngFormUI,vcl.Graphics,DxTimer,pngimage2010;

type
  TTextSelection = record
    StartPos, EndPos: Integer;
  end;

  TTextChar = record
    Char: Char;
    Width: Integer;
  end;

  TTextChars = array of TTextChar;


  TDxEditSkin = class(TDxButtonSkin)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TDxCustomPngEdit = class(TDxPngUIControl)
  private
    FReadOnly: Boolean;
    FAutoSelect: Boolean;
    FMaxLength: Integer;
    FOnChange: TNotifyEvent;
    FSelection: TTextSelection;
    FSelectColor: TColor;
    FVirtualPosition: Integer;
    FSelectFontColor: TColor;
    LockChange: Boolean;
    IsMouseDown: Boolean;
    CursorUpdateTime: TDxTimer;
    DrawCursor: Boolean;
    FPassWordChar: Char;
    FMouseDownPng: TDxPngImage;
    FMouseMovePng: TDxPngImage;
    FNormalPng: TDxPngImage;
    IsMouseIn: Boolean;
    FSelectPng: TDxPngImage;
    FFrameColor: TColor;
    FCursorPng: TDxPngImage;
    procedure SetReadOnly(const Value: Boolean);
    procedure SetPassWordChar(const Value: Char);
    procedure SetMouseDownPng(const Value: TDxPngImage);
    procedure SetMouseMovePng(const Value: TDxPngImage);
    procedure SetNormalPng(const Value: TDxPngImage);
    procedure SetSelectPng(const Value: TDxPngImage);
    procedure SetFrameColor(const Value: TColor);
    procedure SetCursorPng(const Value: TDxPngImage);
  protected
    procedure Change; dynamic;
    procedure DoPicChange(Sender: TObject);
    function GetSelLength: Integer;virtual;
    function GetSelStart: Integer;virtual;
    function GetSelText: string;virtual;
    procedure SetMaxLength(const Value: Integer);virtual;
    procedure SetSelectColor(const Value: TColor);virtual;
    procedure SetSelLength(const Value: Integer);virtual;
    procedure SetSelStart(const Value: Integer);virtual;
    procedure SetSelText(const Value: string);virtual;
    procedure SetSelectFontColor(const Value: TColor);virtual;
    procedure SetText(value: string);
    procedure DoUpdateCursor(Sender: TObject);

    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMKillFocus(var msg: TWMKillFocus);message WM_KILLFOCUS;
    procedure WMSetFocus(var msg: TWMSetFocus);message WM_SETFOCUS;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Paint;override;
    procedure PaintUI(ToCanvas: TCanvas;DestRect: TRect);override;
    procedure HandKeyMsg(var Msg: TMessage);override;
    procedure SetParent(AParent: TWinControl);override;
    procedure SetPngUIEngine(Value: TDxFormPngUIEngine);override;
    procedure CMTextChange(var msg: TMessage);message CM_TEXTCHANGED;
    procedure CMWANTSPECIALKEY(var msg: TCMWantSpecialKey);message CM_WANTSPECIALKEY;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    property AutoSelect: Boolean read FAutoSelect write FAutoSelect default True;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  public
    property PassWordChar: Char read FPassWordChar write SetPassWordChar;
    constructor Create(AOwner: TComponent);override;
    destructor Destroy; override;
    procedure Invalidate;override;

    procedure Clear; virtual;
    procedure ClearSelection;

    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;
    procedure SelectAll;

    property Text;

    property FrameColor: TColor read FFrameColor write SetFrameColor default clBlue;
    property CursorPng: TDxPngImage read FCursorPng write SetCursorPng;
    property NormalPng: TDxPngImage read FNormalPng write SetNormalPng;
    property MouseDownPng: TDxPngImage read FMouseDownPng write SetMouseDownPng;
    property MouseMovePng: TDxPngImage read FMouseMovePng write SetMouseMovePng;
    property SelectPng: TDxPngImage read FSelectPng write SetSelectPng;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property MaxLength: Integer read FMaxLength write SetMaxLength;
    property SelectColor: TColor read FSelectColor write SetSelectColor default clHighlight;
    property SelectFontColor: TColor read FSelectFontColor write SetSelectFontColor default clWhite;
    property SelLength: Integer read GetSelLength write SetSelLength;
    property SelStart: Integer read GetSelStart write SetSelStart;
    property SelText: string read GetSelText write SetSelText;
  end;

  TDxPngEdit = class(TDxCustomPngEdit)
  published
    property FrameColor;
    property PassWordChar;
    property Text;
    property Font;
    property SelectPng;
    property CursorPng;
    property MouseDownPng;
    property MouseMovePng;
    property NormalPng;
    property ReadOnly;
    property MaxLength;
    property SelectColor;
    property SelectFontColor;
    property OnChange;
    property AutoSelect;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property IngoreAlpha default True;
  end;
implementation
uses vcl.Clipbrd,Math;

{ TDxCustomPngEdit }

procedure TDxCustomPngEdit.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TDxCustomPngEdit.Clear;
begin
  Text := '';
end;

procedure TDxCustomPngEdit.ClearSelection;
begin

end;

procedure TDxCustomPngEdit.CMMouseEnter(var Message: TMessage);
begin
  IsMouseIn := True;
  inherited;
end;

procedure TDxCustomPngEdit.CMMouseLeave(var Message: TMessage);
begin
  IsMouseIn := False;
  ClearSelection;
  inherited;
end;

procedure TDxCustomPngEdit.CMTextChange(var msg: TMessage);
begin
  inherited;
  if not LockChange then
  begin
    SetText(Text);
    Invalidate;
  end;
end;

procedure TDxCustomPngEdit.CMWANTSPECIALKEY(var msg: TCMWantSpecialKey);
begin
  if msg.CharCode in [VK_LEFT..VK_RIGHT] then
    Msg.Result := 1;
end;

procedure TDxCustomPngEdit.CopyToClipboard;
begin
  Clipboard.SetTextBuf(PChar(Self.SelText));
end;

constructor TDxCustomPngEdit.Create(AOwner: TComponent);
begin
  inherited;
  IngoreAlpha := True;
  FFrameColor := clBlue;
  ControlStyle := ControlStyle + [csClickEvents];
  IsMouseDown := False;
  IsMouseIn := False;
  FPassWordChar := #0;
  DrawCursor := True;
  CursorUpdateTime := TDxTimer.Create(Self);
  CursorUpdateTime.Interval := 400;
  CursorUpdateTime.OnTimer := DoUpdateCursor;
  FMouseDownPng := TDxPngImage.Create;
  FMouseMovePng := TDxPngImage.Create;
  FNormalPng := TDxPngImage.Create;
  FSelectPng := TDxPngImage.Create;
  FCursorPng := TDxPngImage.Create;

  FMouseDownPng.OnChange := DoPicChange;
  FCursorPng.OnChange := DoPicChange;
  FMouseMovePng.OnChange := DoPicChange;
  FNormalPng.OnChange := DoPicChange;
  FSelectPng.OnChange := DoPicChange;

  CursorUpdateTime.Enabled := False;
  FSelectColor := clHighlight;
  FSelectFontColor := clWhite;
  Cursor := crIBeam;
  Left := 0;
  Top := 0;
  Width := 120;
  Height := 21;
end;

procedure TDxCustomPngEdit.CutToClipboard;
var
  AText: String;
  AMin, AMax, ALength: Integer;
begin
  // Set initial values
  AText := Text;
  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);

  ALength := AMax - AMin;

  // Copy to Clipboard
  CopyToClipboard;

  Delete(AText, AMin + 1, ALength);
  Text := AText;
  // Execute OnChange Event
  Change;

  FSelection.StartPos := AMin;
  FSelection.EndPos := AMin;
  Invalidate;
end;

destructor TDxCustomPngEdit.Destroy;
begin
  FMouseDownPng.Free;
  FMouseMovePng.Free;
  FNormalPng.Free;
  FSelectPng.Free;
  FCursorPng.Free;
  CursorUpdateTime.Free;
  inherited;
end;

procedure TDxCustomPngEdit.DoPicChange(Sender: TObject);
begin
  Invalidate
end;

procedure TDxCustomPngEdit.DoUpdateCursor(Sender: TObject);
var
  index,CursorPosX: Integer;
  r: TRect;
begin
  CursorPosX := 4;
  if FPassWordChar = #0 then
  for Index := 0 to Length(Text) - 1 do
  begin
    if FSelection.EndPos > Index then
      //��ù���λ��
      Inc(CursorPosX,Canvas.TextWidth(Text[index + 1]))
    else Break;
  end
  else
  begin
    r.Left := Canvas.TextWidth(FPassWordChar);
    for Index := 0 to Length(Text) - 1 do
    begin
      if FSelection.EndPos > Index then
        //��ù���λ��
        Inc(CursorPosX,r.Left)
      else Break;
    end
  end;
  r := Rect(CursorPosX,0,CursorPosX + 3,Height);
  OffsetRect(r,Left,top);
  DrawCursor := not DrawCursor;
  if PngUIEngine <> nil then
    Invalidate
  else InvalidateRect(Parent.Handle,r,True);
end;

function TDxCustomPngEdit.GetSelLength: Integer;
var
  AMin, AMax: Integer;
begin
  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);
  Result := AMax - AMin;
end;

function TDxCustomPngEdit.GetSelStart: Integer;
var
  AMin: Integer;
begin
  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  Result := AMin;
end;

function TDxCustomPngEdit.GetSelText: string;
var
  AMin, AMax, ALength: Integer;
begin
  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);
  ALength := AMax - AMin;
  Result := Copy(Text, AMin + 1, ALength);
end;

procedure TDxCustomPngEdit.HandKeyMsg(var Msg: TMessage);
begin
    case msg.Msg of
  CM_DIALOGCHAR:
    begin
      //��������
    end
  else inherited;
  end;

end;

procedure TDxCustomPngEdit.Invalidate;
begin
  if (PngUIEngine <> nil) and not (csDesigning in ComponentState) then
    PngUIEngine.UpdateLayered
  else inherited Invalidate;
end;

procedure TDxCustomPngEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
  AText: String;
  AMin, AMax, ALength: Integer;
  OldP: TTextSelection;
begin
  AText := Text;
  OldP.StartPos := FSelection.StartPos;
  OldP.EndPos := FSelection.EndPos;
  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);
  ALength := AMax - AMin;
  if Shift = [ssShift] then
  begin  //ѡ����
    case Key of
    vk_Right:
      begin
        if FSelection.EndPos < Length(Text) then
          Inc(FSelection.EndPos);
      end;
    vk_Left:
      begin
        if FSelection.EndPos > 0 then
          Dec(FSelection.EndPos);
      end;
  VK_Home:
      begin
        FSelection.EndPos := 0;
      end;
  VK_End:
      begin
        FSelection.EndPos := Length(Text);
      end;
    end;
  end
  else
  begin
    case Key of
    vk_Left:
      begin
        if FSelection.StartPos = FSelection.EndPos then
        begin
          if FSelection.StartPos > 0 then
          begin
            Dec(FSelection.StartPos);
            FSelection.EndPos := FSelection.StartPos;
          end;
        end
        else if FSelection.StartPos > FSelection.EndPos then
        begin
          FSelection.StartPos := FSelection.EndPos;
        end
        else if FSelection.StartPos < FSelection.EndPos then
        begin
          FSelection.EndPos := FSelection.StartPos;
        end;
      end;
    vk_Right:
      begin
        if FSelection.StartPos = FSelection.EndPos then
        begin
          if FSelection.EndPos < Length(Text) then
          begin
            Inc(FSelection.EndPos);
            FSelection.StartPos := FSelection.EndPos;
          end;
        end
        else if FSelection.StartPos > FSelection.EndPos then
        begin
          FSelection.EndPos := FSelection.StartPos;
        end
        else if FSelection.StartPos < FSelection.EndPos then
        begin
          FSelection.StartPos := FSelection.EndPos;
        end;
      end;
    vk_Back,vk_Delete:
      if not ReadOnly then
      begin
        if ALength > 0 then
        begin
          case Key of
            vk_Back:
              Delete(AText, AMin + 1, ALength);
            vk_Delete:
              Delete(AText, AMin + 1, ALength);
          end;
        end
        else
        begin
          case Key of
            vk_Back:
              begin
                Delete(AText, AMin, 1);
                if AMin > 0 then
                  Dec(AMin);
              end;
            vk_Delete:
              Delete(AText, AMin + 1, 1);
          end;
        end;
        Text := AText;
        Change;
        FSelection.StartPos := AMin;
        FSelection.EndPos := AMin;
      end;
    VK_Home:
      begin
        FSelection.StartPos := 0;
        FSelection.EndPos := 0;
      end;
    VK_End:
      begin
        FSelection.StartPos := Length(Text);
        FSelection.EndPos := Length(Text);
      end;
    end;
  end;
  //Tic := 0;
  if (OldP.StartPos <> FSelection.StartPos) or (OldP.EndPos <> FSelection.EndPos) then
    Invalidate;
  inherited;
end;

procedure TDxCustomPngEdit.KeyPress(var Key: Char);
var
  AText: String;
  AMin, AMax, ALength: Integer;
begin
  AText := Text;
  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);
  ALength := AMax - AMin;
  //����
  if (Key > #31) and not ReadOnly then
  begin
    Delete(AText, AMin + 1, ALength);

    Inc(AMin);
    Insert(Key, AText, AMin);
    Text := AText;
    Change;
    if AMin > Length(Text) then
      AMin := Length(Text);
    FSelection.StartPos := AMin;
    FSelection.EndPos := AMin;
  end;
  // Copy to Clipboard
  if (Key = #3) and (FPassWordChar = #0) then
    CopyToClipboard;

  // Paste from Clipboard
  if Key = #22 then
    PasteFromClipboard;

  // Cut to Clipboard
  if (Key = #24) and (FPassWordChar = #0) then
    CutToClipboard;

  inherited;
end;

procedure TDxCustomPngEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TDxCustomPngEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Index, XPos, AVirtualCursor: Integer;
  AChars: TTextChars;
  IsHasSelect: Boolean;
  CursorPosX: Integer;
  r: TRect;
begin
  IsMouseDown := Button = mbLeft;
  Index := 0;
  CursorPosX := 4;
  SetLength(AChars, Length(Text) + 1);
  if FPassWordChar = #0 then
  begin
    while Index < Length(Text) do
    begin
      AChars[Index].Char  := Text[Index + 1];
      AChars[Index].Width := Canvas.TextWidth(Text[Index + 1]);
      if FSelection.EndPos > Index then
        //��ù���λ��
        Inc(CursorPosX,AChars[Index].Width);
      //AChars[Index].Width := Round(ZFont.GetTextLength(0,Text[Index + 1],1,1) + ZFont.Spacing);
      Inc(Index);
    end;
  end
  else
  begin
    AChars[0].Width := Canvas.TextWidth(FPassWordChar);
    while Index < Length(Text) do
    begin
      AChars[Index].Char  := Text[Index + 1];
      AChars[Index].Width := AChars[0].Width;
      if FSelection.EndPos > Index then
        //��ù���λ��
        Inc(CursorPosX,AChars[Index].Width);
      Inc(Index);
    end;
  end;
  IsHasSelect := FSelection.StartPos <> FSelection.EndPos;

  // Set position to 0
  FSelection.StartPos := 0;
  FSelection.EndPos := 0;
  if IsHasSelect then
    Invalidate
  else
  begin
    //���λ��ˢ��
    r := Rect(CursorPosX,0,CursorPosX + 3,Height);
    OffsetRect(r,Left,top);
    InvalidateRect(Parent.Handle,r,True);
  end;

  // Get virtual Bounds
  //XPos := Left + BorderWidth + Margin + FVirtualPosition;
  XPos := 4 + FVirtualPosition;

  // Set virtual Pos
  AVirtualCursor := XPos;
  for Index := 0 to High(AChars) do
  begin
    if (X > AVirtualCursor) and (X <= AVirtualCursor + AChars[Index].Width)
      then
    begin
      if Index < Length(Text) then
      begin
        FSelection.StartPos := Index + 1;
        FSelection.EndPos := Index + 1;
      end;
      Break;
    end;
    AVirtualCursor := AVirtualCursor + AChars[Index].Width;

    if (Index = High(AChars)) and (X >= AVirtualCursor) then
    begin
      FSelection.StartPos := Index;
      FSelection.EndPos := Index;
    end;
  end;
  inherited;
end;

procedure TDxCustomPngEdit.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Index, XPos, AVirtualCursor: Integer;
  AChars: TTextChars;
begin
  if IsMouseDown then
  begin
    // Get chars from text
    Index := 0;
    SetLength(AChars, Length(Text) + 1);
    if FPassWordChar = #0 then
    while Index < Length(Text) do
    begin
      AChars[Index].Char := Text[Index + 1];
      AChars[Index].Width := Canvas.TextWidth(Text[Index + 1]);
      Inc(Index);
    end
    else
    begin
      AChars[0].Width := Canvas.TextWidth(FPassWordChar);
      while Index < Length(Text) do
      begin
        AChars[Index].Char := Text[Index + 1];
        AChars[Index].Width := AChars[0].Width;
        Inc(Index);
      end
    end;

    // Set position to 0
    FSelection.EndPos := 0;

    // Get virtual Bounds
    // XPos := ClientLeft + BorderWidth + Margin + FVirtualPosition;
    XPos := 4 + FVirtualPosition;

    // Set virtual Pos
    AVirtualCursor := XPos;
    for Index := 0 to High(AChars) do
    begin
      if (X > AVirtualCursor) and (X <= AVirtualCursor + AChars[Index].Width) then
      begin
        if Index < Length(Text) then
        begin
          FSelection.EndPos := Index + 1;
        end;
        Break;
      end;
      AVirtualCursor := AVirtualCursor + AChars[Index].Width;

      if (Index = High(AChars)) and (X >= AVirtualCursor) then
      begin
        FSelection.EndPos := Index;
      end;
    end;
    Invalidate;
  end;

  inherited;
end;

procedure TDxCustomPngEdit.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  IsMouseDown := False;
end;

procedure TDxCustomPngEdit.Paint;
begin
  inherited;
end;

procedure TDxCustomPngEdit.PaintUI(ToCanvas: TCanvas; DestRect: TRect);
var
  Index, X, Y, AWidth, AVirtualCursor: Integer;
  AMin, AMax: Integer;
  AChars: TTextChars;
  r: TRect;
  st: string;
  tmpbmp: TBitmap;
  CursorPosX: Integer;
  Png: TDxPngImage;
  Skin: TDxUISkin;
begin
  Png := nil;
  if csDesigning in ComponentState then
  begin
    if not FNormalPng.Empty then
      Png := FNormalPng
    else if (PngUIEngine <> nil) and (PngUIEngine.UISkins <>  nil) then
    begin
      Skin := PngUIEngine.UISkins.GetSkin(self);
      if (Skin <> nil) and not TDxEditSkin(Skin).NormalPng.Empty then
        Png := TDxEditSkin(Skin).NormalPng;
    end;
  end
  else if IsMouseIn then
  begin
    if IsMouseDown then
    begin
      if not FMouseDownPng.Empty then
        Png := FMouseDownPng
      else if (PngUIEngine <> nil) and (PngUIEngine.UISkins <>  nil) then
      begin
        Skin := PngUIEngine.UISkins.GetSkin(self);
        if (Skin <> nil) and not TDxEditSkin(Skin).MouseDownPng.Empty then
          Png := TDxEditSkin(Skin).MouseDownPng;
      end;
    end
    else if not FMouseMovePng.Empty then
      Png := FMouseMovePng
    else if (PngUIEngine <> nil) and (PngUIEngine.UISkins <>  nil) then
    begin
      Skin := PngUIEngine.UISkins.GetSkin(self);
      if (Skin <> nil) and not TDxEditSkin(Skin).MouseMovePng.Empty then
        Png := TDxEditSkin(Skin).MouseMovePng;
    end;
  end
  else if not FNormalPng.Empty then
    Png := FNormalPng
  else if (PngUIEngine <> nil) and (PngUIEngine.UISkins <>  nil) then
  begin
    Skin := PngUIEngine.UISkins.GetSkin(self);
    if (Skin <> nil) and not TDxEditSkin(Skin).NormalPng.Empty then
      Png := TDxEditSkin(Skin).NormalPng;
  end;
  if Png <> nil then
    ToCanvas.Draw(DestRect.Left,DestRect.Top,Png)
  else
  begin
    ToCanvas.Brush.Color := FFrameColor;
    ToCanvas.FrameRect(DestRect);
  end;
  tmpbmp := TBitmap.Create;
  tmpbmp.SetSize(Width,Height);
  tmpbmp.Canvas.Font.Assign(Font);
  tmpbmp.Canvas.CopyRect(tmpbmp.Canvas.ClipRect,ToCanvas,DestRect);
  //��������
  //��������һ��һ���Ļ��Ʒ�ʽ
  Index := 0;
  SetLength(AChars, Length(Text) + 1);
  if FPassWordChar = #0 then
  while Index < Length(Text) do
  begin
    AChars[Index].Char  := Text[Index + 1];
    AChars[Index].Width := tmpbmp.Canvas.TextWidth(Text[Index + 1]);
    Inc(Index);
  end
  else
  begin
    AChars[0].Width := tmpbmp.Canvas.TextWidth(FPassWordChar);
    while Index < Length(Text) do
    begin
      AChars[Index].Char  := Text[Index + 1];
      AChars[Index].Width := AChars[0].Width;
      Inc(Index);
    end
  end;
  //�������ֿ�ʼ���Ƶ�λ��
  AVirtualCursor := 0;
  FVirtualPosition := 0;
  X := 4; //Left + ��ʼλ��Margin
  y := tmpbmp.Canvas.TextHeight('yY');//���߶�
  AWidth := Width - 6; //��ȥ�������߼��
  for Index := 0 to FSelection.EndPos - 1 do
  begin
    AVirtualCursor := AVirtualCursor + AChars[Index].Width;
  end;
  if AVirtualCursor > AWidth then
  begin
    FVirtualPosition := AWidth - AVirtualCursor;
    X := X + FVirtualPosition;
  end;

  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);
  CursorPosX := X;

  for Index := 0 to High(AChars) do
  begin
    if FSelection.EndPos > Index then
    begin
      //��ù���λ��
      Inc(CursorPosX,AChars[Index].Width);
    end;
    //����ѡ��
    if (AMin < AMax) and Focused then
    begin
       if (Index >= AMin) and (Index < AMax) then
       begin
         if not FSelectPng.Empty then
         begin
           FSelectPng.DrawToDest(tmpbmp.Canvas.Handle,
               Rect(0,0,AChars[Index].Width,(Height - y)div 2),
               Rect(x,y,x + AChars[Index].Width,y + (Height - y)div 2));
         end
         else
         begin
           tmpbmp.Canvas.Brush.Color := FSelectColor;
           tmpbmp.Canvas.Brush.Style := bsSolid;
           tmpbmp.Canvas.FillRect(Rect(x,y,x + AChars[Index].Width,y + (Height - y)div 2));
         end;
       end
       else tmpbmp.Canvas.Brush.Style := bsClear;
       tmpbmp.Canvas.Font.Color := FSelectFontColor;
    end
    else tmpbmp.Canvas.Brush.Style := bsClear;

    if Focused and (AMin < AMax)and (Index < AMax) then
    begin
      if (Index >= AMin) and (Index < AMax) then
        tmpbmp.Canvas.Font.Color := FSelectFontColor
      else tmpbmp.Canvas.Font.Color := Font.Color;
    end
    else tmpbmp.Canvas.Font.Color := Font.Color;

    r.Left := x;
    r.Right := r.Left + AChars[index].Width;
    r.Top := 1;
    r.Bottom := Height - 1;
    if FPassWordChar = #0 then
      st := AChars[Index].Char
    else st := FPassWordChar;
    if AChars[Index].Char <> '' then
      DrawText(tmpbmp.Canvas.Handle,PChar(st),-1,r,DT_LEFT or DT_SINGLELINE or DT_VCENTER);
    x := r.Right;
  end;

  r.Left := 4;
  r.Top := 1;
  r.Bottom := Height - 1;
  r.Right := Width - 6;
  ToCanvas.CopyRect(Rect(DestRect.Left + 4,DestRect.Top + 1,DestRect.Right - 6,DestRect.Bottom - 1),tmpbmp.Canvas,r);
  tmpbmp.Free;

  if Focused then
  begin
    //���ƹ��
    if DrawCursor then
    begin
      if CursorPosX > DestRect.Right - 6 then
        CursorPosX := DestRect.Right - 5;
      if FCursorPng.Empty then
      begin
        ToCanvas.Pen.Color := FFrameColor;
        ToCanvas.MoveTo(CursorPosX + DestRect.Left ,DestRect.Top + (Height - Y) div 2);
        Y := DestRect.Top + (Height - Y) div 2 + y;
        ToCanvas.LineTo(CursorPosX+ DestRect.Left,y);
      end
      else
      begin
        r.Left := 0;
        r.Top := (Height - Y) div 2;
        r.Right := 2;
        r.Bottom := r.Top + y;
        FCursorPng.DrawToDest(ToCanvas.Handle,
          r,Rect(CursorPosX + DestRect.Left,DestRect.Top + (Height - Y) div 2,CursorPosX + DestRect.Left + 1,
            DestRect.Top + (Height - Y) div 2 + y));
      end;
    end;
  end;
end;

procedure TDxCustomPngEdit.PasteFromClipboard;
var
  AText, CText: String;
  AMin, AMax, ALength: Integer;
begin
  AText := Text;

  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);

  ALength := AMax - AMin;

  Delete(AText, AMin + 1, ALength);
  CText := Clipboard.AsText;

  Inc(AMin);
  Insert(CText, AText, AMin);

  Text := AText;
  // Execute OnChange Event
  Change;

  Inc(AMin, Length(CText));

  if AMin > Length(Text) then
    AMin := Length(Text);

  FSelection.StartPos := AMin;
  FSelection.EndPos := AMin;
  Invalidate;
end;

procedure TDxCustomPngEdit.SelectAll;
begin
  if Enabled then
  begin
    FSelection.StartPos := 0;
    FSelection.EndPos := Length(Text);
    Invalidate;
  end;
end;

procedure TDxCustomPngEdit.SetCursorPng(const Value: TDxPngImage);
begin
  FCursorPng.Assign(Value);
end;

procedure TDxCustomPngEdit.SetFrameColor(const Value: TColor);
begin
  if FFrameColor <> Value then
  begin
    FFrameColor := Value;
    Invalidate;
  end;
end;

procedure TDxCustomPngEdit.SetMaxLength(const Value: Integer);
begin
  if FMaxLength <> Value then
  begin
    FMaxLength := Value;
    LockChange := True;
    if (Value < Length(Text)) and (Value > 0) then
    begin
      Text := Copy(Text, 0, Value);
    end;
    LockChange := False;
  end;
end;

procedure TDxCustomPngEdit.SetMouseDownPng(const Value: TDxPngImage);
begin
  FMouseDownPng.Assign(Value);
end;

procedure TDxCustomPngEdit.SetMouseMovePng(const Value: TDxPngImage);
begin
  FMouseMovePng.Assign(Value);
end;

procedure TDxCustomPngEdit.SetNormalPng(const Value: TDxPngImage);
begin
  FNormalPng.Assign(Value);
end;

procedure TDxCustomPngEdit.SetParent(AParent: TWinControl);
begin
  inherited;

end;

procedure TDxCustomPngEdit.SetPassWordChar(const Value: Char);
begin
  if FPassWordChar <> Value then
  begin
    FPassWordChar := Value;
    Invalidate;
  end;
end;

procedure TDxCustomPngEdit.SetPngUIEngine(Value: TDxFormPngUIEngine);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    CursorUpdateTime.Enabled := PngUIEngine <> nil;
end;

procedure TDxCustomPngEdit.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
end;

procedure TDxCustomPngEdit.SetSelectColor(const Value: TColor);
begin
  FSelectColor := Value;
end;

procedure TDxCustomPngEdit.SetSelectFontColor(const Value: TColor);
begin
  FSelectFontColor := Value;
end;

procedure TDxCustomPngEdit.SetSelectPng(const Value: TDxPngImage);
begin
  FSelectPng.Assign(Value);
end;

procedure TDxCustomPngEdit.SetSelLength(const Value: Integer);
begin
  FSelection.EndPos := FSelection.StartPos + Value;

  if FSelection.EndPos > Length(Text) then
    FSelection.EndPos := Length(Text);

  if FSelection.EndPos < 0 then
    FSelection.EndPos := 0;
end;

procedure TDxCustomPngEdit.SetSelStart(const Value: Integer);
begin
  if not((Value < 0) and (Value > Length(Text))) then
  begin
    FSelection.StartPos := Value;
    FSelection.EndPos := Value;
  end;
end;

procedure TDxCustomPngEdit.SetSelText(const Value: string);
var
  AText: String;
  AMin, AMax, ALength: Integer;
begin
  AText := Text;

  AMin := Min(FSelection.StartPos, FSelection.EndPos);
  AMax := Max(FSelection.StartPos, FSelection.EndPos);

  ALength := AMax - AMin;

  // Insert Key
  Delete(AText, AMin + 1, ALength);

  Inc(AMin);
  Insert(Value, AText, AMin);

  Text := AText;
  Change;

  if AMin > Length(Text) then
    AMin := Length(Text);

  FSelection.StartPos := AMin;
  FSelection.EndPos := AMin + Length(Value);
end;

procedure TDxCustomPngEdit.SetText(value: string);
begin
  if (FMaxLength < Length(Value)) and (FMaxLength > 0) then
  begin
    Value := Copy(Value, 0, FMaxLength);
  end;
  LockChange := true;
  Text := value;
  LockChange := False;
end;

procedure TDxCustomPngEdit.WMKillFocus(var msg: TWMKillFocus);
begin
  inherited;
  DrawCursor := False;
  CursorUpdateTime.Enabled := False;

  Invalidate;
end;

procedure TDxCustomPngEdit.WMSetFocus(var msg: TWMSetFocus);
begin
  inherited;
  DrawCursor := True;
  CursorUpdateTime.Enabled := True;
  Invalidate;
end;

{ TDxEditSkin }

constructor TDxEditSkin.Create(AOwner: TComponent);
begin
  inherited;
  FUIControlClass := 'TDxPngEdit'
end;

end.
