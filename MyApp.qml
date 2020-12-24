import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtGraphicalEffects 1.0
import ArcGIS.AppFramework 1.0

import "view"
import "assets"
import "widgets"
import "model"
import "controller"


App{
    id: app
    width: parent.width
    height: parent.height

    property bool lightTheme: true
    property int menuCurrentIndex: 0

    // App color properties
    readonly property color primaryColor:"#3F51B5"
    readonly property color accentColor: Qt.lighter(primaryColor,1.2)
    readonly property color appBackgroundColor: lightTheme? "#FAFAFA":"#303030"
    readonly property color appDialogColor: lightTheme? "#FFFFFF":"424242"
    readonly property color appPrimaryTextColor: lightTheme? "#000000":"#FFFFFF"
    readonly property color appSecondaryTextColor: Qt.darker(appPrimaryTextColor)
    readonly property color headerTextColor:"#FFFFFF"
    readonly property color listViewDividerColor:"#19000000"


    // App size properties

    property real scaleFactor: AppFramework.displayScaleFactor
    readonly property real baseFontSize: app.width<450*app.scaleFactor? 21 * scaleFactor:23 * scaleFactor
    readonly property real titleFontSize: app.baseFontSize
    readonly property real subtitleFontSize: 1.1 * app.baseFontSize
    readonly property real captionFontSize: 0.6 * app.baseFontSize   

    Component.onCompleted: {
        dataModel.initDatabase()
    }

    DataModelController{
        id: controller
    }

    DataModel {
        id: dataModel
        dispatcher: controller
    }

    Loader{
        id: loader
        anchors.fill: parent
        sourceComponent: homePageView
    }

    Rectangle{
        id: mask
        anchors.fill: parent
        color: "black"
        opacity: drawer.position*0.54
        Material.theme: app.lightTheme ? Material.Light : Material.Dark
    }
    Drawer {
        id: drawer
        width: Math.min(parent.width, parent.height, 600*app.scaleFactor) * 0.80
        height: parent.height
        Material.elevation: 16
        Material.background: app.appDialogColor

        edge: Qt.LeftEdge
        dragMargin: 0
        contentItem: SideMenuPanel{
            currentIndex: menuCurrentIndex
            menuModel: drawerModel
            onMenuSelected: {
                drawer.close();
                switch(action){
                case "page1":
                    loader.sourceComponent = homePageView;
                    break;
                default:
                    break;
                }
            }
        }

    }

    ListModel{
        id: drawerModel
        ListElement {action:"page1"; type: "delegate"; name: qsTr("Home"); iconSource: ""}
        ListElement {action:""; type: "divider"; name: ""; iconSource: ""}

    }

    StackView {
        id: mainStackView
        anchors.fill: parent
        initialItem: homePageView
    }

    Component{
        id: homePageView
        HomePage{
            onOpenMenu: {
                drawer.open();
            }
            onAddTodo: {
                mainStackView.push(notesDetailsPageView)
            }
            onUpdateTodo: {
                console.log(updateTitle, updateNotes)
                mainStackView.push(notesDetailsPageView, {notesIndex: updateIndex, titleText: updateTitle, descText: updateNotes});
                controller.readImagePath(updateIndex);
            }
        }
    }

    Component{
        id: notesDetailsPageView
        NotesDetailsPage{

            onOpenMenuFromDetails: {
                drawer.open();
            }
            onDiscard: {
                mainStackView.pop();
            }
            onSaveTodo: {
                mainStackView.pop();
            }
        }
    }
}






