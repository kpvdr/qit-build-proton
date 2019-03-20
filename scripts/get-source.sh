#! /bin/bash

PROTON_GIT_REPO="https://github.com/apache/qpid-proton.git"

if [[ -d qpid-proton ]]; then
    cd qpid-proton
    git pull ${PROTON_GIT_REPO}
else
    git clone ${PROTON_GIT_REPO}
fi
