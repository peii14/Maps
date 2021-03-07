//
// Created by pei on 3/6/21.
//

#ifndef MAP_MAINWINDOW_H
#define MAP_MAINWINDOW_H
#include "marker.h"

#include "QtPositioning/QGeoCoordinate"
#include <QMainWindow>
#include "QtQml/QQmlContext"
#include <QTimer>
#include <cmath>
namespace Ui {
    class MainWindow;
}
class MainWindow : public QMainWindow
{
Q_OBJECT
public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private Q_SLOTS:
    void onTimeout();
private:
    Ui::MainWindow *ui;
    Marker marker_model;
    int i = 0;
    QString path = "src/map/src/Peta.qml";
};
#endif //MAP_MAINWINDOW_H
