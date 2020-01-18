#! /bin/bash

# Find details for a given python executable
# S1: Python executable
# $2: Variable name for executable
# $3: Variable name for version
# $4: Variable name for include dir
# $5: Variable name for lib
find_python() {
    if [ "$#" -ne 5 ]; then
        echo "find_python(): Incorrect number of arguments"
        exit 1
    fi
    echo "exec=$1"
    eval $2=`which $1 2> /dev/null`
    if [[ $? == 0 ]]; then
        echo "$2=$$2"
        eval $3=`$1 --version 2>&1 | sed -e 's/[[:alpha:]|(|[:space:]]//g'`
        local short_py_ver=${PYTHON_VER%.*} # x.y.z -> x.y
        local py_include_dir=`ls -d /usr/include/python${short_py_ver}*` # 2> /dev/null`
        if [[ -d ${py_include_dir} ]]; then
            eval $4=${py_include_dir}
        else
            error=true
            echo "find_python(): ERROR: Python include dir not found"
        fi
        local py_library=`ls /usr/lib64/libpython${short_py_ver}*.so` # 2> /dev/null`
        if [[ -f ${py_library} ]]; then
            eval $5=${py_library}
        else
            echo "find_python(): ERROR: Python library not found"
            error=true
        fi
    else
        echo "find_python(): ERROR: Python executable not found: $1"
        error=true
    fi
    if [ "$error" = true ]; then
        exit 1
    fi
}

if [[ -z ${JENKINS_HOME+x} ]]; then
    JENKINS_HOME="/var/lib/jenkins"
fi
echo "JENKINS_HOME=${JENKINS_HOME}"

CMAKE_INSTALL_PREFIX="${JENKINS_HOME}/workspace/install"
echo "CMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}"

PROTON_SRC_DIR="${JENKINS_HOME}/workspace/build-proton/qpid-proton"
PROTON_BUILD_DIR="${PROTON_SRC_DIR}/build"
PROTON_BINDINGS_INSTALL_DIR="${CMAKE_INSTALL_PREFIX}/lib64/proton/bindings"

# Python 2.7
find_python python PY2_EXECUTABLE PY2_VER PY2_INCLUDE_DIR PY2_LIBRARY
#PY2_EXECUTABLE="/usr/bin/python"
#PY2_INCLUDE_DIR="/usr/include/python2.7"
#PY2_LIBRARY="/usr/lib64/libpython2.7.so"
CMAKE_PY2_OPTS="-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DBUILD_PYTHON="ON" -DPYTHON_EXECUTABLE=${PY2_EXECUTABLE} -DPYTHON_INCLUDE_DIR=${PY2_INCLUDE_DIR} -DPYTHON_LIBRARY=${PY2_LIBRARY}"

# Python 3.x
find_python python3 PY3_EXECUTABLE PY3_VER PY3_INCLUDE_DIR PY3_LIBRARY
#PY3_EXECUTABLE="/usr/bin/python3.4m"
#PY3_INCLUDE_DIR="/usr/include/python3.4m"
#PY3_LIBRARY="/usr/lib64/libpython3.4m.so"
CMAKE_PY3_OPTS="-DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DBUILD_PYTHON="ON" -DPYTHON_EXECUTABLE=${PY3_EXECUTABLE} -DPYTHON_INCLUDE_DIR=${PY3_INCLUDE_DIR} -DPYTHON_LIBRARY=${PY3_LIBRARY}"
