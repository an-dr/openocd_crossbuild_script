#!/bin/bash

#configure
SELF=$PWD
source $PWD/settings.sh
source $PWD/deps_info.sh

OPENOCD_WORK_FOLDER=$PWD/work
OPENOCD_WORKING_FOLDER=$PWD
MAKE_JOBS=${MAKE_JOBS:-"-j4"}

# ----- Local variables -----

# For updates, please check the corresponding pages.
OPENOCD_GIT_REPO="git://repo.or.cz/openocd.git"

# OpenOCD build defs
OPENOCD_TARGET="win${TARGET_BITS}"

OPENOCD_GIT_FOLDER="${OPENOCD_WORK_FOLDER}/openocd_git"
OPENOCD_DOWNLOAD_FOLDER="${OPENOCD_WORK_FOLDER}/download"
OPENOCD_BUILD_FOLDER="${OPENOCD_WORK_FOLDER}/build/${OPENOCD_TARGET}"
OPENOCD_INSTALL_FOLDER="${OPENOCD_WORK_FOLDER}/installed"
OPENOCD_OUTPUT_FOLDER="${OPENOCD_WORK_FOLDER}/output"

WGET="wget"
WGET_OUT="-O"

# Decide which toolchain to use.
if [ ${TARGET_BITS} == "32" ]
then
    CROSS_COMPILE_PREFIX="i686-w64-mingw32"
else
    CROSS_COMPILE_PREFIX="x86_64-w64-mingw32"
fi


if [ "${GIT_CLONE}" == "true" ]
then
    cd $SELF
    source $SELF/clone_openocd.sh
fi


if [ "${BUILD_LIBUSB}" == "true" ]
then
    cd $SELF
    source $SELF/build_libusb.sh
fi


# Configure OpenOCD. Use the same options as Freddie Chopin.
if [ "${OPENOCD_CONFIG}" == "true" ]
then
    cd $SELF
    source $SELF/build_openocd_config.sh
fi


if [ "${OPENOCD_MAKE}" == "true" ]
then
    cd $SELF
    source $SELF/build_make.sh
fi
