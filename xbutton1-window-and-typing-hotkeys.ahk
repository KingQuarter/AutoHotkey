/**
 * Note: The order of some of the following #Include directives is very important.
 * Namely, moving the X1+W hotkeys below the X1+R+W hotkeys would make X1+R+W not work.
 * See https://www.autohotkey.com/boards/viewtopic.php?f=14&t=125819
 */

#Include individual-hotkeys
#Include x1_w-cycle-windows-in-used-order.ahk
#Include x1_l-send-delete-or-enter.ahk
#Include x1_m_r-close-window.ahk
#Include x1_m_w-minimize-or-maximize-window.ahk
#Include x1_m-restore-and-move-window.ahk
#Include x1_r_w-undo-or-redo.ahk
#Include x1_r-copy-or-paste.ahk
