/*
 * This file is part of Maliit plugins
 *
 * Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies). All rights reserved.
 *
 * Contact: Jakub Pavelek <jpavelek@live.com>
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

KeyBase {
    id: aFunctKey

    property string icon
    property string caption
    property int sourceWidth: -1
    property int sourceHeight: -1

    opacity: pressed ? 0.6 : 1.0
    showPopper: false

    Image {
        id: leftBit
        source: (landscape) ? "meegotouch-keyboard-function-key-left-landscape.png"
                            : "meegotouch-keyboard-function-key-left.png"
        anchors {
            left: parent.left
            leftMargin: leftPadding
            top: parent.top
            topMargin: topPadding
        }
    }
    Image {
        id: midBit
        source: (landscape) ? "meegotouch-keyboard-function-key-mid-landscape.png"
                            : "meegotouch-keyboard-function-key-mid.png"
        anchors {
            left: leftBit.right
            right: rightBit.left
            top: parent.top
            topMargin: topPadding
        }
    }
    Image {
        id: rightBit
        source: (landscape) ? "meegotouch-keyboard-function-key-right-landscape.png"
                            : "meegotouch-keyboard-function-key-right.png"
        anchors {
            top: parent.top
            topMargin: topPadding
            right: parent.right
            rightMargin: rightPadding
        }
    }
    Image {
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: (leftPadding - rightPadding) / 2
        source: icon
        sourceSize.width: (sourceWidth == -1) ? width : sourceWidth
        sourceSize.height: (sourceHeight == -1) ? height : sourceHeight
    }

    Text {
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: (leftPadding - rightPadding) / 2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: fontSize
        color: UI.TEXT_COLOR
        text: caption
    }
}
