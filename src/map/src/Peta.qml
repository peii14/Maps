import QtQuick 2.0
import QtQuick.Window 2.0
import QtLocation 5.6
import QtPositioning 5.6


Rectangle {
            //width: 1500
            //height: 1000
            visible: true
            //Components
            Component{
                id: mapCircleComponent
                MapCircle{
                    radius: 1
                    color: 'red'
                    border.color: 'black'
                }
            }


            Plugin {
                id: mapPlugin
                name: "osm"
                // "mapboxgl", "esri", ...
                // PluginParameter { name: "osm.mapping.offline.directory"; value: "//offlinemaps directory" }
                PluginParameter { name: "osm.useragent"; value: "My great Qt OSM application" }
                PluginParameter { name: "osm.mapping.host"; value: "http://osm.tile.server.address/" }
                PluginParameter { name: "osm.mapping.copyright"; value: "All mine" }
                PluginParameter { name: "osm.routing.host"; value: "http://osrm.server.address/viaroute" }
                PluginParameter { name: "osm.geocoding.host"; value: "http://geocoding.server.address" }
                }

            Map {
                id: mapview

                anchors.fill: parent
                plugin: mapPlugin
                center: QtPositioning.coordinate(-7.286460463054833, 112.79596433586721) // danau 8
                zoomLevel: 20

                gesture.enabled: true
                gesture.acceptedGestures: MapGestureArea.PinchGesture | MapGestureArea.PanGesture


                property int markerCounter: 0 // counter for total amount of markers. Resets to 0 when number of markers = 0
                property int currentMarker
                property int lastX : -1
                property int lastY : -1
                property int pressX : -1
                property int pressY : -1
                property int jitterThreshold : 10

                    // ---------------------------------

                MapItemView {
                    model: searchModel
                    delegate: MapQuickItem {
                        coordinate: place.location.coordinate

                        anchorPoint.x: image.width * 0.5
                        anchorPoint.y: image.height

                        sourceItem: Column {
                            Image { id: image; source: "../images/marker.png" }
                            Text { text: "apa"; font.bold: true }
                                            }
                                            }
                            }

                        MouseArea {
                        id: mouseArea
                        property variant lastCoordinate
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton

                        onPressed : {
                            mapview.lastX = mouse.x
                            mapview.lastY = mouse.y
                            mapview.pressX = mouse.x
                            mapview.pressY = mouse.y
                            lastCoordinate = mapview.toCoordinate(Qt.point(mouse.x, mouse.y))
                        }

                        onPositionChanged: {
                            if (mouse.button == Qt.LeftButton) {
                                mapview.lastX = mouse.x
                                mapview.lastY = mouse.y
                            }
                        }

                        onDoubleClicked: {
                            var mouseGeoPos = mapview.toCoordinate(Qt.point(mouse.x, mouse.y));
                            var preZoomPoint = mapview.fromCoordinate(mouseGeoPos, false);
                            if (mouse.button === Qt.LeftButton) {
                                mapview.zoomLevel = Math.floor(mapview.zoomLevel + 1)
                            } else if (mouse.button === Qt.RightButton) {
                                mapview.zoomLevel = Math.floor(mapview.zoomLevel - 1)
                            }
                            //mapview and map
                            var postZoomPoint = mapview.fromCoordinate(mouseGeoPos, false);
                            var dx = postZoomPoint.x - preZoomPoint.x;
                            var dy = postZoomPoint.y - preZoomPoint.y;

                            var mapCenterPoint = Qt.point(mapview.width / 2.0 + dx, mapview.height / 2.0 + dy);
                            mapview.center = mapview.toCoordinate(mapCenterPoint);

                            lastX = -1;
                            lastY = -1;
                                        }

                        onPressAndHold:{

                            var coordinate = mapview.toCoordinate(Qt.point(mouse.x,mouse.y))
                            var circle = mapCircleComponent.createObject(mapview,{"center.latitude": coordinate.latitude,"center.longitude": coordinate.longitude});
                            mapview.addMapItem(circle);

                            console.log(coordinate);

                            if(mouse.button === Qt.RightButton){


                                }

                            }

                        }
            }
}


