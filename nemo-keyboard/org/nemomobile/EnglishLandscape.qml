/*
 * This file is part of Maliit Plugins
 *
 * Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies). All rights reserved.
 *
 * Contact: Mohammad Anwari <Mohammad.Anwari@nokia.com>
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

Column {
    id: keyArea

    width: UI.LANDSCAPE_WIDTH
    height: UI.LANDSCAPE_HEIGHT

    property bool isShifted
    property bool isShiftLocked
    property bool inSymView
    property bool inSymView2

    property variant row1:["q1€", "w2£", "e3$", "r4¥", "t5₹", "y6%", "u7<", "i8>", "o9[", "p0]"]
    property variant row2: ["a*`", "s#^", "d+|", "f-_", "g=§", "h({", "j)}", "k?¿", "l!¡"]
    property variant row3: ["z@«", "x~»", "c/\"", "v\\“", "b'”", "n;„", "m:&"]
    property variant accents_row1: ["", "", "eèéêë", "", "tþ", "yý", "uûùúü", "iîïìí", "oöôòó", ""]
    property variant accents_row2: ["aäàâáãå", "", "dð", "", "", "", "", "", ""]
    property variant accents_row3: ["", "", "cç", "", "", "nñ", ""]

    property int topPadding: UI.landscapeVerticalPadding
    property int bottomPadding: UI.landscapeVerticalPadding
    property int leftPadding: UI.landscapeHorizontalPadding
    property int rightPadding: UI.landscapeHorizontalPadding
    property int keyHeight: UI.landscapeHeight

    Row { //Row 1
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater {
            model: row1
            LandscapeCharacterKey {
                sizeType: "tasto.png"
                pressedImage: "tasto_premuto.png"
                caption: row1[index][0]
                captionShifted: row1[index][0].toUpperCase()
                symView: row1[index][1]
                symView2: row1[index][2]
                accents: isShifted ? accents_row1[index].toUpperCase() : accents_row1[index]
            }
        }
    } //end Row1

    Row { //Row 2
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater {
            model: row2
            LandscapeCharacterKey {
                sizeType: "tasto.png"
                pressedImage: "tasto_premuto.png"
                caption: row2[index][0]
                captionShifted: row2[index][0].toUpperCase()
                symView: row2[index][1]
                symView2: row2[index][2]
                accents: isShifted ? accents_row2[index].toUpperCase(): accents_row2[index]
            }
        }
    } //end Row2

    Row { //Row 3
        anchors.horizontalCenter: parent.horizontalCenter

        ShiftKey {
            width: 145
            height: keyHeight
            topPadding: keyArea.topPadding
            leftPadding: keyArea.leftPadding
            rightPadding: keyArea.rightPadding
            bottomPadding: keyArea.bottomPadding
            landscape: true
        }

        Repeater {
            model: row3
            LandscapeCharacterKey {
                sizeType: "tasto.png"
                pressedImage: "tasto_premuto.png"
                caption: row3[index][0]
                captionShifted: row3[index][0].toUpperCase()
                symView: row3[index][1]
                symView2: row3[index][2]
                accents: isShifted ? accents_row3[index].toUpperCase(): accents_row3[index]
            }
        }

        BackspaceKey {
            width: 145
            height: keyHeight
            topPadding: keyArea.topPadding
            leftPadding: keyArea.leftPadding
            rightPadding: keyArea.rightPadding
            bottomPadding: keyArea.bottomPadding

            landscape: true
        }
    } //end Row3

    Row { //Row 4
        anchors.horizontalCenter: parent.horizontalCenter

        SymbolKey {
            width: 145
            height: keyHeight
            landscape: true
            topPadding: keyArea.topPadding
            leftPadding: keyArea.leftPadding
            rightPadding: keyArea.rightPadding
            bottomPadding: keyArea.bottomPadding
        }

        LandscapeCharacterKey {
            caption: ","
            captionShifted: ","
            sizeType: "tasto.png"
            pressedImage: "tasto_premuto.png"
        }

        LandscapeCharacterKey {
            width: 480
            caption: " "
            captionShifted: " "
            showPopper: false
            sizeType: "spazio.png"
            pressedImage: "spazio_premuto.png"
        }

        LandscapeCharacterKey {
            caption: "."
            captionShifted: "."
            sizeType: "tasto.png"
            pressedImage: "tasto_premuto.png"
        }

        EnterKey {
            width: 145
            height: keyHeight
            topPadding: keyArea.topPadding
            leftPadding: keyArea.leftPadding
            rightPadding: keyArea.rightPadding
            bottomPadding: keyArea.bottomPadding
            landscape: true
        }
    } //end Row4
}

