//
// Created by pei on 3/6/21.
//

#ifndef MAP_MARKER_H
#define MAP_MARKER_H

#include <QAbstractListModel>
#include <QtPositioning/QGeoCoordinate>

#include <QAbstractListModel>

class Marker : public QAbstractListModel
{
Q_OBJECT
    Q_PROPERTY(QGeoCoordinate current READ current NOTIFY currentChanged)
public:
    enum MarkerModel{
        PositionRole = Qt::UserRole + 1000,
    };
    explicit Marker(QObject *parent = nullptr);
    void moveMarker(const QGeoCoordinate & coordinate);
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    int maxMarkers() const;
    void setMaxMarkers(int maxMarkers=0);
    QGeoCoordinate current() const;
signals:
    void currentChanged();
private:
    void insert(int row, const QGeoCoordinate & coordinate);
    void removeLastMarker();
    QList<QGeoCoordinate> m_markers;
    QGeoCoordinate m_current;
    int m_maxMarkers;
};


#endif //MAP_MARKER_H
