


# ----- Full build, with documentation -----

# The bindir and pkgdatadir are required to configure bin and scripts folders
# at the same level in the hierarchy.
cd "${OPENOCD_BUILD_FOLDER}/openocd"
# make ${MAKE_JOBS} bindir="bin" pkgdatadir="" all pdf html
make ${MAKE_JOBS}
make install
make distclean

echo
echo "copy dynamic libs..."

if [ "${TARGET_BITS}" == "32" ]
then

  CROSS_GCC_VERSION=$(${CROSS_COMPILE_PREFIX}-gcc --version | grep 'gcc' | sed -e 's/.*\s\([0-9]*\)[.]\([0-9]*\)[.]\([0-9]*\).*/\1.\2.\3/')
  CROSS_GCC_VERSION_SHORT=$(echo $CROSS_GCC_VERSION | sed -e 's/\([0-9]*\)[.]\([0-9]*\)[.]\([0-9]*\).*/\1.\2/')
  if [ -f "/usr/lib/gcc/${CROSS_COMPILE_PREFIX}/${CROSS_GCC_VERSION}/libgcc_s_sjlj-1.dll" ]
  then
    cp -v "/usr/lib/gcc/${CROSS_COMPILE_PREFIX}/${CROSS_GCC_VERSION}/libgcc_s_sjlj-1.dll" \
      "${OPENOCD_INSTALL_FOLDER}/bin"
  elif [ -f "/usr/lib/gcc/${CROSS_COMPILE_PREFIX}/${CROSS_GCC_VERSION_SHORT}/libgcc_s_sjlj-1.dll" ]
  then
    cp -v "/usr/lib/gcc/${CROSS_COMPILE_PREFIX}/${CROSS_GCC_VERSION_SHORT}/libgcc_s_sjlj-1.dll" \
      "${OPENOCD_INSTALL_FOLDER}/bin"
  else
    echo "Searching /usr for libgcc_s_sjlj-1.dll..."
    SJLJ_PATH=$(find /usr \! -readable -prune -o -name 'libgcc_s_sjlj-1.dll' -print | grep ${CROSS_COMPILE_PREFIX})
    cp -v ${SJLJ_PATH} "${OPENOCD_INSTALL_FOLDER}/bin"
  fi

  if [ -f "/usr/${CROSS_COMPILE_PREFIX}/lib/libwinpthread-1.dll" ]
  then
    cp "/usr/${CROSS_COMPILE_PREFIX}/lib/libwinpthread-1.dll" \
      "${OPENOCD_INSTALL_FOLDER}/bin"
  else
    echo "Searching /usr for libwinpthread-1.dll..."
    PTHREAD_PATH=$(find /usr \! -readable -prune -o -name 'libwinpthread-1.dll' -print | grep ${CROSS_COMPILE_PREFIX})
    cp -v "${PTHREAD_PATH}" "${OPENOCD_INSTALL_FOLDER}/bin"
  fi

fi

# Copy possible DLLs. Currently only libusb0.dll is dynamic, all other
# are also compiled as static.
# cp -v "${OPENOCD_INSTALL_FOLDER}/bin/"*.dll "${OPENOCD_INSTALL_FOLDER}/openocd/bin"
