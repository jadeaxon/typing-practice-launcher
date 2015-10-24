;=============================================================================== 
; Main
;=============================================================================== 

; Persistent scripts keep running forever until explicitly closed.
#Persistent

; Just exit before noon.  I'm never going to do typing practice later in the day.
hour := A_Hour + 0 ; Convert to int.  A_Hour seems to be zero-padded string.
if (hour < 12) {
	ExitApp
}


;=============================================================================== 
; Functions
;=============================================================================== 

_openTypingPractice() {
	Run "C:\Users\jadeaxon\Dropbox\Organization\Notes\Computing\Typing.txt"
	
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

