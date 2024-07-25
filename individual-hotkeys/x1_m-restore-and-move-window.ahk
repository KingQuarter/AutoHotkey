#Include lib
#Include mouse-functions.ahk
#Include fix-x1.ahk

; A low A_WinDelay is very important for MouseRestoreAndMoveWinToFollow to be smooth.
#Include default-settings.ahk

/**
 * Press XButton1 + MButton
 * to restore a window and move it using the mouse 🚚.
 */

#HotIf GetKeyState('XButton1', 'P')
!MButton Up:: MouseCloseAltTabWin()

; What's this hotkey for?
; *MButton Up:: return

*MButton Up:: {
    if thisHotkey and not MouseThisHkIsCorrect(thisHotkey) {
        return
    }
    ; ToolTip(thisHotkey ' and ' A_PriorHotkey)

    if MouseCloseAltTabWin() {
        return
    }

    MouseRestoreAndMoveWinToFollow(thisHotkey)
}

MouseCloseAltTabWin() {
    wasAWinClosed := false
    if WinActive('Task Switching ahk_class XamlExplorerHostIslandWindow') {
        Click('Middle')
        wasAWinClosed := true
    }
    return wasAWinClosed
}

MouseRestoreAndMoveWinToFollow(thisHotkey := "") {
    MouseActivateWin()
    if WinActive('ahk_class WorkerW ahk_exe Explorer.EXE') {
        return
    }

    WinExist('A')
    winMinMax := WinGetMinMax()
    if winMinMax = 1 {
        WinRestore()
        MouseMoveWinMiddle()
    }

    MouseMoveWinToFollow()
}
#HotIf

MouseIsWinStillRestored() {
    a_thisHotkeyNoDirection := SubStr(A_ThisHotkey, 1, -2)
    return a_thisHotkeyNoDirection != 'MButton & Wheel'
}

MouseMoveWinMiddle() {
    CoordMode('Mouse', "Screen")
    MouseGetPos(&mouseX, &mouseY)

    WinGetPos(, , &winWidth, &winHeight)
    winHalfWidth  := winWidth / 2
    winHalfHeight := winHeight / 2

    winX := mouseX - winHalfWidth
    winY := mouseY - winHalfHeight
    WinMove(winX, winY)
}

MouseMoveWinToFollow() {
    CoordMode('Mouse', "Screen")
    MouseGetPos(&mouseStartX, &mouseStartY)
    global G_MouseIsMovingWin := true

    ; Enable per-monitor DPI awareness so that the window doesn't explode in size
    ; when moving across displays with different DPI settings. See
    ; https://www.autohotkey.com/docs/v2/misc/DPIScaling.htm#Workarounds
    originalDpiAwarenessContext := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")

    while GetKeyState('XButton1', 'P') and MouseIsWinStillRestored()
            ; A loop is used instead of SetTimer to preserve the last found window.
    {
        WinGetPos(&winX, &winY)
        MouseGetPos(&mouseX, &mouseY)
        changeInMouseX := mouseX - mouseStartX
        changeInMouseY := mouseY - mouseStartY
        winX += changeInMouseX
        winY += changeInMouseY
        WinMove(winX, winY)

        mouseStartX := mouseX
        mouseStartY := mouseY
        Sleep(10)
    }

    G_MouseIsMovingWin := false
    DllCall("SetThreadDpiAwarenessContext", "ptr", originalDpiAwarenessContext, "ptr")
}
