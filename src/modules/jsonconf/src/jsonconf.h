#ifndef JSONCONF_H
#define JSONCONF_H

#include <QCoreApplication>
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QJsonDocument>
#include <QJsonObject>
#include <QObject>

class JsonConf : public QObject
{
    Q_OBJECT
public:
    explicit JsonConf( QObject *parent = nullptr );

public Q_SLOTS:
    void setPath( const QString & );
    void setNameConfig( const QString & );
    QVariant getParametr( const QString & );
    void openConfig();

private:
    QString mPath;
    QString mConfigName;
    QJsonObject mJsonObj;
};

#endif // JSONCONF_H
