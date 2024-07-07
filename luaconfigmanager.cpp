#include "luaconfigmanager.h"

LuaConfigManager::LuaConfigManager(QObject *parent)
    : QObject(parent)
{}

void LuaConfigManager::updateConfigField(const QVariantMap &updates)
{
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    if (luaL_dofile(L, "./.conf/conf.dispatch.lua") != LUA_OK) {
        std::cerr << "Failed to load conf.dispatch.lua: " << lua_tostring(L, -1) << std::endl;
        lua_close(L);
        return;
    }

    lua_getglobal(L, "updateConfig");
    if (!lua_isfunction(L, -1)) {
        std::cerr << "updateConfig function not found" << std::endl;
        lua_close(L);
        return;
    }

    lua_newtable(L);
    for (auto it = updates.constBegin(); it != updates.constEnd(); ++it) {
        lua_pushstring(L, it.key().toStdString().c_str());
        lua_pushstring(L, it.value().toString().toStdString().c_str());
        lua_settable(L, -3);
    }

    if (lua_pcall(L, 1, 0, 0) != LUA_OK) {
        std::cerr << "Error calling updateConfig: " << lua_tostring(L, -1) << std::endl;
    }

    lua_close(L);
}
