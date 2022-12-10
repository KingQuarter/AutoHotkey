#Include default-settings.ahk

K_CHARS := Map(
    'LEFT_TO_RIGHT_MARK', Chr(0x200E)
)

K_CLASSES := Map(
    'DIALOG_BOX', 'ahk_class #32770'
)

    K_CLASSES['ZOOM'] := Map(
        'HOME',           'ZPPTMainFrmWndClassEx',
        'HIDDEN_TOOLBAR', 'ZPFloatToolbarClass',
        'MEETING',        'ZPContentViewWndClass',
        'MIN_CONTROL',    'ZPActiveSpeakerWndClass',
        'MIN_VID',        'ZPFloatVideoWndClass',
        'TOOLBAR',        'ZPToolBarParentWndClass',
        'REACTION',       'ZPReactionWndClass',
        'VID_PREVIEW',    'VideoPreviewWndClass',
        'WAIT_HOST',      'zWaitHostWndClass'
    )

ConvertClassesAbbrevsToFullForm()
ConvertClassesAbbrevsToFullForm() {
    for abbrev, fullForm in K_CLASSES['ZOOM'] {
        K_CLASSES['ZOOM'][abbrev] := 'ahk_class ' fullForm
    }
}

K_CONTROLS := Map(

)

    K_CONTROLS['ZOOM'] := Map(
        'MEETING_CONTROLS', 'ZPControlPanelClass1'
    )

K_CONTROL_CODES := Map(

)

    K_CONTROL_CODES['TRAY'] := Map(
            ; Standard AHK tray menu control codes for the WM_COMMAND
        'OPEN',    65300,
        'HELP',    65301,
        'SPY',     65302,
        'RELOAD',  65303,
        'EDIT',    65304,
        'SUSPEND', 65305,
        'PAUSE',   65306,
        'EXIT',    65307
    )

K_GUI_OPTIONS := Map(
    'LBS_NOINTEGRALHEIGHT',  'x100',
    'DEFAULT_BACKGROUND', '-E0x200'
)

K_WIN32_CONSTS := Map(
    'WM_COMMAND',    0x0111
)
