#ifndef LUACONFIGMANAGER_H
#define LUACONFIGMANAGER_H
#include <QString>
#include <QVariantMap>
#include <iostream>
#include <lua.hpp>

class LuaConfigManager
{
public:
    LuaConfigManager();

    static void updateConfigField(const QVariantMap &updates);
};

#endif // LUACONFIGMANAGER_H
