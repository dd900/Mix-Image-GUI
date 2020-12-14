#SingleInstance, Force
#Include .\lib\Gdip_All.ahk
SetBatchLines, -1
DetectHiddenWindows, On

pToken := Gdip_Startup()
Mix_Bitmap_Created := 0
Defaults_INI := A_ScriptDir "\Mix Image GUI.ini"

Gui, New, -DPIScale +HwndGui_Hwnd +LabelGui_, Mix Image GUI
Gui, %Gui_Hwnd%:Add, Text, x12 y9 w100 h20 , Screenshot
Gui, %Gui_Hwnd%:Add, Edit, x12 y29 w390 h20 vScreenshot_File
Gui, %Gui_Hwnd%:Add, Button, x412 y29 w70 h20 vScreenshot_Bttn gGui_Browse, Browse
Gui, %Gui_Hwnd%:Add, Text, x12 y69 w100 h20 , Box
Gui, %Gui_Hwnd%:Add, Edit, x12 y89 w390 h20 vBox_File
Gui, %Gui_Hwnd%:Add, Button, x412 y89 w70 h20 vBox_Bttn gGui_Browse, Browse
Gui, %Gui_Hwnd%:Add, Text, x12 y129 w100 h20 , Logo
Gui, %Gui_Hwnd%:Add, Edit, x12 y149 w390 h20 vLogo_File
Gui, %Gui_Hwnd%:Add, Button, x412 y149 w70 h20 vLogo_Bttn gGui_Browse, Browse
Gui, %Gui_Hwnd%:Add, Text, x12 y189 w100 h20 , Cart/Disc
Gui, %Gui_Hwnd%:Add, Edit, x12 y209 w390 h20 vCart_File
Gui, %Gui_Hwnd%:Add, Button, x412 y209 w70 h20 vCart_Bttn gGui_Browse, Browse
Gui, %Gui_Hwnd%:Add, Text, x12 y249 w100 h20 , Out File
Gui, %Gui_Hwnd%:Add, Edit, x12 y269 w390 h20 vOut_File
Gui, %Gui_Hwnd%:Add, Button, x412 y269 w70 h20 vOut_Bttn gGui_Browse, Browse

Gui, %Gui_Hwnd%:Add, GroupBox, x12 y309 w260 h70 , Image
Gui, %Gui_Hwnd%:Add, Text, x22 y329 w60 h20 , Width
Gui, %Gui_Hwnd%:Add, Edit, x22 y349 w60 h20 +HwndImage_Width_Hwnd vImage_Width, % GetDefaults("Image_Width", 800)
Gui, %Gui_Hwnd%:Add, Text, x112 y329 w60 h20 , Height
Gui, %Gui_Hwnd%:Add, Edit, x112 y349 w60 h20 +HwndImage_Height_Hwnd vImage_Height, % GetDefaults("Image_Height", 600)
Gui, %Gui_Hwnd%:Add, Text, x202 y329 w60 h20 , Padding
Gui, %Gui_Hwnd%:Add, Edit, x202 y349 w60 h20 +HwndImage_Padding_Hwnd vImage_Padding, % GetDefaults("Image_Padding", 6)

Gui, %Gui_Hwnd%:Add, GroupBox, x292 y309 w80 h70 , Box
Gui, %Gui_Hwnd%:Add, Text, x302 y329 w60 h20 , Height
Gui, %Gui_Hwnd%:Add, Edit, x302 y349 w60 h20 +HwndBox_Height_Hwnd vBox_Height, % GetDefaults("Box_Height", 320)

