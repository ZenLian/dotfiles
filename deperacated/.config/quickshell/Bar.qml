import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.components

// 每个 screen 生成一个 PanelWindow
Variants {
    model: Quickshell.screens;

    PanelWindow {
        required property var modelData
        screen: modelData

        anchors {
            bottom: true
            left: true
            right: true
        }
        implicitHeight: 30
        color: Qt.rgba(0,0,0,0) // 全透明

        // 背景
        WrapperRectangle {
            anchors.fill: parent
            margin: 4
            radius: 8
            color: "#80ffffff"
            // 3 列布局
            RowLayout {
                spacing: 10
                // 左
                WrapperRectangle {
                    color: "red"
                    radius: 10
                    leftMargin: 4
                    rightMargin: 4
                    // implicitWidth: 400
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft
                    RowLayout {
                        Rectangle {
                            width: 18
                            height: width
                            radius: width / 2
                        }
                        Rectangle {
                            width: 18
                            height: width
                            radius: width / 2
                        }
                        Rectangle {
                            width: 18
                            height: width
                            radius: width / 2
                        }
                    }
                }
                // 中
                WrapperRectangle {
                    color: "green"
                    radius: 10
                    // width: 100
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                }
                // 右 
                WrapperRectangle {
                    color: "blue"
                    radius: 10
                    width: 400
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight
                }
            }
        }
    }
}
