;  .-----------------------------------------------------------------.
; /  .-.                                                         .-.  \
;|  /   \                    QuakeTerm                          /   \  |
;| |\_.  |     (Quake style pull-down command prompt)          |    /| |
;|\|  | /|                      by                             |\  | |/|
;| `---' |                 Kenzy Carey                         | `---' |
;|       |                                                     |       |
;|       |-----------------------------------------------------|       |
;\       |                                                     |       /
; \     /                                                       \     /
;  `---'                                                         `---'
;Description: Opens CMD.exe, stretches is out, hides it, and makes it appear from the top of the screen.
;Instructions: Compile this script to an exe, or just run it. CNTRL+` to show command prompt.

#SingleInstance force					; Force only one instance to run at a time
DetectHiddenWindows, On					; Look for windows that are set to hidden
OnExit, CLEANEXIT						; Run CLEANEXIT on program close
menu, tray, NoStandard					; Remove standard items in tray menu
Menu, tray, add, Exit, MenuHandler		; Add an exit button to tray menu

~^`::									; Change this to whatever key combo you'd like
	IfWinNotExist ,ahk_pid %cmdPID%		; If we have not yet created a command prompt (or it has been closed), create one
	{
		run, "%SystemRoot%\system32\cmd.exe" "/K cls.exe",C:\,Hide, cmdPID		; Create a hidden cmd.exe window
		WinWait, ahk_pid %cmdPID%														; Wait for it to load
		WinActivate, ahk_pid %cmdPID%													; Activate it
		WinGetPos, X, Y, Width, Height, ahk_pid %cmdPID%								; Get its hight, width, and position
		
		WinMove, ahk_pid %cmdPID%,,60,-500,												; Move it off screen
		WinMove, ahk_pid %cmdPID%,,,, (A_ScreenWidth-60)
	}
	WinSet, AlwaysOnTop, On, ahk_pid %cmdPID%	; Set our command window to be on top of all other windows
	WinShow, ahk_pid %cmdPID%					; Make sure its visable
	WinMove, ahk_pid %cmdPID%,,,-500			; Slowly (but not too slowly) pull the window down from the top of the screen
	WinMove, ahk_pid %cmdPID%,,,-400
	WinMove, ahk_pid %cmdPID%,,,-350			; Keep going
	WinMove, ahk_pid %cmdPID%,,,-300			
	WinMove, ahk_pid %cmdPID%,,,-200			; Your almost there
	WinMove, ahk_pid %cmdPID%,,,-100			
	WinMove, ahk_pid %cmdPID%,,,-30				; Stop right about at the title bar
	WinActivate, ahk_pid %cmdPID%
	WinWaitNotActive, ahk_pid %cmdPID%			; Wait for someone to click away from it
	WinMove, ahk_pid %cmdPID%,,,-50				; Make it scroll back up from wence it came
	WinMove, ahk_pid %cmdPID%,,,-150			
	WinMove, ahk_pid %cmdPID%,,,-250			; Keep going
	WinMove, ahk_pid %cmdPID%,,,-350			
	WinMove, ahk_pid %cmdPID%,,,-400			; Dont stop now
	WinMove, ahk_pid %cmdPID%,,,-450
	WinMove, ahk_pid %cmdPID%,,,-500			; Away with it!
	WinHide, ahk_pid %cmdPID%					; Go hide now
Return	

MenuHandler:				
If A_ThisMenuItem = Exit	; If exit is clicked from tray menu						
	goto, CLEANEXIT			; Run CLEANEXIT

CLEANEXIT:						; Clean exit routine
	process, Close, %cmdPID%	; Kill our hidden command prompt window
	ExitApp						; GOOOOO BYE BYE
Return