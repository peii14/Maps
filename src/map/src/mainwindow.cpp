//
// Created by pei on 3/6/21.
//

#include "mainwindow.h"
#include "../../build/map/ui_mainwindow.h"

const double pi = std::acos(-1);

MainWindow::MainWindow(QWidget *parent) :
        QMainWindow(parent),
        ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->quickWidget->rootContext()->setContextProperty("marker_model",&marker_model);
    qDebug()<<QUrl("qrc:/Peta.qml").isEmpty();
    //url nya aneh bgt
    ui->quickWidget->setSource(QUrl(path));
    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &MainWindow::onTimeout);
    timer->start(1000);
    marker_model.setMaxMarkers(5);
    marker_model.moveMarker(QGeoCoordinate(-7.286460463054833, 112.79596433586721));
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::onTimeout()
{
    double x = 15.4561 + 0.01*std::sin(i*pi/24);
    double y = 73.8021 + 0.01*std::cos(i*pi/24);
    QGeoCoordinate next(x, y);
    marker_model.moveMarker(next);
    i++;
}
