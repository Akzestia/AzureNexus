import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


/*
    W 83.33% {
        Top 90.63% | H 8.33%
        Left 18.75%
        Middle 48.44% | 46.88% H
        Right 20.31%
    }
    TextAreaH 5.56%
*/
ApplicationWindow {
    width: setWidth
    height: screenHeight
    minimumWidth: 720
    minimumHeight: 410
    visible: true
    title: qsTr("Hello World")
    color: ColorsConfig.backgroundDarkest
    visibility: "FullScreen"
    id: mainWindow

    onWidthChanged: {
        console.log(width)
    }

    Rectangle {
        id: contentItem
        Layout.fillWidth: true
        implicitHeight: grid.implicitHeight
        implicitWidth: grid.implicitWidth

        Image {
            anchors.fill: parent
            source: "file:///home/azure/Downloads/hCxW040.jpeg" // Replace with the path to your image
            fillMode: Image.PreserveAspectCrop // Adjust the fill mode as per your requirement
        }

        GridLayout {
            anchors.fill: parent
            id: grid
            columnSpacing: receiver_profile.visible ? 20 : 15
            columns: 3
            anchors {
                leftMargin: 12
                topMargin: 12
                rightMargin: 12
                bottomMargin: 0
            }

            Rectangle {
                id: xuxu
                Layout.row: 0
                Layout.column: 0
                Layout.columnSpan: 3
                color: ColorsConfig.backgroundDarker
                radius: 10
                implicitWidth: parent.width
                implicitHeight: 60
                Layout.topMargin: 4
                Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            }
            Rectangle {
                Layout.row: 1
                Layout.column: 0
                Layout.minimumWidth: 170
                color: ColorsConfig.backgroundDarker
                radius: 10
                Layout.preferredWidth: parent.width * .1975
                Layout.topMargin: 4
                Layout.preferredHeight: mainWindow.height - xuxu.height - 14
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            }
            Rectangle {
                Layout.row: 1
                Layout.column: 1
                Layout.columnSpan: receiver_profile.visible ? 1 : 2
                color: ColorsConfig.mainBlueDark
                radius: 10
                Layout.preferredWidth: parent.width * .5174
                Layout.fillWidth: true
                Layout.topMargin: 4
                Layout.preferredHeight: mainWindow.height - xuxu.height - 14
                Layout.alignment: Qt.AlignTop | Qt.AlignCenter
                opacity: .8
            }
            Rectangle {
                id: receiver_profile
                Layout.row: 1
                Layout.column: 2
                color: "transparent"
                radius: 10
                implicitWidth: parent.width * .2431
                Layout.topMargin: 4
                Layout.preferredHeight: mainWindow.height - xuxu.height - 14
                Layout.alignment: Qt.AlignTop | Qt.AlignRight
                bottomLeftRadius: 0
                bottomRightRadius: 0
                visible: mainWindow.width > 1000 ? true : false

                Rectangle {
                    id: user_info
                    Layout.fillWidth: true
                    implicitHeight: user_info_grid.implicitHeight
                    implicitWidth: user_info_grid.implicitWidth
                    color: "transparent"

                    GridLayout {
                        anchors.fill: parent
                        id: user_info_grid
                        columnSpacing: receiver_profile.visible ? 20 : 15
                        columns: 3
                        anchors {
                            leftMargin: 0
                            topMargin: 0
                            rightMargin: 0
                            bottomMargin: 0
                        }

                        Rectangle {
                            Layout.row: 0
                            id: banner_wrapper
                            radius: 10
                            color: ColorsConfig.mainBlueDark
                            implicitHeight: receiver_profile.height * .2345
                            implicitWidth: receiver_profile.width
                            bottomLeftRadius: 0
                            bottomRightRadius: 0
                        }

                        Rectangle {
                            Layout.row: 1
                            id: avatar_wrapper
                            radius: 300
                            color: ColorsConfig.backgroundDarkest
                            Layout.preferredHeight: banner_wrapper.height
                            Layout.preferredWidth: banner_wrapper.height
                            Layout.topMargin: -banner_wrapper.height * .5
                            Layout.alignment: Qt.AlignHCenter
                            clip: true

                            ShaderEffect {}

                            AnimatedImage {
                                id: svgImage
                                width: parent.width - 45
                                height: parent.height - 45
                                z: 1
                                anchors.centerIn: parent
                                source: "file:///home/azure/Downloads/1dTC.gif"

                                ShaderEffect {
                                    anchors.fill: parent
                                    fragmentShader: "RoundImageShader.frag"
                                    property real radius: 0.1
                                    property variant sourceTexture: ShaderEffectSource {
                                        sourceItem: svgImage
                                    }
                                }
                            }
                        }
                    }
                }

                Flickable {
                    width: parent.width
                    height: parent.height
                    contentWidth: width
                    contentHeight: gx.implicitHeight
                    clip: true
                    //boundsBehavior: Flickable.StopAtBounds
                    LayoutItemProxy {
                        id: gx
                        width: parent.width
                        height: implicitHeight
                        target: user_info
                    }
                }
            }
        }
    }

    RowLayout {
        id: smallLayout
        anchors.fill: parent
        Rectangle {
            id: contacts_wrapper
            implicitWidth: 65
            implicitHeight: parent.height
            color: ColorsConfig.backgroundDarker

            Rectangle {
                height: 7
                width: 7
                radius: 50
                anchors {
                    left: parent.left
                }
                color: "white"
                x: 3 // Adjust this value to place the dot on the left of the item
                y: contacts.currentItem ? contacts.currentItem.y + 27 : 27
                Behavior on y {
                    SpringAnimation {
                        spring: 2
                        damping: 0.1
                    }
                }
            }
            ListView {
                width: 65
                spacing: 20
                anchors.fill: parent
                anchors.leftMargin: 12.5
                anchors.topMargin: 10
                anchors.horizontalCenter: contacts_wrapper.horizontalCenter
                interactive: false
                id: contacts
                focus: true

                model: ListModel {
                    ListElement {
                        color: "lightblue"
                    }
                    ListElement {
                        color: "lightgreen"
                    }
                    ListElement {
                        color: "lightcoral"
                    }
                    ListElement {
                        color: "lightgreen"
                    }
                    ListElement {
                        color: "lightcoral"
                    }
                }

                delegate: Loader {
                    width: 40
                    height: 40

                    sourceComponent: {

                        switch (index) {
                        case 0:
                            return firstDelegateComponent
                        case contacts.model.count - 1:
                            return lastDelegateComponent
                        default:
                            return defaultDelegateComponent
                        }
                    }

                    Component {
                        id: firstDelegateComponent

                        Rectangle {
                            width: 40
                            height: 40
                            color: "transparent"
                            border.width: 1
                            border.color: "transparent"
                            radius: 10
                            clip: false

                            Rectangle {
                                width: 40
                                height: 1
                                color: "white"
                                clip: false // Do not clip this rectangle
                                anchors {
                                    horizontalCenter: parent.horizontalCenter
                                    bottom: parent.bottom
                                    bottomMargin: -10
                                }
                            }

                            Component.onCompleted: {
                                console.log("Delegate created for index: " + index)
                            }

                            Rectangle {
                                id: container
                                color: contacts.currentIndex == index ? ColorsConfig.mainBlueDark : ColorsConfig.backgroundDarkGray
                                width: parent.width
                                height: parent.height
                                radius: parent.radius
                                clip: true

                                Connections {
                                    target: contacts
                                    onCurrentIndexChanged: {
                                        console.log("Current index changed to: "
                                                    + contacts.currentIndex)
                                    }
                                }

                                Image {
                                    width: parent.width * .5
                                    height: parent.width * .5
                                    z: 1
                                    anchors.centerIn: parent
                                    source: "file:///home/azure/Downloads/Vector.svg"
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    contacts.currentIndex = index
                                }
                            }
                        }
                    }

                    Component {
                        id: lastDelegateComponent
                        Rectangle {
                            width: 40
                            height: 40
                            color: "transparent"
                            border.width: 1
                            border.color: "transparent"
                            radius: 50
                            clip: false

                            Component.onCompleted: {
                                console.log("Delegate created for index: " + index)
                            }

                            Rectangle {
                                width: 40
                                height: 1
                                color: "white"
                                clip: false // Do not clip this rectangle
                                anchors {
                                    horizontalCenter: parent.horizontalCenter
                                    top: parent.top
                                    topMargin: -10
                                }
                            }

                            Rectangle {
                                id: container
                                color: contacts.currentIndex == index ? ColorsConfig.mainBlueDark : ColorsConfig.backgroundDarkGray
                                width: parent.width
                                height: parent.height
                                radius: parent.radius
                                clip: true

                                Connections {
                                    target: contacts
                                    onCurrentIndexChanged: {
                                        console.log("Current index changed to: "
                                                    + contacts.currentIndex)
                                    }
                                }

                                Image {
                                    z: 1
                                    width: parent.width * .5
                                    height: parent.width * .5
                                    anchors.centerIn: parent
                                    source: "file:///home/azure/Downloads/Vector(1).svg"
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    contacts.currentIndex = index
                                }
                            }
                        }
                    }

                    Component {
                        id: defaultDelegateComponent
                        Rectangle {
                            width: 40
                            height: 40
                            color: "transparent"
                            border.width: 1
                            border.color: "transparent"
                            radius: 10
                            clip: true

                            Component.onCompleted: {
                                console.log("Delegate created for index: " + index)
                            }

                            Rectangle {
                                id: container
                                color: contacts.currentIndex == index ? ColorsConfig.mainBlueDark : ColorsConfig.backgroundDarkGray
                                width: parent.width
                                height: parent.height
                                radius: parent.radius
                                clip: true

                                Connections {
                                    target: contacts
                                    onCurrentIndexChanged: {
                                        console.log("Current index changed to: "
                                                    + contacts.currentIndex)
                                    }
                                }

                                // AnimatedImage {
                                //     id: svgImage
                                //     width: parent.width - 5
                                //     height: parent.height - 5
                                //     z: 1
                                //     anchors.centerIn: parent
                                //     source: "file:///home/azure/Downloads/ShinkaY.gif"
                                // }

                                // PaddedRectangle {
                                //     id: wrapperx
                                //     anchors.fill: parent
                                //     z: 2
                                //     color: "transparent"
                                //     radius: 75
                                //     border.width: 5
                                //     border.color: contacts.currentIndex == index ? ColorsConfig.mainBlueDark : ColorsConfig.backgroundDarkGray
                                //     padding: 0
                                // }
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    contacts.currentIndex = index
                                }
                            }
                        }
                    }
                }
            }
        }

        Flickable {
            Layout.fillHeight: true
            Layout.fillWidth: true
            contentWidth: width
            contentHeight: gl.implicitHeight
            clip: true
            boundsBehavior: Flickable.StopAtBounds
            LayoutItemProxy {
                id: gl
                width: parent.width
                height: implicitHeight
                target: contentItem
            }
        }
    }
}
