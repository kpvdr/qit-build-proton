#! /bin/bash

. ./scripts/common.sh

# Get Python 2 details
find_python python PY2_EXECUTABLE PY2_VER PY2_INCLUDE_DIR PY2_LIBRARY
echo "PY2_EXECUTABLE=${PY2_EXECUTABLE}"
echo "PY2_VER=${PY2_VER}"
echo "PY2_INCLUDE_DIR=${PY2_INCLUDE_DIR}"
echo "PY2_LIBRARY=${PY2_LIBRARY}"
CMAKE_PY2_OPTS="-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DBUILD_PYTHON="ON" -DPYTHON_EXECUTABLE=${PY2_EXECUTABLE} -DPYTHON_INCLUDE_DIR=${PY2_INCLUDE_DIR} -DPYTHON_LIBRARY=${PY2_LIBRARY}"

cd ${PROTON_BUILD_DIR}

# Build Python 2.x
echo "CMAKE_PY2_OPTS=${CMAKE_PY2_OPTS}"
cmake ${CMAKE_PY2_OPTS} ..
make
