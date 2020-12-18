/* Copyright 2020 Esri
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */


// You can run your app in Qt Creator by pressing Alt+Shift+R.
// Alternatively, you can run apps through UI using Tools > External > AppStudio > Run.
// AppStudio users frequently use the Ctrl+A and Ctrl+I commands to
// automatically indent the entirety of the .qml file.


import QtQuick 2.13
import QtQuick.Layouts 1.13
import QtQuick.Controls 2.13
import QtQuick.Controls.Material 2.13
import QtGraphicalEffects 1.0
import "./view"
import "./assets"
import "./controller"
import "./model"

import ArcGIS.AppFramework 1.0

App{
    id: app
    width: 421
    height: 750

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

    // Load Page1 as your default page
    Loader{
        id: loader
        anchors.fill: parent
        sourceComponent: page1ViewPage
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
                    loader.sourceComponent = page1ViewPage;
                    break;
                case "about":
                    loader.sourceComponent = aboutViewPage;
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
        ListElement {action:"about"; type: "delegate"; name: qsTr("About"); iconSource: ""}

    }

    Component{
        id: page1ViewPage
        HomePage{
            titleText: qsTr("Home")
            descText: qsTr("This is page 1")
            onOpenMenu: {
                drawer.open();
            }
        }
    }

    Component{
        id: aboutViewPage
        AboutPage{
            titleText: qsTr("About")
            descText: qsTr("This is an about page")
            onOpenMenu: {
                drawer.open();
            }
        }
    }
}






