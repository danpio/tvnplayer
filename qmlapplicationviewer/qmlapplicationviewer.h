// checksum 0x898f version 0x70013
/*
  This file was generated by the Qt Quick Application wizard of Qt Creator.
  QmlApplicationViewer is a convenience class containing mobile device specific
  code such as screen orientation handling. Also QML paths and debugging are
  handled here.
  It is recommended not to modify this file, since newer versions of Qt Creator
  may offer an updated version of it.
*/

#ifndef QMLAPPLICATIONVIEWER_H
#define QMLAPPLICATIONVIEWER_H

#include <QtDeclarative/QDeclarativeView>
#include <QProcess>
 #include <QDebug>
#include <QLabel>
 #include <QTimer>
 #include <QGraphicsProxyWidget>
class ApplicationData : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QGraphicsView* view WRITE setView)
public:
   QString adress;

    Q_INVOKABLE void seturl(const QString& url) {
        qDebug()<<"set url"<<url;
         adress=url;
    }

    Q_INVOKABLE QDateTime getCurrentDateTime() const {
         return QDateTime::currentDateTime();
    }

    Q_INVOKABLE void seturl() {
        seturl(m_url);
    }
    Q_INVOKABLE void play() {
        play(m_view);
    }

   Q_INVOKABLE void play_fullscreen() {
qDebug()<<" full screen:"<<video->geometry();

  //new QRect(0, video);

        video->setGeometry(0,0,854,480);
        video->raise();
        video->autoFillBackground();
        video->show();
        m_view->repaint();



   }
    Q_INVOKABLE void play(QGraphicsView *view) {
       int pid1=adress.left(3).toInt();
int pid2=adress.right(4).toInt();
QString xAsHex = QString("0%1,0%2,").arg(pid1, 0, 16).arg(pid2,0,16);
//0200,028a,
       QString file("http://192.168.100.66:31339/");
        m_view = view;
        if (video)
            delete video;
        video = new QWidget(m_view);
        new QLabel(0, video);
        video->setGeometry(7,55,364,297);
       // video->setGeometry(0,0,854,480);
        video->raise();
        video->autoFillBackground();
        video->show();
        video->setWindowOpacity(1);
        if (process) {
            process->write("q\n");
            process->waitForFinished();
            delete process;
        }

        QStringList args;

        args << "-wid" << QString::number((ulong) video->winId());
        args << "-loop" << "0";
        args << "-abs" << "65536";
        args << "-vfm" << "ffmpeg";
        args << "-lavdopts" << "lowres=0:fast:skiploopfilter=all";
        args << "-cache" << "9192";
        args << "-fs";
        args << file.append(xAsHex);
      process = new QProcess(this);
      process->start("mplayer", args);
        qDebug() << args;
    }

    ApplicationData(QObject *parent = 0) : QObject(parent), video(0), process(0) {
        QTimer::singleShot(10, this, SIGNAL(dataChanged()));
        qDebug()<<"co sie dzieje";
    }


    virtual ~ApplicationData(){
         QStringList args;
        args<<"mplayer";
        process = new QProcess(this);
        process->start("killall", args);
    }
    void setView(QGraphicsView *view) {
        m_view = view;
    }


Q_SIGNALS:
    void dataChanged();


public:
    QWidget *video;
    QProcess *process;

private:
    QGraphicsView *m_view;
    QString m_url;
};

class QmlApplicationViewer : public QDeclarativeView
{
    Q_OBJECT

public:
    enum ScreenOrientation {
        ScreenOrientationLockPortrait,
        ScreenOrientationLockLandscape,
        ScreenOrientationAuto
    };

    explicit QmlApplicationViewer(QWidget *parent = 0);
    virtual ~QmlApplicationViewer();

    static QmlApplicationViewer *create();

    void setMainQmlFile(const QString &file);
    void addImportPath(const QString &path);

    // Note that this will only have an effect on Symbian and Fremantle.
    void setOrientation(ScreenOrientation orientation);

    void showExpanded();

private:
    class QmlApplicationViewerPrivate *d;
};

QApplication *createApplication(int &argc, char **argv);

#endif // QMLAPPLICATIONVIEWER_H
