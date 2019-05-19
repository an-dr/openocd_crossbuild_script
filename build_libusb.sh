# build libs ====================================================================
# ----- Build the USB libraries -----

# Both USB libraries are available from a single project LIBUSB
# 	http://www.libusb.info
# with source files ready to download from SourceForge
# 	https://sourceforge.net/projects/libusb/files

# Download the new USB library.
LIBUSB1_ARCHIVE="${LIBUSB1}.tar.bz2"
if [ ! -f "${OPENOCD_DOWNLOAD_FOLDER}/${LIBUSB1_ARCHIVE}" ]
then
    mkdir -p "${OPENOCD_DOWNLOAD_FOLDER}"
    
    cd "${OPENOCD_DOWNLOAD_FOLDER}"
    "${WGET}" "http://sourceforge.net/projects/libusb/files/libusb-1.0/${LIBUSB1}/${LIBUSB1_ARCHIVE}" \
    "${WGET_OUT}" "${LIBUSB1_ARCHIVE}"
fi

# Unpack the new USB library.
if [ ! -d "${OPENOCD_WORK_FOLDER}/${LIBUSB1}" ]
then
    cd "${OPENOCD_WORK_FOLDER}"
    tar -xjvf "${OPENOCD_DOWNLOAD_FOLDER}/${LIBUSB1_ARCHIVE}"
fi

# Build and install the new USB library.
if [ ! \( -d "${OPENOCD_BUILD_FOLDER}/${LIBUSB1}" \) -o \
    ! \( -f "${OPENOCD_INSTALL_FOLDER}/lib/libusb-1.0.a" -o \
-f "${OPENOCD_INSTALL_FOLDER}/lib64/libusb-1.0.a" \) ]
then
    rm -rfv "${OPENOCD_BUILD_FOLDER}/${LIBUSB1}"
    mkdir -p "${OPENOCD_BUILD_FOLDER}/${LIBUSB1}"
    
    mkdir -p "${OPENOCD_INSTALL_FOLDER}"
    
    cd "${OPENOCD_BUILD_FOLDER}/${LIBUSB1}"
    # Configure
    CFLAGS="-Wno-non-literal-null-conversion -m${TARGET_BITS}" \
    PKG_CONFIG="${OPENOCD_WORKING_FOLDER}/scripts/cross-pkg-config" \
    "${OPENOCD_WORK_FOLDER}/${LIBUSB1}/configure" \
    --host="${CROSS_COMPILE_PREFIX}" \
    --prefix="${OPENOCD_INSTALL_FOLDER}"
    
    # Build
    make ${MAKE_JOBS} clean install
    
    # Remove DLLs to force static link for final executable.
    rm -f "${OPENOCD_INSTALL_FOLDER}/bin/libusb-1.0.dll"
    rm -f "${OPENOCD_INSTALL_FOLDER}/lib/libusb-1.0.dll.a"
    rm -f "${OPENOCD_INSTALL_FOLDER}/lib/libusb-1.0.la"
fi

# # http://sourceforge.net/projects/libusb-win32

# # Download the old Win32 USB library.
# if [ ! -f "${OPENOCD_DOWNLOAD_FOLDER}/${LIBUSB_W32_ARCHIVE}" ]
# then
#     mkdir -p "${OPENOCD_DOWNLOAD_FOLDER}"
    
#     cd "${OPENOCD_DOWNLOAD_FOLDER}"
#     "${WGET}" "http://sourceforge.net/projects/libusb-win32/files/libusb-win32-releases/${LIBUSB_W32_VERSION}/${LIBUSB_W32_ARCHIVE}" \
#     "${WGET_OUT}" "${LIBUSB_W32_ARCHIVE}"
# fi

# # Unpack the old Win32 USB library.
# if [ ! -d "${OPENOCD_WORK_FOLDER}/${LIBUSB_W32_FOLDER}" ]
# then
#     cd "${OPENOCD_WORK_FOLDER}"
#     unzip "${OPENOCD_DOWNLOAD_FOLDER}/${LIBUSB_W32_ARCHIVE}"
# fi

# # Build and install the old Win32 USB library.
# if [ ! \( -d "${OPENOCD_BUILD_FOLDER}/${LIBUSB_W32}" \) -o \
#     ! \( -f "${OPENOCD_INSTALL_FOLDER}/lib/libusb.a" -o \
# -f "${OPENOCD_INSTALL_FOLDER}/lib64/libusb.a" \)  ]
# then
#     mkdir -p "${OPENOCD_BUILD_FOLDER}/${LIBUSB_W32}"
    
#     cd "${OPENOCD_BUILD_FOLDER}/${LIBUSB_W32}"
#     cp -r "${OPENOCD_WORK_FOLDER}/${LIBUSB_W32_FOLDER}/"* \
#     "${OPENOCD_BUILD_FOLDER}/${LIBUSB_W32}"
    
#     echo
#     echo "make libusb-win32..."
    
#     cd "${OPENOCD_BUILD_FOLDER}/${LIBUSB_W32}"
#     # Patch from:
#     # https://gitorious.org/jtag-tools/openocd-mingw-build-scripts
#     patch -p1 < "${OPENOCD_WORKING_FOLDER}/patches/${LIBUSB_W32}-mingw-w64.patch"
    
#     # Build
#     CFLAGS="-m${TARGET_BITS}" \
#     make host_prefix=${CROSS_COMPILE_PREFIX} host_prefix_x86=i686-w64-mingw32 dll
    
#     mkdir -p "${OPENOCD_INSTALL_FOLDER}/bin"
#     cp -v "${OPENOCD_BUILD_FOLDER}/${LIBUSB_W32}/libusb0.dll" \
#     "${OPENOCD_INSTALL_FOLDER}/bin"
    
#     mkdir -p "${OPENOCD_INSTALL_FOLDER}/lib"
#     cp -v "${OPENOCD_BUILD_FOLDER}/${LIBUSB_W32}/libusb.a" \
#     "${OPENOCD_INSTALL_FOLDER}/lib"
    
#     mkdir -p "${OPENOCD_INSTALL_FOLDER}/lib/pkgconfig"
#     sed -e "s|XXX|${OPENOCD_INSTALL_FOLDER}|" \
#     "${OPENOCD_WORKING_FOLDER}/pkgconfig/${LIBUSB_W32}.pc" \
#     > "${OPENOCD_INSTALL_FOLDER}/lib/pkgconfig/libusb.pc"
    
#     mkdir -p "${OPENOCD_INSTALL_FOLDER}/include/libusb"
#     cp -v "${OPENOCD_BUILD_FOLDER}/${LIBUSB_W32}/src/lusb0_usb.h" \
#     "${OPENOCD_INSTALL_FOLDER}/include/libusb/usb.h"
    
# fi
