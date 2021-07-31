#ifndef CLIENT_H
#define CLIENT_H
#include <QDataStream>
#include <QObject>
#include <QTcpSocket>
#include <QTimer>
#include <QHostAddress>
#include <QUdpSocket>
#include <QtConcurrent/QtConcurrent>

class Client : public QObject
{
    Q_OBJECT
    QTcpSocket *tcpSocket = nullptr;
    QDataStream in;
    QString data;
    bool stopThread = false;

public:
    explicit Client( QObject *parent = nullptr );

    ~Client() {
        delete tcpSocket;
    };
Q_SIGNALS:
    void startUDP();

public Q_SLOTS:
    void messageHandler();
    void displayError( QAbstractSocket::SocketError socketError );
    void disconnected();
    void initLoop();
    void udp();
    void test();

};
#endif // CLIENT_H
