#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    QmlApplicationViewer viewer;

    ApplicationData *data = new ApplicationData();
    data->setView(&viewer);

    viewer.rootContext()->setContextProperty("applicationData", data);
    viewer.rootContext()->setContextProperty("play_fullscreen", data);
    viewer.rootContext()->setContextProperty("view", &viewer);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/tvnplayer/main.qml"));

viewer.showFullScreen();

return app->exec();
}
