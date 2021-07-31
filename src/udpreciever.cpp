#include "udpreciever.h"

UdpReciever::UdpReciever( QObject *parent ) : QObject( parent )
{
    init();
}

void UdpReciever::init()
{
    JsonConf json;
    json.openConfig();
    int port = json.getParametr( "udpPort" ).toInt();

    m_udp = new QUdpSocket( this );
    m_udp->bind( QHostAddress::Any, port );
    connect( m_udp, &QUdpSocket::readyRead, this, &UdpReciever::readDatagram );
}

void UdpReciever::readDatagram()
{

    while ( m_udp->hasPendingDatagrams() ) {
        QNetworkDatagram datagram = m_udp->receiveDatagram();
        qDebug() << datagram.data() << " My datagram";
        //        processTheDatagram(datagram);
    }
}
