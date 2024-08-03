#Include lib
#Include mouse-functions.ahk
#Include fix-x1.ahk

#Include common-lib
#Include default-settings.ahk

; Press XButton1 + LButton
; to send the Delete key ❎.
; Press XButton1 + LButton + RButton
; to send the Enter key ⬇️.
#HotIf GetKeyState('XButton1', 'P')
*LButton Up:: {
    if not MouseIsThisHotkeyCorrect(thisHotkey) {
        return
    }

    if WinActive('Task Switching ahk_class XamlExplorerHostIslandWindow') {
        Click()
        return
    }

    MouseSend('{Delete}')
}

LButton & RButton Up:: MouseSend('{Enter}')
#HotIf
