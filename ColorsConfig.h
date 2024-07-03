#ifndef COLORSCONFIG_H
#define COLORSCONFIG_H
#include <QColor>
#include <QObject>

/*
 * Main_Blue_Light 1A5FAF
 * Main_Blue_Dark  5A94D6
 * Background_Darkest 09090A
 * Background_Darker 101012
 * Background_Dark_Gray 34343B
 * Background_Gray B8B8B8
 * Background_White F0F0F0
 * xxx 19151F
*/

class ColorsConfig : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QColor mainBlueLight READ mainBlueLight CONSTANT)
    Q_PROPERTY(QColor mainBlueDark READ mainBlueDark CONSTANT)
    Q_PROPERTY(QColor backgroundDarkest READ backgroundDarkest CONSTANT)
    Q_PROPERTY(QColor backgroundDarker READ backgroundDarker CONSTANT)
    Q_PROPERTY(QColor backgroundDarkGray READ backgroundDarkGray CONSTANT)
    Q_PROPERTY(QColor backgroundGray READ backgroundGray CONSTANT)
    Q_PROPERTY(QColor backgroundWhite READ backgroundWhite CONSTANT)

public:
    explicit ColorsConfig(QObject *parent = nullptr)
        : QObject(parent)
    {}

    QColor mainBlueLight() const { return QColor("#1A5FAF"); }
    QColor mainBlueDark() const { return QColor("#5A94D6"); }
    QColor backgroundDarkest() const { return QColor("#09090A"); }
    QColor backgroundDarker() const { return QColor("#101012"); }
    QColor backgroundDarkGray() const { return QColor("#34343B"); }
    QColor backgroundGray() const { return QColor("#B8B8B8"); }
    QColor backgroundWhite() const { return QColor("#F0F0F0"); }

private:
};
#endif // COLORSCONFIG_H
