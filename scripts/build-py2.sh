#! /bin/bash

. ./scripts/common.sh

cd ${PROTON_BUILD_DIR}

# Build Python 2.x
echo "CMAKE_PY2_OPTS=${CMAKE_PY2_OPTS}"
cmake ${CMAKE_PY2_OPTS} ..
make
