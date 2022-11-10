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

    MIN_BOOST_MOMENTUM := 25,
            ; The higher the value,
            ; the slower boost activates and accumulates.
            ; Set to 0 to disable boost completely.
            ; Default: 30.

    MAX_SCROLLS_TO_SEND := 70,
            ; Spamming apps with hundreds of individual scroll events can slow them down,
            ; so set a max number of scrolls sent per click.
            ; Default: 60.

    ; Session variables:
    _momentum,
    _highestSpeedAchieved

    timeBetweenHotkeysMs := A_TimeSincePriorHotkey or 1

    if not (A_ThisHotkey = A_PriorHotkey and timeBetweenHotkeysMs < TIMEOUT_MS) {
            ; Combo broken.
        ; So reset session variables:
        _momentum := 0
        _highestSpeedAchieved := 1

        MouseClick(A_ThisHotkey)
        return
    }
    _momentum++
            ; Remember how many times the current direction has been scrolled in.
    if timeBetweenHotkeysMs < 100 {
        speed := (250.0 / timeBetweenHotkeysMs) - 1
                ; Calculate acceleration factor using a 1/x like curve.
    } else {
        speed := 1
    }

    ; Apply boost:
    if MIN_BOOST_MOMENTUM > 1 and _momentum > MIN_BOOST_MOMENTUM {
        if speed > _highestSpeedAchieved {
            _highestSpeedAchieved := speed
        } else {
            speed := _highestSpeedAchieved
        }
        speed *= _momentum / MIN_BOOST_MOMENTUM
    }
    if speed > MAX_SCROLLS_TO_SEND {
        speed := MAX_SCROLLS_TO_SEND
    } else {
        speed := Floor(speed)
    }
    MouseClick(A_ThisHotkey, , , speed)
}
