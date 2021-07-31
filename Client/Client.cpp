#include "Client.h"

Client::Client( QObject *parent ) : QObject( parent )
{
    QFuture<void> future = QtConcurrent::run(this, &Client::udp);
    initLoop();
}

void Client::initLoop()
{
    tcpSocket = new QTcpSocket( this );
    int ms = 500;
    struct timespec ts = { ms / 1000, ( ms % 1000 ) * 1000 * 1000 };

    while ( true ) {
        qDebug() << "another round";
        tcpSocket->connectToHost( QHostAddress( "192.168.1.204" ), 17000 );
        if ( tcpSocket->state() == QAbstractSocket::ConnectingState ) {
            qDebug() << "inside first IF";
            tcpSocket->waitForConnected( 5000 );
            if ( tcpSocket->state() == QAbstractSocket::ConnectedState ) {
                qDebug() << "inside second IF";
                connect( tcpSocket, &QTcpSocket::disconnected, tcpSocket, &QObject::deleteLater );
                connect( tcpSocket, &QTcpSocket::disconnected, this, &Client::disconnected );
                connect( tcpSocket, &QTcpSocket::disconnected, this, [=](){ stopThread = true; } );
                connect( tcpSocket, &QTcpSocket::readyRead, this, &Client::messageHandler );
                connect( tcpSocket, QOverload<QAbstractSocket::SocketError>::of( &QAbstractSocket::error ), this,
                     &Client::displayError );
                break;
            }
        }
        nanosleep( &ts, NULL );
    }

//    emit startUDP();
}

void Client::udp()
{
    int ms = 500;
    struct timespec ts = { ms / 1000, ( ms % 1000 ) * 1000 * 1000 };

    while ( !stopThread ) {
        QUdpSocket u;
        u.writeDatagram( QString( "Take that" ).toLocal8Bit(), QHostAddress( "192.168.1.204" ), 18000 );
        qDebug() << "datagram sended";
        nanosleep( &ts, NULL );
    }

}

void Client::test()
{
    stopThread = true;
    qDebug() << "OUT OF UDP LOOP";
}

void Client::disconnected()
{
    qDebug() << "DISCONNECTED";
    delete tcpSocket;
    initLoop();
}

void Client::messageHandler()
{
    QByteArray data = tcpSocket->readAll();
    qDebug() << data;
}

void Client::displayError( QAbstractSocket::SocketError socketError )
{
    switch ( socketError ) {
        case QAbstractSocket::RemoteHostClosedError:
            qDebug() << "The Host closed his connection";
            break;
        case QAbstractSocket::HostNotFoundError:
            qDebug() << "The host was not found. Please check the host name and port settings.";
            break;
        case QAbstractSocket::ConnectionRefusedError:
            qDebug() << "The connection was refused by the peer. Make sure the fortune server is running, and check that the host name "
                    "and port settings are correct.";
            break;
        default:
            qDebug() << QString( "The following error occurred: %1." ).arg( tcpSocket->errorString() );
    }
}
