#! /bin/bash

. ./scripts/common.sh

echo "The following Python libs have been installed:"
ls -l --color=auto ${PROTON_BINDINGS_INSTALL_DIR}/python*/_cproton.so
