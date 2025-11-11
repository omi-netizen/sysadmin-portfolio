#Requires AutoHotkey v2.0

; --- Global Variables ---
global RefreshRunning := false ; Tracks whether the auto-refresh loop is active

; --- Hotkey to Toggle Auto-Refresh (Ctrl+Shift+R) ---
; Pressing Ctrl+Shift+R will start or stop the automatic refreshing.
^+R::
{
    
	; redeclare variable
	global RefreshRunning
	
	; Toggle the state of the refresh loop
    RefreshRunning := !RefreshRunning
    
    if (RefreshRunning)
    {
        ; Start the timer that calls the RefreshPage function every 10 seconds (10000ms)
        SetTimer RefreshPage, 10000 
        
        ; Show a notification message
		TrayTip "Auto-Refresh Started", "Refreshing page every 10 seconds. Press Ctrl+Shift+R to stop.", 1
    }
    else
    {
        ; Stop the timer
        SetTimer RefreshPage, 0
        
        ; Show a notification message
		TrayTip "Auto-Refresh Stopped", "Page will no longer auto-refresh.", 3
    }
    return
}

; --- Function to Refresh the Page ---
RefreshPage()
{
    ; Check if Auto-Refresh is actually running before executing
    if (RefreshRunning)
    {
        ; 1. Activate the Microsoft Edge Window
        ; This ensures the F5 press goes to the correct window.
        ; You can change the window title if needed, but "ahk_exe msedge.exe" is reliable.
        WinActivate "ahk_exe msedge.exe"
        
        ; 2. Send the F5 Key
        ; {F5} sends a key press (which is the standard browser refresh).
        Send "{F5}"
        
        ; Optional: Show a quick notification every time it refreshes
        ; TrayTip "Refreshed!", "Page refreshed at " . A_YYYY . "-" . A_MM . "-" . A_DD . " " . A_Hour . ":" . A_Min . ":" . A_Sec, 1, 1
    }
}