#include "camera.h"

Camera::Camera( QObject *parent ) : QObject( parent )
{
    m_pipeline = QGst::Pipeline::create();
    setConf();
}

Camera::~Camera()
{
    if ( m_pipeline ) {
        m_pipeline->setState( QGst::StateNull );
    }
}

void Camera::setConf()
{
    m_json.openConfig();

    m_info.resize( 2 );
    m_info[0].insert( 0,
              m_json.getParametr( "primeShackCam1" ).toString() );
    m_info[0].insert( 1,
              m_json.getParametr( "primeShackCam2" ).toString() );
    m_info[1].insert( 0,
              m_json.getParametr( "secondShackCam1" ).toString() );
    m_info[1].insert( 1,
              m_json.getParametr( "secondShackCam2" ).toString() );

    m_bin = m_json.getParametr( "bin" ).toString();
}

QGst::ElementPtr Camera::makeVideoBin()
{
    QGst::ElementPtr bin = QGst::Bin::fromDescription( m_bin );
    return bin;
}

void Camera::initCamera( const QString link )
{
    if ( !m_pipeline ) {
        m_pipeline = QGst::Pipeline::create();
    }
    QGst::ElementPtr rtspReciever =
        QGst::ElementFactory::make( "rtspsrc", "rtp" );

    rtspReciever->setProperty( "location", link );

    m_pipeline->add( rtspReciever );
    m_pipeline->bus()->addSignalWatch();

    QGlib::connect( rtspReciever, "pad-added", this, &Camera::add_pad );

    QGlib::connect( m_pipeline->bus(), "message", this,
            &Camera::onBusMessage );

    m_pipeline->setState( QGst::StatePlaying );
}

void Camera::changeShack( const int shackID, const int camID )
{
    m_pipeline->setState( QGst::StateReady );
    struct timespec ts = { 2000 / 1000, ( 2000 % 1000 ) * 1000 * 1000 };

    m_pipeline->setState( QGst::StateNull );

    m_pipeline.clear();

    QString camLink = m_info[shackID][camID];
    initCamera( camLink );

    qDebug() << "camShacks changed!!";
}

void Camera::add_pad( const QGst::PadPtr &pad )
{
    QGst::ElementPtr bin = makeVideoBin();
    //   QGst::ElementPtr queue = QGst::ElementFactory::make( "queue",
    //   "queue1" ); QGst::ElementPtr rtppay = QGst::ElementFactory::make(
    //   "rtph264depay", "rtppay" ); QGst::ElementPtr parse =
    //   QGst::ElementFactory::make( "h264parse", "parse" );
    //   QGst::ElementPtr dec = QGst::ElementFactory::make( "avdec_h264",
    //   "dec" ); QGst::ElementPtr queue1 = QGst::ElementFactory::make(
    //   "queue", "queue2" ); QGst::ElementPtr convert =
    //   QGst::ElementFactory::make( "videoconvert", "convert" );
    //   QGst::ElementPtr convert1 = QGst::ElementFactory::make( "video",
    //   "convert2" );

    m_pipeline->add( bin );
    m_pipeline->add( m_videoSink );
    //    m_pipeline->add( queue, rtppay, parse, dec, queue1, convert,
    //    m_videoSink ); m_pipeline->linkMany(queue, rtppay, parse, dec,
    //    queue1, convert, m_videoSink);

    bin->link( m_videoSink );
    bin->syncStateWithParent();

    pad->link( bin->getStaticPad( "sink" ) );
    //    pad->link(queue->getStaticPad("sink"));
    qDebug() << m_pipeline->currentState() << " STATE";

    m_pipeline->setState( QGst::StatePlaying );
}

void Camera::onBusMessage( const QGst::MessagePtr &message )
{
    switch ( message->type() ) {
        case QGst::MessageEos: // End of stream. We reached the end of
                       // the file.
            m_pipeline->setState( QGst::StateNull );
            m_pipeline.clear();
            break;
        case QGst::MessageError: // Some error occurred.
            qCritical() << message.staticCast<QGst::ErrorMessage>()
                       ->error();
            m_pipeline->setState( QGst::StateNull );
            m_pipeline.clear();
            break;
        case QGst::MessageStateChanged: // The element in
                        // message->source() has changed
                        // state
            if ( message->source() == m_pipeline ) {
                handlePipelineStateChange(
                    message.staticCast<
                    QGst::StateChangedMessage>() );
            }
            break;
        default:
            break;
    }
}

void Camera::handlePipelineStateChange(
    const QGst::StateChangedMessagePtr &scm )
{
    switch ( scm->newState() ) {
        case QGst::StatePlaying:
            qDebug() << "play";
            break;
        case QGst::StateNull:
            if ( scm->oldState() == QGst::StatePlaying ) {
                qDebug() << "cancelled";
            }
            break;
        default:
            break;
    }
}
void Camera::test()
{
    //    qDebug() << m_info[0][0];
}

void Camera::setVideoSink( const QGst::ElementPtr &sink )
{
    m_videoSink = sink;
}

// void Camera::startVideo( int camID )
//{
//    m_pipeline->setState( QGst::StateNull );
//    QString link = m_camInfo[camID];
//    m_rtspReciever->setProperty( "location", link );
//    m_pipeline->setState( QGst::StatePlaying );
//    qDebug() << "START";
//}

// void Camera::stopVideo()
//{
//    m_pipeline->setState( QGst::StateNull );
//    qDebug() << "STOP";
//}

//#include "moc_Camera.cpp"
