import QtQuick 2.0
import QtQuick.Window 2.3
import QtAV 1.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2


Video{
    property bool videoBool: true
    id:root
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.preferredHeight: 325
    volume: 1

    source: "qrc:/videos/Tauler Polibi.mp4"

    Image{
        id: play
        state: "visible"
        width: root.width/2
        height: root.height/2
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/play.png"
        anchors.centerIn: parent


        states: [
            State {
                name: "visible"
                PropertyChanges {
                    target: play
                    opacity: 1
                }
            },
            State {
                name: "invisible"
                PropertyChanges {
                    target: play
                    opacity: 0
                }
            }
        ]
        transitions: [
            Transition {
                from: "visible"
                to: "invisible"
                NumberAnimation{
                    target: play
                    duration: 250
                    property: "opacity"
                    easing.type: Easing.InOutSine
                }

            },
            Transition {
                from: "invisible"
                to: "visible"
                NumberAnimation{
                    target: play
                    duration: 250
                    property: "opacity"
                    easing.type: Easing.InOutSine
                }
            }
        ]
    }

    Image{
        id: pause
        state: "invisible"
        height: (root.height/2)+3
        fillMode: Image.PreserveAspectFit
        source: "qrc:/assets/pause.png"
        anchors.centerIn: parent

        states: [
            State {
                name: "visible"
                PropertyChanges {
                    target: pause
                    opacity: 1
                }
            },
            State {
                name: "invisible"
                PropertyChanges {
                    target: pause
                    opacity: 0
                }
            }
        ]
        transitions: [
            Transition {
                from: "visible"
                to: "invisible"
                NumberAnimation{
                    target: pause
                    duration: 250
                    property: "opacity"
                    easing.type: Easing.InOutSine
                }

            },
            Transition {
                from: "invisible"
                to: "visible"
                NumberAnimation{
                    target: pause
                    duration: 250
                    property: "opacity"
                    easing.type: Easing.InOutSine
                }
            }
        ]
    }

    Timer{
        id: playTimer
        interval: 1000
        onTriggered: play.state = "invisible"
        running: false
    }

    Timer{
        id: pauseTimer
        interval: 1000
        onTriggered: pause.state = "invisible"
        running: false
    }

    MouseArea{
        hoverEnabled: true
        anchors.fill: parent
        onClicked: {
            if(videoBool){
                parent.play()
                videoBool = false
                pause.state = "visible"
                play.state = "invisible"
                pauseTimer.running = true;
            }
            else{
                parent.pause()
                videoBool = true
                pause.state = "invisible"
                play.state = "visible"
                playTimer.running = true;
            }
        }

        Slider{
            id: slider
            width: root.width
            anchors.bottom: parent.bottom
            from: 0
            to: root.duration
            value: root.position
            onMoved: {
                root.seek(slider.value)
            }
        }
        onDoubleClicked: {
            var component = Qt.createComponent("VideoVentana.qml")
            var window    = component.createObject(root);
            window.show()
        }
    }
}





