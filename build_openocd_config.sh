if [ ! \( -d "${OPENOCD_BUILD_FOLDER}/openocd" \) -o \
! \( -f "${OPENOCD_BUILD_FOLDER}/openocd/config.h" \) ]
then
    
    echo
    echo "configure..."
    
    mkdir -p "${OPENOCD_BUILD_FOLDER}/openocd"
    cd "${OPENOCD_BUILD_FOLDER}/openocd"
    # All variables below are passed on the command line before 'configure'.
    # Be sure all these lines end in '\' to ensure lines are concatenated.
    OUTPUT_DIR="${OPENOCD_BUILD_FOLDER}" \
    \
    CPPFLAGS="-m${TARGET_BITS}" \
    # PKG_CONFIG="${OPENOCD_WORK_FOLDER}/scripts/cross-pkg-config" \
    PKG_CONFIG_LIBDIR="${OPENOCD_INSTALL_FOLDER}/lib/pkgconfig" \
    PKG_CONFIG_PREFIX="${OPENOCD_INSTALL_FOLDER}" \
    \
    "${OPENOCD_GIT_FOLDER}/configure" \
    --build="$(uname -m)-linux-gnu" \
    --host="${CROSS_COMPILE_PREFIX}" \
    --prefix="${OPENOCD_INSTALL_FOLDER}"
    # --enable-aice \
    # --enable-amtjtagaccel \
    # --enable-armjtagew \
    # --enable-cmsis-dap \
    # --enable-ftdi \
    # --enable-gw16012 \
    # --enable-jlink \
    # --enable-jtag_vpi \
    # --enable-opendous \
    # --enable-openjtag_ftdi \
    # --enable-osbdm \
    # --enable-legacy-ft2232_libftdi \
    # --enable-parport \
    # --disable-parport-ppdev \
    # --enable-parport-giveio \
    # --enable-presto_libftdi \
    # --enable-remote-bitbang \
    # --enable-rlink \
    # --enable-stlink \
    # --enable-ti-icdi \
    # --enable-ulink \
    # --enable-usb-blaster-2 \
    # --enable-usb_blaster_libftdi \
    # --enable-usbprog \
    # --enable-vsllink
    
fi