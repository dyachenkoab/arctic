#include <QCoreApplication>
#include "Client.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QCoreApplication app(argc, argv);
    Client c;

    QObject::connect(&app, &QCoreApplication::aboutToQuit, &c, &Client::test);

    return app.exec();
}
