


if [ ! -d "${OPENOCD_GIT_FOLDER}" ] # dir is not exists
then
    mkdir -p "${OPENOCD_WORK_FOLDER}"
    cd "${OPENOCD_WORK_FOLDER}"
    
    # For regular read/only access, use the git url.
    git clone $OPENOCD_GIT_REPO openocd_git
    
    # Change to the gnuarmeclipse branch. On subsequent runs use "git pull".
    cd "${OPENOCD_GIT_FOLDER}"
    # git checkout gnuarmeclipse
    git submodule update
    
    # Prepare autotools.
    echo
    echo "bootstrap..."
    
    cd "${OPENOCD_GIT_FOLDER}"
    ./bootstrap
    
    echo
    echo "Clone completed. Proceed with a regular build."
    # exit 0
else
    echo "No git folder."
    # exit 1
fi