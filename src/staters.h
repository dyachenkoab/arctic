#ifndef STATERS_H
#define STATERS_H

#include <QObject>
#include <QTimer>
#include <QDebug>

class Staters : public QObject
{
    Q_OBJECT

public:
    explicit Staters(QObject *parent = nullptr);

public Q_SLOTS:
    void startAction();
    QString lightControl(QString str);
    QString fanControl(QString str);
    QString doorControl(QString str);
    QString socketControl(QString str);
    QString heaterControl(QString str);

    int tst();


Q_SIGNALS:
     void lightSignal(QString str);
     void fanSignal(QString str);
     void heaterSignal(QString str);
     void doorSignal(QString str);
     void socketSignal(QString str);
};

#endif // STATERS_H
