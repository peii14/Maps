
import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.6

MapQuickItem{
    id: marker
    anchorPoint.x: marker.width / 4
    anchorPoint.y: marker.height

    sourceItem: Image{
        id: icon
        source: "images/Tutut.png"
        sourceSize.width: 50
        sourceSize.height: 50
    }
}
