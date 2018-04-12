#SingleInstance,force
#Persistent
;SetFormat,float,0.0
VarSetCapacity(OriginalRamp,512*3,0)
hr:=DllCall("GetDeviceGammaRamp","uint",DllCall("GetDC","ptr",0,"uint"),"ptr",&OriginalRamp)
 
red:=NumGet(OriginalRamp,512-2,"ushort")/0xFF00
green:=NumGet(OriginalRamp,512*2-2,"ushort")/0xFF00
blue:=NumGet(OriginalRamp,512*3-2,"ushort")/0xFF00
 
gui,add,text,x0 y0 w30 h20,red
gui,add,text,x0 y25 w30 h20,green
gui,add,text,x0 y50 w30 h20,blue
SetFormat,float,0.0
gui,add,edit,x35 y0 w45 h20 vred
gui,add,updown,Range1-100,% red*100
gui,add,edit,x35 y25 w45 h20 vgreen
gui,add,updown,Range1-100,% green*100
gui,add,edit,x35 y50 w45 h20 vblue
gui,add,updown,Range1-100,% blue*100
SetFormat,float,0.2
gui,add,text,x80 y0 w30 h20,`%
gui,add,text,x80 y25 w30 h20,`%
gui,add,text,x80 y50 w30 h20,`%
 
gui,add,button,x0 y75 w100 h20 gSetCT,Set
gui,add,button,x0 y100 w100 h20 gResetCT,Reset
gui,show,w100 h120
return
 
SetCT:
	gui,submit,nohide
	SetColorTemperature(normal(red/100),normal(green/100),normal(blue/100))
	return
	
ResetCT:
	DllCall("SetDeviceGammaRamp","uint",DllCall("GetDC","ptr",0,"uint"),"ptr",&OriginalRamp)
	return
 
normal(c){
	return c<0?0:c>1?1:c
}
 
SetColorTemperature(r,g,b)
{
	rgb:=[],rgb.1:=r,rgb.2:=g,rgb.3:=b
	VarSetCapacity(ramp,512*3,0)
	loop 3 {
		i:=A_Index
		loop 256 
			NumPut(floor((A_Index-1)*rgb[i]*256),ramp,(i-1)*512+(A_Index-1)*2,"ushort")
	}
	return DllCall("SetDeviceGammaRamp","uint",DllCall("GetDC","ptr",0,"uint"),"ptr",&ramp)
}
return
 
GuiClose:
ExitApp