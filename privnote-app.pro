TEMPLATE = app

QT += qml quick svg xml gui
CONFIG += c++11

SOURCES += main.cpp \
           shareutils.cpp

HEADERS += shareutils.h

RESOURCES += qml.qrc

ios {
    OBJECTIVE_SOURCES += src/ios/iosshareutils.mm
    HEADERS += src/ios/iosshareutils.h

    Q_ENABLE_BITCODE.name = ENABLE_BITCODE
    Q_ENABLE_BITCODE.value = NO
    QMAKE_MAC_XCODE_SETTINGS += Q_ENABLE_BITCODE
}

android {
    QT += androidextras
    OTHER_FILES += $$PWD/android_data/com/lasconic/QShareUtils.java
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android_data
    SOURCES += android/androidshareutils.cpp
    HEADERS += android/androidshareutils.h
    include($$PWD/openSSL/android-openssl.pri)
    DISTFILES += \
    android_data/AndroidManifest.xml \
    android_data/gradle/wrapper/gradle-wrapper.jar \
    android_data/gradlew \
    android_data/res/values/libs.xml \
    android_data/build.gradle \
    android_data/gradle/wrapper/gradle-wrapper.properties \
    android_data/gradlew.bat \
    android_data/AndroidManifest.xml \
    android_data/gradle/wrapper/gradle-wrapper.jar \
    android_data/gradlew \
    android_data/res/values/libs.xml \
    android_data/build.gradle \
    android_data/gradle/wrapper/gradle-wrapper.properties \
    android_data/gradlew.bat
}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS


# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    qml/qmldir \
    android_data/AndroidManifest.xml \
    android_data/gradle/wrapper/gradle-wrapper.jar \
    android_data/gradlew \
    android_data/res/values/libs.xml \
    android_data/build.gradle \
    android_data/gradle/wrapper/gradle-wrapper.properties \
    android_data/gradlew.bat \
    android_data/AndroidManifest.xml \
    android_data/gradle/wrapper/gradle-wrapper.jar \
    android_data/gradlew \
    android_data/res/values/libs.xml \
    android_data/build.gradle \
    android_data/gradle/wrapper/gradle-wrapper.properties \
    android_data/gradlew.bat
