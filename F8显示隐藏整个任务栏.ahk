;F8显示隐藏整个任务栏
F8::
	VarSetCapacity( APPBARDATA, 36, 0 )
	IfWinNotExist, ahk_class Shell_TrayWnd
	{
		NumPut( (ABS_AlwaysOnTOP := 0x2), APPBARDATA, 32, "UInt" )           ;Enable "Always on top" (& disable auto-hide)
		DllCall( "Shell32.dll\SHAppBarMessage", "UInt", ( ABM_SETSTATE := 0xA ), "UInt", &APPBARDATA )
		WinShow ahk_class Shell_TrayWnd
	}
	else
	{
		NumPut( ( ABS_AUTOHIDE := 0x1 ), APPBARDATA, 32, "UInt" )            ;Disable "Always on top" (& enable auto-hide to hide Start button)
		DllCall( "Shell32.dll\SHAppBarMessage", "UInt", ( ABM_SETSTATE := 0xA ), "UInt", &APPBARDATA )
		WinHide ahk_class Shell_TrayWnd
	}

return
