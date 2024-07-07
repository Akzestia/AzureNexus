#ifndef QUICCLIENTWRAPPER_H
#define QUICCLIENTWRAPPER_H

#include <QDebug>
#include <QObject>
#include "../Documents/GitHub/Linux-x64-HTTP3/proto/build/auth.pb.h"

class QuicClientWrapper : public QObject
{
    Q_OBJECT
public:
    explicit QuicClientWrapper(QObject *parent = nullptr);

    Q_INVOKABLE void StartSignUpRequest(QString, QString, QString);
};

#endif // QUICCLIENTWRAPPER_H
