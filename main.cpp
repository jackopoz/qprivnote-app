#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "shareutils.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    qmlRegisterType<ShareUtils> ("com.lasconic", 1, 0, "ShareUtils");
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;
    
    return app.exec();
}
