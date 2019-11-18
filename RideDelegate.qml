import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.12

Pane {
    id: root
    property var ride
    readonly property string gpsiesUrl: "https://www.gpsies.com/map.do?fileId=%1".arg(ride.id)
    readonly property string gpxUrl: "http://www.gpsies.com/download.do?fileId=%1&filetype=gpxTrk".arg(ride.id)
    Material.elevation: 1
    padding: 0
    contentItem: ColumnLayout {
        spacing: 0
        Label {
            Layout.fillWidth: true
            padding: 16
            font {
                pixelSize: 16
                letterSpacing: 0.15
            }
            text: ride.name.replace(/\[France\]$/, "")
        }
        Image {
            Layout.fillWidth: true
            Layout.preferredHeight: 200
            fillMode: Image.PreserveAspectCrop
            source: "https://n-peloton.fr/gpx/image.php?id=" + root.ride.id
        }
        Row {
            Layout.margins: 8
            spacing: 16
            Button {
                flat: true
                text: "Ouvrir"
                onClicked: Qt.openUrlExternally(root.gpsiesUrl)
            }
            Button {
                padding: 16
                flat: true
                text: "Télécharger"
                onClicked: Qt.openUrlExternally(root.gpxUrl)
            }
        }
    }
}
