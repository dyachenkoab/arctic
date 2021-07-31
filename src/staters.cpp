#include "staters.h"

Staters::Staters( QObject *parent ) : QObject( parent )
{
    //    QTimer::singleShot(4000, this, &Staters::startAction);
}

void Staters::startAction()
{
    Q_EMIT doorSignal( "1,1" );
    Q_EMIT fanSignal( "1,1" );
    Q_EMIT fanSignal( "0,2" );
    Q_EMIT lightSignal( "1,1" );
    Q_EMIT heaterSignal( "1,1" );
    Q_EMIT socketSignal( "1,1" );
    QTimer::singleShot( 3000, this, &Staters::startAction );
}

int Staters::tst()
{
    return 2 + 2;
}

QString Staters::fanControl( QString str )
{
    qDebug() << "i'm fan " + str << " IN CPP FAN";
    return QString( "i'm fan " + str );
}
QString Staters::doorControl( QString str )
{
    qDebug() << "i'm door " + str << " IN CPP DOOR";
    return QString( "i'm door " + str );
}
QString Staters::lightControl( QString str )
{
    qDebug() << "i'm light " + str << " IN CPP LIGHT";
    return QString( "i'm light " + str );
}
QString Staters::heaterControl( QString str )
{
    qDebug() << "i'm heater " + str << " IN CPP HEATER";
    return QString( "i'm heater " + str );
}
QString Staters::socketControl( QString str )
{
    qDebug() << "i'm socket " + str << " IN CPP SOCKET";
    return QString( "i'm socket " + str );
}
