#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickView>
#include <QGst/Init>
#include <QGst/Quick/VideoSurface>
#include <QGst/global.h>
#include "staters.h"
#include "camera.h"
#include "server.h"
#include "udpreciever.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseSoftwareOpenGL);

    QGuiApplication app(argc, argv);
    QGst::init( &argc, &argv );
    QQmlApplicationEngine engine;

    Staters s;
    Server srv;
    UdpReciever urec;
    Camera cam;

    QObject::connect(&app, &QGuiApplication::aboutToQuit, &srv, &Server::test);

    const QUrl url(QStringLiteral("qrc://res/qml/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QGst::Quick::VideoSurface *surface = new QGst::Quick::VideoSurface( &engine );
    engine.rootContext()->setContextProperty( QLatin1String( "firstShackCam1" ), surface );

//    Camera *camera = new Camera( );

//    camera->setVideoSink(surface->videoSink());

//    engine.rootContext()->setContextProperty( QLatin1String( "camera" ), camera );
    engine.rootContext()->setContextProperty( "staters", &s );
    engine.rootContext()->setContextProperty( "server", &srv );

//    camera->initCamera("rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov");

    engine.load(url);

    return app.exec();
}
