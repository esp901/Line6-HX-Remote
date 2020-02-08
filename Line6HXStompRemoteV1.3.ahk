#SingleInstance Force
#NoEnv
IfWinNotExist, ahk_exe cmd.exe
	run, cmd.exe
WinWaitActive, ahk_exe cmd.exe
winmove, ahk_exe cmd.exe,, 0, 275, 790, 150
SetWorkingDir %A_ScriptDir%\Buttons
SetBatchLines -1



Gui +hWndhMainWnd
Gui +AlwaysOnTop


Gui Add, Picture, grecord vrec x5 y5 w150 h30, button_record (2).png
Gui Add, Picture, gstop vstop x160 y5 w150 h30, button_stop (1).png
Gui Add, Picture, gplayonce vplay1x x315 y5 w150 h30, button_play-x (1).png
Gui Add, Picture, gplayround vplay8 x470 y5 w150 h30, button_play (1).png
Gui Add, Picture, goverdub voverdub x625 y5 w150 h30, button_overdub (1).png
Gui Add, Picture, gundo vundo x625 y35 w150 h30, button_undo-last (1).png
Gui Add, Picture, gforward vforward x5 y35 w150 h30, button_forward (1).png 
Gui Add, Picture, greverse vreverse x160 y35 w150 h30, button_reverse (1).png 
Gui Add, Picture, gfullspeed vfullspeed x315 y35 w150 h30, button_full-speed (1).png
Gui Add, Picture, ghalfspeed vhalfspeed x470 y35 w150 h30, button_half-speed (1).png
Gui Add, Slider, range1-127 tickinterval12 tooltiptop vExpr1 gexpr1 x5 y120 w150 h32, EXPR-1
Gui Font, s8, Calibri
Gui Add, Text, cWhite x10 y150, Expression Pedal_1
Gui Add, Slider, range1-127 tickinterval12 tooltiptop vExpr2 gexpr2 x170 y120 w150 h32, EXPR-2
Gui Add, Text, cWhite x178 y150, Expression Pedal_2
Gui Add, Picture, gtuner vtuner x625 y72 w150 h30, button_tuner (1).png
Gui Add, Picture, gpresetup vpresetup x5 y72 w150 h30, button_preset (1).png
Gui Add, Picture, gpresetdown vpresetdown x160 y72 w150 h30, button_preset (3).png
Gui Add, Edit, R1 vPatch x315 y76 w100 h50
Gui Add, Picture, gPatch vok x420 y72 w50 h30, button_ok (1).png
Gui Add, Edit, R1 vTempo x480 y76 w50 h50
Gui Add, Checkbox, cWhite vTempoJN x535 y80, y/n
Gui Add, Text, cWhite x315 y100, Enter Patch (e.g. 04-B)
Gui Add, Text, cWhite x480 y100, Record Count in? `nEnter bpm 
Gui Add, Picture, gReset vreset x695 y235 w80 h30, button_restart (1).png
Gui Add, Picture, ghowto vhowto x695 y200 w80 h30, button (1).png
Gui Add, Picture, gTap vtap x625 y102 w150 h30, button_tap-tempo (1).png

;Gui Add, Picture, gSpeed vspeed x725 y130 w50 h30, button_ok (1).png
Gui Add, Picture, gPanic vpanic x5 y210 w620 h55, button_midi-panic.png
Gui Add, Picture, gfoot1 vfoot1 x5 y180 w120 h30, button_foot (1).png
Gui Add, Picture, gfoot2 vfoot2 x130 y180 w120 h30, button_foot (3).png
Gui Add, Picture, gfoot3 vfoot3 x255 y180 w120 h30, button_foot (5).png
Gui Add, Picture, gfoot4 vfoot4 x380 y180 w120 h30, button_foot (7).png
Gui Add, Picture, gfoot5 vfoot5 x505 y180 w120 h30, button_foot (9).png



Gui, Color, 333333
Gui Show, x0 y0 w780 h275, Line 6 HX Remote V1.3
WinActivate, ahk_class AutoHotkeyGUI
Return

;++++++++++++++++++++++++++++++++++++++++++++hotkey-section++++++++++++++++++++++++++++++++++++++++
#IfWinActive ahk_class AutoHotkeyGUI
Enter::gosub, Patch
r::gosub, record
s::gosub, stop
p::gosub, playonce
Space:: gosub, Playround
o::gosub, overdub
u::gosub, undo
!f::gosub, forward
!r::gosub, reverse
f::gosub, fullspeed
h::gosub, halfspeed
t::gosub, tuner
Left::gosub, presetdown
Right::gosub, presetup
Numpad1::gosub, foot1
Numpad2::gosub, foot2
Numpad3::gosub, foot3
Numpad4::gosub, foot4
Numpad5::gosub, foot5
NumpadAdd::gosub, Tap
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

howto:
guicontrol,, howto, button.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,howto, button (1).png
SplashtextOn, 200, 400, Shortcuts, r=record`rs=stop`rp=Play Once`rSPACE=PlayEndless`ro=overdub`ru=undo`rAlt_F=forward`rAlt_R=reverse`rf=fullspeed`rh=halfspeed`rt=tuner`rLeft=Preset-1`rRight=Preset+1`rNumpad1-5=Footswitch1-5`rNumPad+=TapTempo`n`n©esp901@googlemail.com 2020
sleep, 5000
SplashTextOff
return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
record:
Gui, submit, nohide
clipboard = sendmidi dev line cc 60 64
ClipWait
guicontrol,, rec, button_record (1).png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,rec, button_record.png

if TempoJN = 1
{
Tempo13 := Tempo+(Tempo/100*15)
SoundBeep, 1023, 100
sleep, 60000/Tempo13
SoundBeep, 494, 100
sleep, 60000/Tempo13
SoundBeep, 494, 100
sleep, 60000/Tempo13
SoundBeep, 494, 100
sleep, 30000/Tempo13
}

WinActivate, ahk_exe cmd.exe
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
stop:
guicontrol,, stop, button_stop.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,stop, button_stop (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 61 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
playonce:
guicontrol,, play1x, button_play-x.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,play1x, button_play-x (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 62 64
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
playround:
guicontrol,, play8, button_play.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,play8, button_play (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 61 64
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
overdub:
guicontrol,, overdub, button_overdub.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,overdub, button_overdub (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 60 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
undo:
guicontrol,, undo, button_undo-last.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,undo, button_undo-last (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 63 64
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
forward:
guicontrol,, forward, button_forward.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,forward, button_forward (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 65 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
reverse:
guicontrol,, reverse, button_reverse.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,reverse, button_reverse (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 65 64
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
fullspeed:
guicontrol,, fullspeed, button_full-speed.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,fullspeed, button_full-speed (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 66 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
halfspeed:
guicontrol,, halfspeed, button_half-speed.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,halfspeed, button_half-speed (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 66 64
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
expr1:
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 1 %Expr1%
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
expr2:
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 2 %Expr2%
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
tuner:
guicontrol,, tuner, button_tuner.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,tuner, button_tuner (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 68 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
presetup:
guicontrol,, presetup, button_preset.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,presetup, button_preset (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 71 1
ClipWait
send, ^v{Enter}
sleep, 500
clipboard = sendmidi dev line cc 50 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
presetdown:
guicontrol,, presetdown, button_preset (2).png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,presetdown, button_preset (3).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 71 1
ClipWait
send, ^v{Enter}
sleep, 200
clipboard = sendmidi dev line cc 49 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Patch:
guicontrol,, ok, button_ok.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,, ok, button_ok (1).png
Gui, submit, nohide
Array := StrSplit(Patch, "-")
Zahl := Array[1]
Buchstabe := Array[2]
IfInString, Buchstabe, A
	Letter := 3
IfInString, Buchstabe, B
	Letter := 2
IfInString, Buchstabe, C
	Letter := 1
Preset := Zahl * 3 - Letter
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line pc %Preset%
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Tap:
guicontrol,, tap, button_tap-tempo.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,tap, button_tap-tempo (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 64 64
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*
Speed:
guicontrol,, speed, button_ok.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,speed, button_ok (1).png
gui, submit, nohide
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 64 64
ClipWait
send, ^v{Enter}
Sleep 56000 / bpm
send, ^v{Enter}
Sleep 56000 / bpm
send, ^v{Enter}
Sleep 56000 / bpm

Return
*/
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
foot1:
guicontrol,, foot1, button_foot.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,foot1, button_foot (1).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 49 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
foot2:
guicontrol,, foot2, button_foot (2).png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,foot2, button_foot (3).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 50 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
foot3:
guicontrol,, foot3, button_foot (4).png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,foot3, button_foot (5).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 51 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
foot4:
guicontrol,, foot4, button_foot (6).png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,foot4, button_foot (7).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 52 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
foot5:
guicontrol,, foot5, button_foot (8).png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,foot5, button_foot (9).png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 53 0
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
Return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Panic:
guicontrol,, panic, button_midi-panic (1).png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,panic, button_midi-panic.png
WinActivate, ahk_exe cmd.exe
clipboard = sendmidi dev line cc 11
ClipWait
send, ^v{Enter}
WinActivate, Line 6 HX Remote
return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Reset:
guicontrol,, reset, button_restart.png
Loop
{
	LM:=getkeystate("LButton")
	if(LM=False)
		break
}
guicontrol,,reset, button_restart (1).png
Reload
return
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
GuiEscape:
GuiClose:
    ExitApp