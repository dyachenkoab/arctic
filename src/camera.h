#ifndef CAMERA_H
#define CAMERA_H

#include <QGlib/Connect>
#include <QGlib/Error>
#include <QGst/Bus>
#include <QGst/ElementFactory>
#include <QGst/Message>
#include <QGst/Pad>
#include <QGst/Parse>
#include <QGst/Pipeline>
#include <QObject>
#include <jsonconf.h>

class Camera : public QObject
{
    Q_OBJECT

    void onBusMessage( const QGst::MessagePtr &message );
    void handlePipelineStateChange( const QGst::StateChangedMessagePtr &scm );
    void add_pad( const QGst::PadPtr& pad);

    JsonConf m_json;
    QGst::PipelinePtr m_pipeline;
    QGst::ElementPtr m_videoSink;
//    QGst::ElementPtr m_rtspReciever;
//    QGst::ElementPtr m_bin;

    QVector<QMap<int, QString>> m_info;
    QString m_bin;

public:
    explicit Camera( QObject *parent = nullptr);
    ~Camera();
    void setVideoSink(const QGst::ElementPtr & sink);
    void initCamera(const QString link);
    QGst::ElementPtr makeVideoBin();

public Q_SLOTS:
//    void startVideo(int camID);
//    void stopVideo();
    void changeShack(const int shackID, const int camID);
    void test();
    void setConf();

};

#endif // CAMERA_H
