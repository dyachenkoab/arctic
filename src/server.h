#ifndef SERVER_H
#define SERVER_H

#include "jsonconf.h"
#include <QDebug>
#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>

class Server : public QObject
{
    Q_OBJECT

    JsonConf m_json;
    QTcpServer *m_tcpServer;
    int m_enableKeepAlive = 1;

    void initServer();

public:
    explicit Server( QObject *parent = nullptr );
    QTcpSocket *m_socket;

    ~Server()
    {
        delete m_tcpServer;
        delete m_socket;
    }

public Q_SLOTS:
    void newConnection();
    bool sendString( const QString str );
    void displayError( QAbstractSocket::SocketError socketError );
    void test();
    void nullingSocket();
    QString getCamPipe( const QString shackCam );
};

#endif // SERVER_H
