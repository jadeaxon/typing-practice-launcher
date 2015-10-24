#!/usr/bin/env bash

# PRE: You are running Cygwin as admin on Windows 10.

# This is where you can put programs to start at boot for all users.
startup_dir='/cygdrive/c/ProgramData/Microsoft/Windows/Start Menu/Programs/StartUp'
cp Typing.ahk "$startup_dir"


