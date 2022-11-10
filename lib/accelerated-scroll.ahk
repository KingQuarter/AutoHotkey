/**
 * Originally by BoffinbraiN.
 * For full details, visit the forum thread:
 * https://autohotkey.com/board/topic/48426-accelerated-scrolling-script
 */

#Include default-settings.ahk

A_MaxHotkeysPerInterval := 140
        ; Default: 120

/**
 * To use effectively, make sure this function is the first line in a hotkey.
 */
AcceleratedScroll() {
    static TIMEOUT_MS := 500,
            ; Length of a scrolling session.
            ; Keep scrolling within this time to accumulate boost.
            ; Default: 500
            ; Recommended: 400 < x < 1000.

    BOOST := 25,
            ; If you scroll many times in one session, apply additional boost factor.
            ; The higher the value, the longer it takes to activate,
            ; and the slower it accumulates.
            ; Set to 0 to disable completely.
            ; Default: 30.

    MAX_SCROLLS := 70,
            ; Spamming apps with hundreds of individual scroll events can slow them down,
            ; so set a max number of scrolls sent per click.
            ; Default: 60.

    ; Session variables:
    _count,
    _highestSpeedAchieved

    timeBetweenHotkeysMs := A_TimeSincePriorHotkey or 1

    if not (A_ThisHotkey = A_PriorHotkey and timeBetweenHotkeysMs < TIMEOUT_MS) {
            ; Combo broken.
        ; So reset session variables:
        _count := 0
        _highestSpeedAchieved := 1

        MouseClick(A_ThisHotkey)
        return
    }
    _count++
            ; Remember how many times the current direction has been scrolled in.
    if timeBetweenHotkeysMs < 100 {
        speed := (250.0 / timeBetweenHotkeysMs) - 1
                ; Calculate acceleration factor using a 1/x like curve.
    } else {
        speed := 1
    }

    ; Apply boost:
    if BOOST > 1 and _count > BOOST {
        if speed > _highestSpeedAchieved {
            _highestSpeedAchieved := speed
        } else {
            speed := _highestSpeedAchieved
        }
        speed *= _count / BOOST
    }
    if speed > MAX_SCROLLS {
        speed := MAX_SCROLLS
    } else {
        speed := Floor(speed)
    }
    MouseClick(A_ThisHotkey, , , speed)
}
