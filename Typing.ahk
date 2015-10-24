;=============================================================================== 
; Main
;=============================================================================== 

; Persistent scripts keep running forever until explicitly closed.
#Persistent


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

