/*
 * This file is part of Maliit plugins
 *
 * Copyright (C) 2012 John Brooks <john.brooks@dereferenced.net>
 * Copyright (C) Jakub Pavelek <jpavelek@live.com>
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Nokia Corporation nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

import QtQuick 2.0
import "KeyboardUiConstants.js" as UI
import com.meego.maliitquick 1.0

MouseArea {
    id: keyboard

    property bool disablePopper: false
    property Item layout
    property Item pressedKey

    onLayoutChanged: if (layout) layout.parent = keyboard

    // Can be changed to PreeditTestHandler to have another mode of input
    InputHandler {
        id: inputHandler
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: UI.BG_COLOR
    }

    Popper {
        id: popper
        z: 10
        target: disablePopper ? null : pressedKey
        visible: !disablePopper
    }

    AccentsPopper {
        id: accentsPopper
        z: 11
        target: _pressAndHold ? pressedKey : null
    }

    Timer {
        id: pressTimer
        interval: 500
    }

    Connections {
        target: MInputMethodQuick
        onCursorPositionChanged: {
            applyAutocaps()
        }
        onFocusTargetChanged: {
            if (activeEditor) {
                // Quick & dirty solution to the caps problem: the maliit Qt/C++
                // plugin always emit a focus changes, which in turn emit this signal.
                // Commenting the resetKeyboard() invokation prevent losing the caps.
                // resetKeyboard()
                applyAutocaps()
            }
        }
        onInputMethodReset: {
            inputHandler._reset()
        }
    }

    /* Mouse handling */
    property int _startX
    property int _startY
    property bool _pressAndHold: false

    onPressed: {
        _startX = mouse.x
        _startY = mouse.y
        pressTimer.start()
        updatePressedKey(mouse.x, mouse.y)
    }

    onPressAndHold: {
        _pressAndHold = true
    }

    onPositionChanged: {
        // Hide keyboard on flick down
        if (pressTimer.running && (mouse.y - _startY > (height * 0.3))) {
            MInputMethodQuick.userHide()
            if (pressedKey) {
                inputHandler._handleKeyRelease()
                pressedKey.pressed = false
            }
            pressedKey = null
            return
        }

        updatePressedKey(mouse.x, mouse.y)
    }

    onCanceled: {
        if (pressedKey) {
            pressedKey.pressed = false
            pressedKey = null
        }
    }

    onReleased: {
        if (pressedKey === null)
            return

        if (_pressAndHold && accentsPopper.selectedChar) {
            inputHandler._sendKeyClick(accentsPopper.selectedChar)
        }
        else {
            inputHandler._handleKeyClick()
        }
        pressedKey.clicked()
        inputHandler._handleKeyRelease()

        _pressAndHold = false
        pressedKey.pressed = false
        pressedKey = null
    }

    function updatePressedKey(x, y) {
        if (_pressAndHold) {
            var c = keyboard.mapToItem(accentsPopper, x, y)
            if (accentsPopper.contains(Qt.point(c.x, c.y))) {
                accentsPopper._handleAccentSelection(c.x, c.y)
                return
            }
        }

        var key = keyAt(x, y)
        if (pressedKey === key)
            return

        inputHandler._handleKeyRelease()

        if (pressedKey !== null)
            pressedKey.pressed = false

        pressedKey = key

        if (pressedKey !== null) {
            pressedKey.pressed = true
            inputHandler._handleKeyPress(pressedKey)
        }
    }

    function keyAt(x, y) {
        var item = layout
        x -= layout.x
        y -= layout.y

        while ((item = item.childAt(x, y)) != null) {
            if (typeof item.text !== 'undefined' && typeof item.pressed !== 'undefined') {
                return item
            }

            // Cheaper mapToItem, assuming we're not using anything fancy.
            x -= item.x
            y -= item.y
        }

        return null
    }

    function resetKeyboard() {
        if (!layout)
            return
        layout.isShifted = false
        layout.isShiftLocked = false
        layout.inSymView = false
        layout.inSymView2 = false
        inputHandler._reset()
    }

    function applyAutocaps() {
        if (MInputMethodQuick.surroundingTextValid
                && MInputMethodQuick.contentType === Maliit.FreeTextContentType
                && MInputMethodQuick.autoCapitalizationEnabled
                && !MInputMethodQuick.hiddenText
                && layout && layout.isShiftLocked === false) {
            var position = MInputMethodQuick.cursorPosition
            var text = MInputMethodQuick.surroundingText.substring(0, position)

            if (position == 0
                    || (position == 1 && text[0] === " ")
                    || (position >= 2 && text[position - 1] === " "
                        && ".?!".indexOf(text[position - 2]) >= 0)) {
                layout.isShifted = true
            } else {
                layout.isShifted = false
            }
        }
    }
}
 
