DESCRIPTION = "QT-based JSON library"
LICENSE = "LGPLv2"
LIC_FILES_CHKSUM = "file://LICENSE;md5=4fbd65380cdd255951079008b364516c"

SRC_URI = "git://github.com/QtMark/qmjson.git;protocol=git;branch=master"

SRCREV = "8d9723c1407807fc9d3af7550e17c734f7b482e0"

S = "${WORKDIR}/git"
PV = "1.0+git${SRCPV}"

inherit qmake5

DEPENDS = "qtbase"

EXTRA_OEMAKE += "INSTALL_ROOT=${D}"

PR="r2"
