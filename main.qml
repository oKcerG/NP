import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: root
    visible: true; width: 640; height: 480
    Material.primary: "#CC5378"
    color: "#EEE"
    property var rides
    function updateRides() {
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                root.rides = xhr.responseText.trim().split('\n').map(line => {
                    const parts = line.split(';');
                    return { "id": parts[0], "name": parts[1] };
                });
            }
        };
        xhr.open("GET", "https://n-peloton.fr/getMapCsv.php");
        xhr.send();
    }
    Component.onCompleted: updateRides();
    header: Pane {
        Material.elevation: 1
        Material.background: Material.primary
        Material.theme: Material.Dark
        contentItem: Label {
            text: "N-Peloton"
            font {
                pixelSize: 20
                weight: Font.Medium
                letterSpacing: 0.15
            }
        }
    }
    ListView {
        id: listView
        anchors.fill: parent
        topMargin: 16
        bottomMargin: 16
        model: root.rides
        spacing: 16
        delegate: RideDelegate {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 32
            ride: modelData
        }
    }
}
