#include "splashscreen.h"

SplashScreen::SplashScreen(QQmlApplicationEngine *engine, QObject *parent)
    : QObject(parent)
    , m_engine(engine)
{}

void SplashScreen::startLoginProcess()
{
    QTimer::singleShot(0, [this]() {
        QObject *loginWindow = m_engine->rootObjects().first();
        loginWindow->setProperty("visible", false);

        m_engine->load(QUrl(QStringLiteral("qrc:/AzureNexus/main.qml")));
        if (m_engine->rootObjects().isEmpty()) {
            qWarning() << "Failed to load main.qml";
            return;
        }
    });
}

void SplashScreen::startSignUpProcess()
{
    QTimer::singleShot(0, [this]() {
        QList<QObject *> rootObjects = m_engine->rootObjects();
        bool isFullScreen = false;
        if (!rootObjects.isEmpty()) {
            QObject *currentRoot = rootObjects.first();
            QQuickWindow *currentWindow = qobject_cast<QQuickWindow *>(currentRoot);
            if (currentWindow) {
                isFullScreen = currentWindow->visibility() == QQuickWindow::FullScreen;
            }
            delete currentRoot;
        }

        m_engine->load(QUrl(QStringLiteral("qrc:/AzureNexus/SignUp.qml")));
        if (m_engine->rootObjects().isEmpty()) {
            qWarning() << "Failed to load SignUp.qml";
            return;
        }

        QObject *newRoot = m_engine->rootObjects().first();
        QQuickWindow *newWindow = qobject_cast<QQuickWindow *>(newRoot);
        if (isFullScreen && newWindow) {
            newWindow->setVisibility(QQuickWindow::FullScreen);
        }
    });
}

void SplashScreen::startSignInProcess()
{
    QTimer::singleShot(0, [this]() {
        QList<QObject *> rootObjects = m_engine->rootObjects();
        bool isFullScreen = false;
        if (!rootObjects.isEmpty()) {
            QObject *currentRoot = rootObjects.first();
            QQuickWindow *currentWindow = qobject_cast<QQuickWindow *>(currentRoot);
            if (currentWindow) {
                isFullScreen = currentWindow->visibility() == QQuickWindow::FullScreen;
            }
            delete currentRoot;
        }

        m_engine->load(QUrl(QStringLiteral("qrc:/AzureNexus/SignIn.qml")));
        if (m_engine->rootObjects().isEmpty()) {
            qWarning() << "Failed to load SignIn.qml";
            return;
        }

        QObject *newRoot = m_engine->rootObjects().first();
        QQuickWindow *newWindow = qobject_cast<QQuickWindow *>(newRoot);
        if (isFullScreen && newWindow) {
            newWindow->setVisibility(QQuickWindow::FullScreen);
        }
    });
}
