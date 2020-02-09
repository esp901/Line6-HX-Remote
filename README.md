# Line6-HX-Remote
MidiCC-Remotecontrol for Line6 HX Stomp (and probably other Helix devices...)

Feb./2020

Hello ☺

This is a program I wrote the last weeks. Its purpose is to have a simple GUI to remote-control a Line 6 HX Stomp guitar-multieffect-pedal. It is not made for programming or editing patches - for that there is the Line6 HX Edit. 
The Helix-devices have the feature to control some functions via midi-cc (control-change) and midi-pc (program-change). This way one can e.g. tap tempo, enable/disable foot controllers, work with the built-in 1-switch-looper and further. The last was my main intention to write the program. Most of the time I play at home sitting at my desktop and the hx-stomp not near my feet to press buttons the way it was meant to be.
It is possible to either press a button with the mouse or enter a dedicated hotkey - e.g. "r" for record, "s" for stop and so on. A list of the hotkeys is shown by pressing the "???"-button. There is NO hotkey for this ???-button ☺
With version 1.3 I added the feature to count-in with an editable beats-per-minute-value before starting a looper-record.
Something what is only possible via midi-cc, is to set the recording/playback-speed. If you choose halfspeed before recording and fullspeed during playback you can hear yngwie malmsteen play. The other way it slows down your recording and you know what I am sounding like....
Also unique is the possibiliy to reverse-playback your recording.

The most important now: My program is only the gui. The midi-commands itself are produced by another freely available tool called
"sendmidi.exe". This is a brilliant little commandline-program by a guy from the netherlands. I wish, I had his abilities...
Same as my program there is no need for installation.

Line6-HX-Remote is written in "autohotkey", which is a quite beginner-friendly language. You can view and edit the code simply by opening the file Line6-HX-Remote..ahk with any editor like notepad. 
