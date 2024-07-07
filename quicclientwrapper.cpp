#include "quicclientwrapper.h"

QuicClientWrapper::QuicClientWrapper(QObject *parent)
    : QObject(parent)
{}

void QuicClientWrapper::StartSignUpRequest(QString user_name,
                                           QString user_email,
                                           QString user_password)
{
    Auth auth;

    Sign_up signUp;
    signUp.set_user_name(user_name.toStdString());
    signUp.set_display_name("XJi");
    signUp.set_user_email(user_email.toStdString());
    signUp.set_user_password(user_password.toStdString());

    *auth.mutable_sign_up() = signUp;

    if (auth.has_sign_up()) {
        qDebug() << "User Name:" << QString::fromStdString(auth.sign_up().user_name());
        qDebug() << "Display Name:" << QString::fromStdString(auth.sign_up().display_name());
        qDebug() << "Email:" << QString::fromStdString(auth.sign_up().user_email());
        qDebug() << "Password:" << QString::fromStdString(auth.sign_up().user_password());
    }
}
