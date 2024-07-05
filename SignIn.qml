import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    width: 400
    height: 520
    minimumWidth: 400
    minimumHeight: 520
    maximumHeight: 520
    maximumWidth: 400
    visible: true
    color: "#00000000"
    flags: Qt.Window | Qt.CustomizeWindowHint | Qt.WindowTitleHint | Qt.WindowMinimizeButtonHint

    ColumnLayout {
        width: parent.width
        height: parent.height

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        onWidthChanged: {
            if (width > 400) {
                width = 400
            }
        }

        spacing: 0

        Text {
            color: "white"
            text: qsTr("Sign in")
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pixelSize: 20
            Layout.topMargin: 50
        }

        TextField {
            id: user_name_email
            Layout.preferredWidth: parent.width * .8
            Layout.preferredHeight: 35
            placeholderText: qsTr("Username")
            placeholderTextColor: "aqua"
            color: "Magenta"
            maximumLength: 50

            leftPadding: 20
            rightPadding: 20

            background: Rectangle {
                anchors.fill: parent
                radius: 10
                color: "transparent"
            }

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        TextField {
            id: password
            Layout.preferredWidth: parent.width * .8
            Layout.preferredHeight: 35
            placeholderText: qsTr("Password")
            placeholderTextColor: "aqua"
            color: "Magenta"
            maximumLength: 50

            leftPadding: 20
            rightPadding: 20

            echoMode: TextInput.Password

            background: Rectangle {
                anchors.fill: parent
                radius: 10
                color: "transparent"
            }

            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Rectangle {
            id: login_btn
            Layout.preferredWidth: parent.width * .8
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredHeight: 30
            Layout.bottomMargin: -20
            radius: 10
            color: login_btn_area.containsMouse ? "#1A5FAF" : "white"

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            Text {
                text: "Sign in"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                hoverEnabled: true
                id: login_btn_area
                anchors.fill: parent
            }
        }

        Text {
            id: t_signup
            text: "Don't have an account? Sing up"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            color: "white"

            font.underline: t_signup_am.containsMouse

            Layout.bottomMargin: 50
            MouseArea {
                hoverEnabled: true
                id: t_signup_am
                anchors.fill: parent

                onClicked: {
                    sp.startSignUpProcess()
                }
            }
        }
    }
}
