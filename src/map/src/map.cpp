//
// Created by pei on 3/6/21.
//
#include "mainwindow.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    MainWindow w;
//    w.resize(1000, 500);
    w.show();
    return app.exec();
}
