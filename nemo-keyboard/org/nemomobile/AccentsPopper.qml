/*
 * This file is part of Maliit plugins
 *
 * Author Gianni Valdambrini <aleister@develer.com>
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

Image {
    id: popper
    source: "popper.png"
    opacity: 0
    width: popperText.width + 40
    property Item target: null
    property string selectedChar: ""

    function _handleAccentSelection(x, y) {
        var cx = popper.mapToItem(popperText, x, y)
        var item = popperText.childAt(x, y)
        if (item) {
            popperText.selectedIndex = item.itemIndex
            popper.selectedChar = item.text
        }
    }

    Row {
        id: popperText
        property string text: target !== null && target.accents ? target.accents : ""
        property int selectedIndex: 0
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater {
            model: popperText.text.length
            Item {
                property int itemIndex: model.index
                property alias text: text.text
                width: text.width + 10
                height: popperText.height

                Text {
                    id: text
                    anchors.centerIn: parent
                    text: popperText.text.charAt(index)
                    font.family: "sans"
                    font.pixelSize: UI.FONT_SIZE_POPPER
                    font.bold: true
                    color: itemIndex == popperText.selectedIndex ? UI.TEXT_COLOR_POPPER_SELECTED : UI.TEXT_COLOR_POPPER
                }
            }
        }
    }

    states: State {
        name: "active"
        when: popperText.text != ""

        PropertyChanges {
            target: popper
            opacity: 1

            x: popper.parent.mapFromItem(target, 0, 0).x + (target.width - popper.width) / 2
            y: popper.parent.mapFromItem(target, 0, 0).y - popper.height
        }
    }

    onStateChanged: {
        if (state === "active") {
            popperText.selectedIndex = 0
            popper.selectedChar = ""
        }
    }

    onTargetChanged: {
        popperText.selectedIndex = 0
        popper.selectedChar = ""
    }
}
