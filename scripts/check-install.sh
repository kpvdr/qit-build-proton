#! /bin/bash

. ./scripts/common.sh

error_found=false
declare -a PYTHON_DIR_ARRAY=("python" "python3")
for PY_DIR in ${PYTHON_DIR_ARRAY[@]}; do
    if [[ -f ${PROTON_BINDINGS_INSTALL_DIR}/${PY_DIR}/_cproton.so ]]; then
        echo "${PROTON_BINDINGS_INSTALL_DIR}/${PY_DIR}/_cproton.so found - ok"
    else
        echo "error: ${PROTON_BINDINGS_INSTALL_DIR}/${PY_DIR}/_cproton.so missing"
        error_found=true
    fi
done
if [[ ${error_found}=true ]]; then
    echo "ERROR: missing library file(s) - exiting with error"
    exit 1
fi
