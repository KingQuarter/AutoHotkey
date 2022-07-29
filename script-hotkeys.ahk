#Include <default-settings>

#SuspendExempt
#^s:: Suspend
#SuspendExempt false

#^r:: Run '*UIAccess "' . A_ScriptName . '"'
#^p:: Pause -1
#^x:: ExitApp

#^e:: {
    if WinExist('ahk_exe Code.exe')
        WinActivate
    else
        Edit
}

#^h::
    OpenDocs(this_hk) {
        static DIRECTORY := 'https://lexikos.github.io/v2/docs'

        if GetKeyState('CapsLock', 'T') {
            selected := GetSelected()
            if not selected
                return
            command := StrReplace(selected, '#', '_', , , 1)
            Run DIRECTORY . '/commands/' . command . '.htm'
        }
        else {
            Run DIRECTORY . '/AutoHotkey.htm'
        }
    }

#^w::
    WinSpy(this_hk) {
        static WIN_SPY := 'Window Spy ahk_class AutoHotkeyGUI'
        
        try {
            min_max := WinGetMinMax(WIN_SPY)
        }
        catch TargetError {
            Run 'WindowSpy.ahk', A_ProgramFiles . '\AutoHotkey'
            return
        }

        if min_max = -1 {
            WinActive 'A'
            WinActivate WIN_SPY
            WinActivate
        }
        else {
            WinClose WIN_SPY
        }
    }
