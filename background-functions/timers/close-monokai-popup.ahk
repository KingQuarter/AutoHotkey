#Include ..\..\constants\_constants.ahk
#Include ..\..\functions\_functions.ahk

CloseMonokaiPopup() {
    static _monokaiMsg :=
    (Join`r`n
        '[Window Title]
        Visual Studio Code

        [Content]
        Thank you for evaluating Monokai Pro. Please purchase a license for extended use.

        [OK] [Cancel]'
    )

    if not WinExist('Visual Studio Code ' K_CLASSES['DIALOG_BOX'] ' ahk_exe Code.exe')
            ; VS Code still needs to be active fsr.
    {
        return
    }

    WinActivate()

    activeMsg := GetSelected()
    if activeMsg != _monokaiMsg {
        return
    }
    WinClose()
}