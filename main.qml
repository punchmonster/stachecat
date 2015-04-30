import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import "CatGenerator.js" as CatGen

ApplicationWindow {
    title: qsTr("Hello World")
    width: Screen.width
    height: Screen.width
    visible: true

    property real defaultSize: Screen.width / 2.5

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Open")
                onTriggered: messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
            MenuItem {
                text: qsTr("&New cat")
                onTriggered: {
                    onClicked: {
                        CatGen.component.destroy(1000);
                        CatGen.fetchCatBackground();
                    }
                }
            }
        }
    }

    MainForm {
        id: backgroundParent
        anchors.fill: parent

        Rectangle {
            id: photoFrame
            width: image.width * image.scale
            height: image.height * image.scale
            color: "transparent"
            smooth: true
            antialiasing: true
            x: Screen.width / 2 - defaultSize / 2
            y: Screen.height - defaultSize
            z: 200
            rotation: Math.random() * 13 - 6
            Image {
                id: image
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                source: "https://a.pomf.se/qsjwte.png"
                scale: defaultSize / Math.max(sourceSize.width, sourceSize.height)
            }
            PinchArea {
                anchors.fill: parent
                pinch.target: photoFrame
                pinch.minimumRotation: -360
                pinch.maximumRotation: 360
                pinch.minimumScale: 0.1
                pinch.maximumScale: 10
                MouseArea {
                    id: dragArea
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: photoFrame
                    onWheel: {
                        if (wheel.modifiers & Qt.ControlModifier) {
                            photoFrame.rotation += wheel.angleDelta.y / 120 * 5;
                            if (Math.abs(photoFrame.rotation) < 4)
                                photoFrame.rotation = 0;
                        } else {
                            photoFrame.rotation += wheel.angleDelta.x / 120;
                            if (Math.abs(photoFrame.rotation) < 0.6)
                                photoFrame.rotation = 0;
                            var scaleBefore = image.scale;
                            image.scale += image.scale * wheel.angleDelta.y / 120 / 10;
                            photoFrame.x -= image.width * (image.scale - scaleBefore) / 2.0;
                            photoFrame.y -= image.height * (image.scale - scaleBefore) / 2.0;
                        }
                    }
                }
            }
        }

        Component.onCompleted: {
            CatGen.fetchCatBackground();
        }

        MessageDialog {
            id: messageDialog
            title: qsTr("May I have your attention, please?")

            function show(caption) {
                messageDialog.text = caption;
                messageDialog.open();
            }
        }
    }
}
