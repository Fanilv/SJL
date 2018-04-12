x:=A_ScreenWidth-500
y:=A_ScreenHeight-200
countdown:=1200
currentstatus:=time
CustomColor = 010101
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui, Color, %CustomColor%
Gui, Font, s64
Gui, Add, Text, vMyText cBlack gCountdown, XXXXXXXXX
WinSet, TransColor, %CustomColor% 150
SetTimer, UpdateOSD, 1000
Gosub, UpdateOSD
Gui, Show, x%x% y%y% NoActivate
return


FormatSeconds(NumberOfSeconds)
{
    time = 19990101  ; 任意日期的 *午夜*.
    time += %NumberOfSeconds%, seconds
    FormatTime, mmss, %time%, mm:ss
    return NumberOfSeconds//3600 ":" mmss
}

UpdateOSD:
FormatTime, Time_Formated , HH24MISS, HH:mm:ss
GuiControl,, MyText, %Time_Formated%
return

UpdateCountdownOSD:
countdown:=countdown-1
GuiControl,, MyText, % FormatSeconds(countdown)
return

Countdown:
if (currentstatus=time)
{
SetTimer, UpdateOSD, off
SetTimer, UpdateCountdownOSD, 1000
currentstatus:=countdown
}
else
{
SetTimer, UpdateCountdownOSD, off
SetTimer, UpdateOSD, 1000
currentstatus:=time
}
return