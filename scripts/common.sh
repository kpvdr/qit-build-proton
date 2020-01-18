#! /bin/bash

# Find details for a given python executable
# S1: Python executable
# $2: Variable name for executable
# $3: Variable name for version
# $4: Variable name for include dir
# $5: Variable name for lib
find_python() {
    if [ "$#" -ne 5 ]; then
        echo "find_python(): ERROR: Incorrect number of arguments"
        exit 1
    fi
    eval $2=`which $1` # 2> /dev/null`
    if [[ $? == 0 ]]; then
        #eval echo "$2=\$$2"
        local py_ver=`$1 --version 2>&1 | sed -e 's/[[:alpha:]|(|[:space:]]//g'`
        eval $3=${py_ver}
        #eval echo "$3=\$$3"
        local short_py_ver=${py_ver%.*} # x.y.z -> x.y
        local py_include_dir=`ls -d /usr/include/python${short_py_ver}*` # 2> /dev/null`
        if [[ -d ${py_include_dir} ]]; then
            eval $4=${py_include_dir}
            #eval echo "$4=\$$4"
        else
            error=true
            echo "find_python(): ERROR: Python include dir not found"
        fi
        local py_library=`ls /usr/lib64/libpython${short_py_ver}*.so` # 2> /dev/null`
        if [[ -f ${py_library} ]]; then
            eval $5=${py_library}
            #eval echo "$5=\$$5"
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

