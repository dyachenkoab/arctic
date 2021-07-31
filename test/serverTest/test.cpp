#include "server.h"
#include <QtTest/QtTest>

class ServerTest : public QObject
{
    Q_OBJECT
    Server serv;
    QTcpSocket *tcpSocket;

private Q_SLOTS:
    void camPipeTest();
    void initServerTest();
    void sendStringTest();
    //    void messageHandler();
};

void ServerTest::camPipeTest()
{
    QVERIFY( serv.getCamPipe( "primeShackCam1Pipe" ) == "gst-pipeline: rtspsrc rtsp://wowzaec2demo.streamlock.net/vod/"
                            "mp4:BigBuckBunny_115k.mov ! queue ! rtph264depay ! h264parse ! avdec_h264 ! videoconvert ! "
                            "qtvideosink" );
}

void ServerTest::initServerTest()
{
    tcpSocket = new QTcpSocket( this );
    tcpSocket->connectToHost( QHostAddress( "192.168.1.204" ), 17000 );

    QVERIFY( tcpSocket->waitForConnected( 5000 ) );
    QVERIFY( tcpSocket->state() == QAbstractSocket::ConnectedState );
    qApp->processEvents();
}

void ServerTest::sendStringTest()
{
    QVector<QString> v = { "one", "two", "three", "four", "five" };

    for ( int i = 0; i < v.length(); ++i ) {
        QVERIFY( serv.sendString( v[i] ) );
        QTest::qWait( 1000 );
        QVERIFY( tcpSocket->readAll() == v[i] );
        qDebug() << v[i];
    }
}

// void ServerTest::messageHandler()
//{
//    QVERIFY(tcpSocket->readAll() == "strinag");
//}

QTEST_MAIN( ServerTest )
#include "test.moc"
