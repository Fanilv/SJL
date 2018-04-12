;窗口置顶
!a::
MouseGetPos , , , zdwid ,  ; 得到鼠标所在位置窗口的id及控件名称
WinSet, AlwaysOnTop, toggle,ahk_id %zdwid%
WinGet,zd_pd, ExStyle,ahk_id %zdwid%
if (zd_pd & 0x8)  ; 0x8 为 WS_EX_TOPMOST
   ToolTip,窗口已置顶
Else
   ToolTip,窗口已取消置顶
sleep,3000
ToolTip
return