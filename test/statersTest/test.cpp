#include "staters.h"
#include <QtTest/QtTest>

class StatersTest : public QObject
{
    Q_OBJECT
    Staters st;

private Q_SLOTS:
    void check();
    void checkFan();
    void checkDoor();
    void checkLight();
    void checkSocket();
};

void StatersTest::check()
{
    QVERIFY( st.tst() == 4 );
}
void StatersTest::checkFan()
{
    QVERIFY( st.fanControl( "0" ) == "i'm fan 0" );
}
void StatersTest::checkDoor()
{
    QVERIFY( st.doorControl( "0" ) == "i'm door 0" );
}
void StatersTest::checkLight()
{
    QVERIFY( st.lightControl( "0" ) == "i'm light 0" );
}
void StatersTest::checkSocket()
{
    QVERIFY( st.socketControl( "0" ) == "i'm socket 0" );
}

QTEST_MAIN( StatersTest )
#include "test.moc"
