import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import ArcGIS.AppFramework 1.0
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.12

import "../widgets"

Page {
    id:page

    signal openMenu();
    signal addTodo();
    signal updateTodo(int updateIndex, string updateTitle, string updateNotes)

    property var descText

    Component.onCompleted: {
        console.log('starting');
    }


    header: ToolBar{
        contentHeight: 56*app.scaleFactor
        Material.primary: "#303740"
        RowLayout {
            anchors.fill: parent
            spacing: 0

            CustomHorizontalSpacing{
                size: 4
            }

            ToolButton {
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    source: "../assets/menu.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                }
                onClicked: {
                    openMenu();
                }
            }

            CustomHorizontalSpacing{
                size: 15
            }

            CustomTitle{
                text: "Home"
                fontSize: 16
            }

            ToolButton {
                indicator: Image{
                    width: parent.width*0.5
                    height: parent.height*0.5
                    anchors.centerIn: parent
                    horizontalAlignment: Qt.AlignRight
                    verticalAlignment: Qt.AlignVCenter
                    source: "../assets/plus.png"
                    fillMode: Image.PreserveAspectFit
                    mipmap: true
                }
                onClicked:{
                    addTodo();
                }
            }
        }
    }

    Rectangle{
        color: "#262626"
        anchors.fill: parent

        ListView{
            id: listView
            width: parent.width
            height: parent.height

            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            spacing: 5

            model: dataModel.listModel
            delegate: RoundedListItem{
                title: titleText
                details: notesText
                index: id
            }
        }
    }
}
