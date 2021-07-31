#include "server.h"
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <sys/socket.h>

Server::Server( QObject *parent ) : QObject( parent )
{
    initServer();
}

void Server::initServer()
{

    m_tcpServer = new QTcpServer( this );

    m_json.openConfig();
    int port = m_json.getParametr( "tcpPort" ).toInt();

    connect( Server::m_tcpServer, &QTcpServer::newConnection, this,
         &Server::newConnection );

    if ( !m_tcpServer->listen( QHostAddress::Any, port ) ) {
        qDebug() << "can't start server";
    } else {
        qDebug() << "server started successfully";
    }
}

QString Server::getCamPipe( const QString shackCam )
{
    return m_json.getParametr( shackCam ).toString();
}

void Server::newConnection()
{
    m_socket = m_tcpServer->nextPendingConnection();
    connect( m_socket, &QTcpSocket::disconnected, m_socket, &QObject::deleteLater );
    connect( m_socket, &QTcpSocket::disconnected, this, &Server::nullingSocket );
    connect( m_socket, QOverload<QAbstractSocket::SocketError>::of( &QAbstractSocket::error ),
         this, &Server::displayError );

    int fd = m_socket->socketDescriptor(); // configure raw sockets for a short life
    setsockopt( fd, SOL_SOCKET, SO_KEEPALIVE, &m_enableKeepAlive,
            sizeof( m_enableKeepAlive ) );

    int maxIdle = 10; // seconds
    setsockopt( fd, IPPROTO_TCP, TCP_KEEPIDLE, &maxIdle,
            sizeof( maxIdle ) );

    int count = 3; // send up to 3 keepalive packets out, then disconnect if no response
    setsockopt( fd, SOL_TCP, TCP_KEEPCNT, &count, sizeof( count ) );

    int interval = 2; // send a keepalive packet out every 2 seconds (after the 5 second idle period)
    setsockopt( fd, SOL_TCP, TCP_KEEPINTVL, &interval, sizeof( interval ) );

    m_socket->setSocketOption( QAbstractSocket::KeepAliveOption, 1 );
}

void Server::test()
{
    qDebug() << "TEST TEST";
}

bool Server::sendString( const QString str )
{
    if ( m_socket ) {
        m_socket->write( str.toLocal8Bit() );
        return m_socket->flush();
    }
    return false;
}

void Server::nullingSocket()
{
    m_socket = nullptr;
    qDebug() << "socket turned to ZERO";
}

void Server::displayError( QAbstractSocket::SocketError socketError )
{
    switch ( socketError ) {
        case QAbstractSocket::RemoteHostClosedError:
            qDebug() << "The Host closed his connection!";
            break;
        case QAbstractSocket::HostNotFoundError:
            qDebug() << "The host was not found. Please check the "
                    "host name and port settings.";
            break;
        case QAbstractSocket::ConnectionRefusedError:
            qDebug() << "The connection was refused by the peer. "
                    "Make sure the fortune server is running, "
                    "and check that the host name "
                    "and port settings are correct.";
            break;
        default:
            qDebug()
                << QString( "The following error occurred: %1." )
                   .arg( m_socket->errorString() );
    }
}