Gui, %Gui_Hwnd%:Add, GroupBox, x12 y389 w260 h70 , Cart
Gui, %Gui_Hwnd%:Add, Text, x22 y409 w60 h20 , Height
Gui, %Gui_Hwnd%:Add, Edit, x22 y429 w60 h20 +HwndCart_Height_Hwnd vCart_Height, % GetDefaults("Cart_Height", 120)
Gui, %Gui_Hwnd%:Add, Text, x112 y409 w60 h20 , X Position
Gui, %Gui_Hwnd%:Add, Edit, x112 y429 w60 h20 +HwndCart_X_Hwnd vCart_X, % GetDefaults("Cart_X", 154)
Gui, %Gui_Hwnd%:Add, Text, x202 y409 w60 h20 , Padding
Gui, %Gui_Hwnd%:Add, Edit, x202 y429 w60 h20 +HwndCart_Padding_Hwnd vCart_Padding, % GetDefaults("Cart_Padding", 30)

Gui, %Gui_Hwnd%:Add, GroupBox, x292 y389 w170 h70 , Screenshot
Gui, %Gui_Hwnd%:Add, Text, x302 y409 w60 h20 , Max Width
Gui, %Gui_Hwnd%:Add, Edit, x302 y429 w60 h20 +HwndScreenshot_MaxWidth_Hwnd vScreenshot_MaxWidth, % GetDefaults("Screenshot_MaxWidth", 720)
Gui, %Gui_Hwnd%:Add, Text, x392 y409 w60 h20 , Max Height
Gui, %Gui_Hwnd%:Add, Edit, x392 y429 w60 h20 +HwndScreenshot_MaxHeight_Hwnd vScreenshot_MaxHeight, % GetDefaults("Screenshot_MaxHeight", 560)

Gui, %Gui_Hwnd%:Add, GroupBox, x12 y469 w170 h70 , Logo
Gui, %Gui_Hwnd%:Add, Text, x22 y489 w60 h20 , Max Width
Gui, %Gui_Hwnd%:Add, Edit, x22 y509 w60 h20 +HwndLogo_MaxWidth_Hwnd vLogo_MaxWidth, % GetDefaults("Logo_MaxWidth", 400)
Gui, %Gui_Hwnd%:Add, Text, x112 y489 w60 h20 , Max Height
Gui, %Gui_Hwnd%:Add, Edit, x112 y509 w60 h20 +HwndLogo_MaxHeight_Hwnd vLogo_MaxHeight, % GetDefaults("Logo_MaxHeight", 240)

Gui, %Gui_Hwnd%:Add, GroupBox, x202 y469 w70 h70 , Preview
Gui, %Gui_Hwnd%:Add, Text, x212 y489 w50 h20 , BG Color
Gui, %Gui_Hwnd%:Add, Edit, x212 y509 w50 h20 vPreview_BG_Color, % GetDefaults("Preview_BG_Color", 999999)

Gui, %Gui_Hwnd%:Add, Button, x392 y486 w90 h40 +Disabled vSave_Bttn gGui_Save, Save
Gui, %Gui_Hwnd%:Add, Button, x282 y486 w90 h40 gGui_Preview, Preview

OnMessage(0x201, "WM_LBUTTONDOWN")
OnMessage(0x102,"WM_Char")
DigitOnlyHwndArray := [Image_Width_Hwnd, Image_Height_Hwnd, Image_Padding_Hwnd
					 , Cart_Height_Hwnd, Cart_X_Hwnd, Cart_Padding_Hwnd
					 , Box_Height_Hwnd, Screenshot_MaxWidth_Hwnd, Screenshot_MaxHeight_Hwnd
					 , Logo_MaxWidth_Hwnd, Logo_MaxHeight_Hwnd]
					 
Gui, %Gui_Hwnd%:Show
return

Gui_Close:
	Gdip_DeleteGraphics(Mix_G)
	Gdip_DisposeImage(Mix_Bitmap)
	Gdip_Shutdown(pToken)
	ExitApp

Gui_Browse:
	editControl := StrReplace(A_GuiControl, "_Bttn", "_File")
	fileType := StrSplit(A_GuiControl, "_")[1]
	
	if (fileType = "Out")
		GuiControl, %Gui_Hwnd%:, % editControl
			, % InStr(_file := SelectFile("Select Output Image", "PNG Image (*.png)", "S24"), ".png")
				? _file : _file = "" ? _file : _file ".png"
	else
		GuiControl, %Gui_Hwnd%:, % editControl, % SelectFile("Select " fileType " File", "Image Files (*.jpg; *.png)")
	
	return

