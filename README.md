# typing-practice-launcher
AHK script to launch my daily typing practice.  What I do is go for perfect execution in TypeRacer at some tempo for five minutes and then raise that BPM by 1 every day if I don't make any mistakes.  Then, I try to go as fast as I can in Keybr for a bit.

Getting back into software dev in 2011 (after a long guitar playing break), I decided to take up
Programmer Dvorak since I had carpal tunnel issues at one point in the past.  Switching layouts was tough going.
Could only type 15 wpm at first.  Now I hit in the mid 80s, which is faster than I ever was on Qwerty.  No more RSI issues either.  Trying to get over 100, but it is not happening naturally for me. 

Once the script is active, `<C-A t>` initiates typing practice.  The script opens the browser tabs in reverse order so I can just use `<C w>` to dismiss tabs.  In the last tab, `<A s>` is a hotkey to stop typing practice.  That is, everything can be easily done by keyboard.

Here's the idea:
- [X] Be able to start practice by `<C-A t>` hotkey.
- [X] Run at Windows startup, but only before noon.  
- [X] Stay persistent to provide hotkeys for TypeRacer.  Don't want to use mouse at all.
- [X] Open Typing.txt.  
- [X] Extract current BPM from Typing.txt.
- [X] Open web metronome.
- [X] Set BPM.
- [X] Start metronome.
- [X] Set laptop volume to 15.  Or thereabouts.
- [X] Open TypeRacer.  
- [X] Start a solo practice in TypeRacer.
- [X] Open Keybr in another browser tab.
- [X] Provide TypeRacer hotkeys so that no mouse use in necessary.
- [X] Provide hotkey to close on success.
- [X] Bump BPM on exit.
