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
	
	; if (bpm >= 146) {
		; MsgBox,,, %bpm% is a number
	; }

	Return bpm

} ; _readBPM()


; Sets the BPM in the metronome webpage.
; PRE: _readBPM() has been called successfully.
_setBPM(bpm) {
	Run http://a.bestmetronome.com/
	WinWaitActive METRONOME
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
	ExitApp

	Run http://play.typeracer.com/
	WinActivate ahk_class MozillaWindowClass
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



;=============================================================================== 
; Hotkeys
;=============================================================================== 

; # => Win; ^ => Ctrl;  + => Shift; ! => Alt
; $ => Don't allow "Send" output to trigger.  Don't let hotkeys trigger other hotkeys.  


; <C-A t> => Open typing practice stuff.
$^!t::
    _openTypingPractice()
return


#IfWinActive TypeRacer ahk_class MozillaWindowClass
; Map <A n> to TypeRacer's <C-A n> keyboard shortcut.  Next race.
; <A n> is on homerow in Dvorak.
$!n::
    Send ^!k
return
#IfWinActive  



