#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

!y::
Gui, +Resize
Gui, Add, Button, x10 y10 w100 h20, 选择源文件夹
Gui, Add, Button, x10 y35 w100 h20, 选择目标文件
Gui, Add, Edit, x115 y10 w330 h20 -Multi vMEdit1
Gui, Add, Edit, x115 y35 w330 h20 -Multi vMEdit2
Gui, Add, Radio, x20 y65 w40 h20 v复制 checked,复制
Gui, Add, Radio, x70 y65 w40 h20 v剪切,剪切
Gui, Add, Checkbox, x120 y65 w70 h20 v源目录 checked, 源目录
Gui, Add, Button, x185 y65 w55 h20 hwndIcon4 g执行, 执行
Gui, Add, Button, x255 y65 w35 h20, 退出
Gui, Add, Text, x310 y68 w120 h20, 作者：zhanglei1371
Gui, Show ;, Center w434 h137, New GUI Window
GuiButtonIcon(Icon4, "shell32.dll", 131, "s16 a0 l5")
OnMessage(0x200, "WM_MOUSEMOVE")
MEdit1_TT:="这个是复制的源目录"
MEdit2_TT:="这个是目标目录"
复制_TT:="这个是复制"

return

WM_MOUSEMOVE()
{
static CurrControl, PrevControl, _TT ; _TT 保持为空以便用于下面的 ToolTip 命令.
CurrControl := A_GuiControl
If (CurrControl <> PrevControl and not InStr(CurrControl, " "))
{
ToolTip ; 关闭之前的工具提示.
SetTimer, DisplayToolTip, 1000
PrevControl := CurrControl
}
return

DisplayToolTip:
SetTimer, DisplayToolTip, Off
ToolTip % %CurrControl%_TT ; 前导的百分号表示要使用表达式.
SetTimer, RemoveToolTip, 3000
return

}
Button选择源文件夹:
FileSelectFolder,源文件夹
GuiControl,, MEdit1, %源文件夹%

return
Button选择目标文件:
FileSelectFolder,目标文件夹
GuiControl,, MEdit2, %目标文件夹%
return

GuiDropFiles: ; 对拖放提供支持
SelectedFileName := A_GuiEvent
MouseGetPos, , , id, control
WinGetClass, class, ahk_id %id%
if (control="Edit1")
{
GuiControl,, MEdit1, %SelectedFileName% ; 在控件中显示文本.
}
if (control="Edit2")
{
GuiControl,, MEdit2, %SelectedFileName% ; 在控件中显示文本.
}
return

执行:
Gui, Submit
if (MEdit1="") || if (MEdit2="")
Reload
gui, 1:Destroy
rbc:="C:\Windows\System32\Robocopy.exe"
if (源目录=1)
MEdit2:=MEdit2 . "\" . StrSplit(Medit1,"\")[strsplit(Medit1,"\").MaxIndex()]

if 复制=1
run , "%rbc%" "%MEdit1%" "%MEdit2%" /e /r:0 /w:0 /xf "*.tmp",,Hide
else if 剪切=1
run, "%rbc%" "%MEdit1%" "%MEdit2%" /e /Move /r:0 /w:0 /xf "*.tmp",,Hide
ToolTip 任务已完成！！！
Sleep,5000
Reload
return

Button退出:
GuiClose:
gui, 1:Destroy
return

GuiButtonIcon(Handle, File, Index := 1, Options := "")
{
RegExMatch(Options, "i)w\K\d+", W), (W="") ? W := 16 :
RegExMatch(Options, "i)h\K\d+", H), (H="") ? H := 16 :
RegExMatch(Options, "i)s\K\d+", S), S ? W := H := S :
RegExMatch(Options, "i)l\K\d+", L), (L="") ? L := 0 :
RegExMatch(Options, "i)t\K\d+", T), (T="") ? T := 0 :
RegExMatch(Options, "i)r\K\d+", R), (R="") ? R := 0 :
RegExMatch(Options, "i)b\K\d+", B), (B="") ? B := 0 :
RegExMatch(Options, "i)a\K\d+", A), (A="") ? A := 4 :
Psz := A_PtrSize = "" ? 4 : A_PtrSize, DW := "UInt", Ptr := A_PtrSize = "" ? DW : "Ptr"
VarSetCapacity( button_il, 20 + Psz, 0 )
NumPut( normal_il := DllCall( "ImageList_Create", DW, W, DW, H, DW, 0x21, DW, 1, DW, 1 ), button_il, 0, Ptr ) ; Width & Height
NumPut( L, button_il, 0 + Psz, DW ) ; Left Margin
NumPut( T, button_il, 4 + Psz, DW ) ; Top Margin
NumPut( R, button_il, 8 + Psz, DW ) ; Right Margin
NumPut( B, button_il, 12 + Psz, DW ) ; Bottom Margin
NumPut( A, button_il, 16 + Psz, DW ) ; Alignment
SendMessage, BCM_SETIMAGELIST := 5634, 0, &button_il,, AHK_ID %Handle%
return IL_Add( normal_il, File, Index )
}

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return