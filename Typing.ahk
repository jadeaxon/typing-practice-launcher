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

_openTypingPractice() {
	Run "C:\Users\jadeaxon\Dropbox\Organization\Notes\Computing\Typing.txt"
	Run http://play.typeracer.com/
	WinWaitActive TypeRacer
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



