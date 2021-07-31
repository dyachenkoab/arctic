#include <QCoreApplication>
#include <QTextStream>
#include <QDebug>
#include <QFile>
#include "jsonconf.h"

int main(int argc, char** argv)
{

	QCoreApplication app(argc, argv);
	JsonConf conf;
	conf.openConfig();

	QString str = conf.getParametr("str").toString();
    int number = conf.getParametr("number").toInt();
    bool bl = conf.getParametr("bool").toBool();

	qDebug() << str;
    qDebug() << number;
    qDebug() << bl;

    QTextStream stream(stdout);
    stream << str << "\n";
    stream << number << "\n";
    stream << bl << "\n";

	return 0;
}
