#ifndef UDPRECIEVER_H
#define UDPRECIEVER_H

#include <QObject>
#include <QUdpSocket>
#include <QNetworkDatagram>
#include "jsonconf.h"

class UdpReciever : public QObject
{
    Q_OBJECT

    void init();
    void readDatagram();

public:
    explicit UdpReciever(QObject *parent = nullptr);
    QUdpSocket* m_udp;

    ~UdpReciever() { delete m_udp; }

public Q_SLOTS:

};

#endif // UDPRECIEVER_H
