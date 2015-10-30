; This script automates my daily typing practice.  Obviously does not automate the 
; actual typing itself as that would defeat the purpose. :)

; My typing practice is essentially 5 minutes of metronome practice on TypeRacer
; followed by trying to go as fast as I can on Keybr.  I bump the metronome 1 BPM
; each day if I don't totally screw up.


;=============================================================================== 
; Main
;=============================================================================== 

; Persistent scripts keep running forever until explicitly closed.
#Persistent

; Just exit before noon.  I'm never going to do typing practice later in the day.
hour := A_Hour + 0 ; Convert to int.  A_Hour seems to be zero-padded string.
if (hour >= 12) {
	ExitApp
}

SetKeyDelay, 50, 50	


;=============================================================================== 
; Functions
;=============================================================================== 

; Reads the latest BPM from the first line of Typing.txt.
; PRE: Typing.txt is open and its window is active.
; PRE: First line has the form 'BPM (next): 146'.
_readBPM() {
	; Select first line and copy to clipboard.
	Send {Escape}
	Send gg
	Send +V 
	Send ^C
	ClipWait
	text := clipboard
	StringSplit, words, text, %A_Space%
	words := Trim(words)
	bpm = %words3%
	StringReplace, bpm, bpm, `n,, A
	StringReplace, bpm, bpm,`r,, A
	bpm := bpm + 0
	
	Return bpm

} ; _readBPM()


; Sets the BPM in the metronome webpage.
; PRE: _readBPM() has been called successfully.
_setBPM(bpm) {
	Run http://a.bestmetronome.com/
	WinActivate METRONOME ahk_class MozillaWindowClass
	WinWaitActive METRONOME ahk_class MozillaWindowClass
	Sleep 1000

	; In Dvorak:
	; u => +10 bpm
	; e => +1 bpm
	; Start bpm is 90.
	; <Space> => start/stop metronome.
	delta := bpm - 90
	tens := delta // 10
	ones := mod(delta, 10)
	Send {u %tens%}
	Send {e %ones%}
	
	; What we should really do is pixel test the screen rather than arbitrary sleep.
	Sleep 7000
	Send {Space}
	Sleep 1000

} ; _setBPM()


; Opens everything needed to start typing practice.
_openTypingPractice() {
	Run http://www.keybr.com/login/1xB0vnQkZI
	WinActivate Learn typing ahk_class MozillaWindowClass
	WinWaitActive Learn typing ahk_class MozillaWindowClass

	Run "C:\Users\jadeaxon\Dropbox\Organization\Notes\Computing\Typing.txt"
	WinActivate Typing ahk_class Vim	
	WinWaitActive Typing ahk_class Vim

	; Set master volume to 15%.
	; SoundSet, 15, Headphones, volume
	; This puts us at 13% on the XPS 15.  Even if volume is at 100%.
	Send {Volume_Down 25}
	Send {Volume_Up 3}

	bpm := _readBPM()
	_setBPM(bpm)

	Run http://play.typeracer.com/
	WinActivate TypeRacer ahk_class MozillaWindowClass
	WinWaitActive TypeRacer ahk_class MozillaWindowClass
	
	; Wait for TypeRacer site to fully load.
	; Again a pixel scrape would be better than arbitrary sleep.
	Sleep 5000

	; For some reason, site won't respond to keyboard shortcuts until you click on it.
	; So, we click on a blank part of the web page.
	MouseMove 740, 260
	Click
	Send ^!o
	; <C-A l> in TypeRacer opens the login prompt.
	; <C-A o> in TypeRacer opens a new practice.
	; However, Master.ahk is trying to open ~/Dropbox/Organization.
	; <C-A k> is rerace after you finish a race.
	; This is no good in Dvorak.  I want <A n> to do this.

} ; _openTypingPractice()


; Stops typing practice.  Bumps BPM in Typing.txt.
; PRE: You must be using <A-a> and <C-s> mapping from my .vimrc.
_stopTypingPractice() {
	; Open Slashdot.org in the Keybd tab in Firefox.
	SetKeyDelay, 10, 10	
	Send ^l
	Send http://slashdot.org
	Send {Enter}

	WinActivate Typing ahk_class Vim	
	WinWaitActive Typing ahk_class Vim
	Send {Escape}
	Send gg
	Send !a
	Send ^s
	Send !{F4}

	ExitApp
} ; _stopTypingPractice()


;=============================================================================== 
; Hotkeys
;=============================================================================== 

; # => Win; ^ => Ctrl;  + => Shift; ! => Alt
; $ => Don't allow "Send" output to trigger.  Don't let hotkeys trigger other hotkeys.  


; <C-A t> => Open typing practice stuff.
$^!t::
	MsgBox,,, Smile!, 3
    _openTypingPractice()
return


#IfWinActive TypeRacer ahk_class MozillaWindowClass
; Map <A n> to TypeRacer's <C-A n> keyboard shortcut.  Next race.
; <A n> is on homerow in Dvorak.
$!n::
    Send ^!k
return
#IfWinActive  


#IfWinActive Learn typing ahk_class MozillaWindowClass
; <A s> => Stop typing practice.
$!s::
    _stopTypingPractice()
return
#IfWinActive  


