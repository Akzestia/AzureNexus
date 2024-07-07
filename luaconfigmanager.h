#ifndef LUACONFIGMANAGER_H
#define LUACONFIGMANAGER_H
#include <QObject>
#include <QString>
#include <QVariantMap>
#include <iostream>
#include <lua.hpp>

class LuaConfigManager : public QObject
{
    Q_OBJECT

public:
    explicit LuaConfigManager(QObject *parent = nullptr);

    static void updateConfigField(const QVariantMap &updates);
};

#endif // LUACONFIGMANAGER_H
