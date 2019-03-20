#! /bin/bash

. ./scripts/common.sh

rm_dir() {
    if [[ -n $1 ]] && [[ -d $1 ]]; then
        echo "rm -rf $1"
        rm -rf $1
    else
        echo "Parameter \"$1\" is not a directory"
    fi
}

# Debug for volume mounting
mount
ls -la ${CMAKE_INSTALL_PREFIX}

#rm_dir -rf ${PROTON_SRC_DIR}
#rm_dir ${CMAKE_INSTALL_PREFIX}
#rm_dir ${PROTON_BUILD_DIR}