Gui_Save:
	if (Out_File != "")
		Gdip_SaveBitmapToFile(Mix_Bitmap, Out_File)
	
	return
	
Gui_Preview:
	Gui, %Gui_Hwnd%:Submit, NoHide
	Cart_Exists := 0
	Logo_Exists := 0

	if (WinExist("ahk_id " Gui_Preview_Hwnd)) {
		Gui, %Gui_Preview_Hwnd%:Destroy
		GuiControl, %Gui_Hwnd%:Disable, Save_Bttn
	}
	
	if (!Screenshot_File || !FileExist(Screenshot_File) || !Box_File || !FileExist(Box_File))
		return
	
	if (Mix_Bitmap_Created)
		Gdip_GraphicsClear(Mix_G)
	
	if (!Mix_Bitmap_Created) {
		Mix_Bitmap := Gdip_CreateBitmap(Image_Width, Image_Height)
		Mix_G := Gdip_GraphicsFromImage(Mix_Bitmap, 7)
		Mix_Bitmap_Created := 1
	}
	
	Gui, New, -DPIScale -Caption +E0x80000 +AlwaysOnTop +ToolWindow +Owner%Gui_Hwnd% +HwndGui_Preview_Hwnd
	Gui, %Gui_Preview_Hwnd%:Show, NA
	hbm := CreateDIBSection(Image_Width, Image_Height)
	hdc := CreateCompatibleDC()
	obm := SelectObject(hdc, hbm)
	Preview_G := Gdip_GraphicsFromHDC(hdc)
	Gdip_SetInterpolationMode(Preview_G, 7)
	
	gosub, Screenshot_Location_And_Size
	gosub, Box_Location_And_Size
	
	if (Cart_File && FileExist(Cart_File))
		gosub, Cart_Location_And_Size
	
	if (Logo_File && FileExist(Logo_File))
		gosub, Logo_Location_And_Size
	
	pBrush := Gdip_BrushCreateSolid("0xff" Preview_BG_Color)
	Gdip_FillRectangle(Preview_G, pBrush, 0, 0, Image_Width, Image_Width)
	Gdip_DrawImage(Preview_G, Mix_Bitmap, 0, 0, Image_Width, Image_Height, 0, 0, Image_Width, Image_Height)
	UpdateLayeredWindow(Gui_Preview_Hwnd, hdc, 0, 0, Image_Width, Image_Height)
	SelectObject(hdc, obm)
	DeleteObject(hbm)
	DeleteDC(hdc)
	Gdip_DeleteBrush(pBrush)
	Gdip_DeleteGraphics(Preview_G)
	GuiControl, %Gui_Hwnd%:Enable, Save_Bttn
	return

Screenshot_Location_And_Size:
	Screenshot_Bitmap := Gdip_CreateBitmapFromFile(Screenshot_File)
	Screenshot_Size := GetImageDimensions(Screenshot_Bitmap)
	Screenshot_NewH := Screenshot_MaxHeight
	Screenshot_NewW := AspectResize(Screenshot_Size.W, Screenshot_Size.H, Screenshot_NewH)
	
	if (Screenshot_NewW > Screenshot_MaxWidth) {
		Screenshot_NewW := Screenshot_MaxWidth
		Screenshot_NewH := AspectResize(Screenshot_Size.W, Screenshot_Size.H,, Screenshot_NewW)
	}
	
	Screenshot_X := (Image_Width - Screenshot_NewW) / 2
	Gdip_DrawImage(Mix_G, Screenshot_Bitmap, Screenshot_X, 0, Screenshot_NewW, Screenshot_NewH, 0, 0, Screenshot_Size.W, Screenshot_Size.H)
	Gdip_DisposeImage(Screenshot_Bitmap)
	return
	
