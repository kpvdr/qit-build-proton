#! /bin/bash

. ./scripts/common.sh

# Remove old Python bindings and build dir
#rm -rf "${PROTON_BINDINGS_INSTALL_DIR}/python"
#rm -rf "${PROTON_BINDINGS_INSTALL_DIR}/python3"
#rm -rf "${PROTON_BUILD_DIR}"

mkdir -p ${PROTON_BUILD_DIR}
cd ${PROTON_BUILD_DIR}

# Build Python 3.x
echo "CMAKE_PY3_OPTS=${CMAKE_PY3_OPTS}"
cmake ${CMAKE_PY3_OPTS} ..
make
