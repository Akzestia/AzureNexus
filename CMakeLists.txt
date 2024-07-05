cmake_minimum_required(VERSION 3.16)

project(AzureNexus VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.7.1 COMPONENTS Quick REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Widgets Multimedia)
find_package(Qt6 REQUIRED COMPONENTS Widgets)
find_package(Qt6 REQUIRED COMPONENTS WaylandCompositor)
find_package(Qt6 REQUIRED COMPONENTS Svg)
find_package(Qt6 REQUIRED COMPONENTS LinguistTools)

qt_add_executable(appAzureNexus
    main.cpp
)

qt_add_translations(appAzureNexus TS_FILES AzureNexus_ja_JP.ts)

qt_add_qml_module(appAzureNexus
    URI AzureNexus
    VERSION 1.0
    QML_FILES main.qml
    QML_FILES login.qml
    SOURCES
    SOURCES screencapture.h screencapture.cpp
    SOURCES voicecapture.h voicecapture.cpp
    SOURCES splashscreen.h splashscreen.cpp
    QML_FILES SvgButton.qml
    RESOURCES AzureNexus.qrc
    QML_FILES Wayland.qml
    SOURCES ../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.h
    SOURCES ../Documents/GitHub/Linux-x64-HTTP3/client/QuicClient.cpp
    SOURCES ColorsConfig.h
    SOURCES translationmanager.h translationmanager.cpp
    QML_FILES Message.qml
    SOURCES message.h message.cpp
    SOURCES ./.config/.env
    SOURCES ./cache
    SOURCES ./Documents/Files
    SOURCES ./Documents/Images
    SOURCES ./Documents/Videos
    SOURCES roundedimage.h roundedimage.cpp
    RESOURCES RoundImageShader.frag
    SOURCES luaconfigmanager.h luaconfigmanager.cpp
    QML_FILES SignUp.qml
    QML_FILES SignIn.qml
)

#SOURCES waylandscreencpature.h waylandscreencpature.cpp

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appAzureNexus PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appAzureNexus
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appAzureNexus PRIVATE
    Qt6::Quick
    Qt6::Multimedia
    Qt6::Widgets
    Qt6::WaylandCompositor
    Qt6::Svg
    ${CMAKE_CURRENT_SOURCE_DIR}/appAzureNexus/MsQuic/bin/libmsquic.so
    protobuf
    absl_log_internal_check_op
    absl_log_internal_message
    absl_cord
    absl_cordz_info
    lua
)

include(GNUInstallDirs)
install(TARGETS appAzureNexus
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