Box_Location_And_Size:		
	Box_Bitmap := Gdip_CreateBitmapFromFile(Box_File)
	Box_Size := GetImageDimensions(Box_Bitmap)
	Box_NewW := AspectResize(Box_Size.W, Box_Size.H, Box_Height)
	Box_X := Image_Padding
	Box_Y := (Image_Height - Box_Height) - Image_Padding
	Gdip_DrawImage(Mix_G, Box_Bitmap, Box_X, Box_Y, Box_NewW, Box_Height, 0, 0, Box_Size.W, Box_Size.H)
	Gdip_DisposeImage(Box_Bitmap)
	return

Cart_Location_And_Size:
	Cart_Bitmap := Gdip_CreateBitmapFromFile(Cart_File)
	Cart_Size := GetImageDimensions(Cart_Bitmap)
	Cart_NewW := AspectResize(Cart_Size.W, Cart_Size.H, Cart_Height)
	Cart_Y := (Image_Height - Cart_Height) - Cart_Padding
	Gdip_DrawImage(Mix_G, Cart_Bitmap, Cart_X, Cart_Y, Cart_NewW, Cart_Height, 0, 0, Cart_Size.W, Cart_Size.H)
	Gdip_DisposeImage(Cart_Bitmap)
	return

Logo_Location_And_Size:
	Logo_Bitmap := Gdip_CreateBitmapFromFile(Logo_File)
	Logo_Size := GetImageDimensions(Logo_Bitmap)
	Logo_NewW := Logo_MaxWidth
	Logo_NewH := AspectResize(Logo_Size.W, Logo_Size.H,, Logo_NewW)
	
	if (Logo_NewH > Logo_MaxHeight) {
		Logo_NewH := Logo_MaxHeight
		Logo_NewW := AspectResize(Logo_Size.W, Logo_Size.H, Logo_NewH)
	}
	
	Logo_X := (Image_Width - Logo_NewW) - Image_Padding
	Logo_Y := (Image_Height - Logo_NewH) - Image_Padding
	Gdip_DrawImage(Mix_G, Logo_Bitmap, Logo_X, Logo_Y, Logo_NewW, Logo_NewH, 0, 0, Logo_Size.W, Logo_Size.H)
	Gdip_DisposeImage(Logo_Bitmap)
	return


#If (WinExist("ahk_id " Gui_Preview_Hwnd))
Esc::
	Gui, %Gui_Preview_Hwnd%:Destroy
	GuiControl, %Gui_Hwnd%:Disable, Save_Bttn
	return
#If


GetImageDimensions(bitmap) {
	w := 0, h := 0
	Gdip_GetImageDimensions(bitmap, w, h)
	return {W: w, H: h}
}

AspectResize(ow, oh, nh := 0, nw := 0) {
	return nh ? (ow / oh) * nh : (nw ? (oh / ow) * nw : 0)
}

Arr_HasValue(arr, value) {
	match := 0
	
	for i, v in arr {
		if (v = value) {
			match := 1
			break
		}
	}
	
	return match
}

GetDefaults(key, def) {
	global Defaults_INI
	if (!FileExist(Defaults_INI) || !key)
		return def
	
	IniRead, out, % Defaults_INI, Defaults, % key, % def
	return (out = "" || out = "ERROR") ? def : out
}

SelectFile(prompt, filter, options := 1) {
	FileSelectFile, out, % options,, % prompt, % filter
	
	if (ErrorLevel)
		return ""
	
	return out
}

WM_Char(wP) {
	global DigitOnlyHwndArray

	GuiControlGet, fCtrl, Focus
	GuiControlGet, hCtrl, HWND, %fCtrl%
	
	if (!Arr_HasValue(DigitOnlyHwndArray, hCtrl))
		return
	
	if (wP = 8)
		return

	wP := Chr(wP)
	
	if wP is not digit
		return 0
}

WM_LBUTTONDOWN(wParam, lParam, msg, hwnd)
{
	global Gui_Preview_Hwnd
	
	if (hwnd != Gui_Preview_Hwnd)
		return
	
	PostMessage 0xA1, 2
}
