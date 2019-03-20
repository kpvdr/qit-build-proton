#! /bin/bash

. ./scripts/common.sh


#USR=`whoami`
#echo "USER=${USER}"
#PWD=`pwd`
#echo "PWD=${PWD}"
#sudo -u jenkins mkdir -p ${CMAKE_INSTALL_PREFIX}
#echo "mkdir returned $?"
#echo "Contents of install dir ${CMAKE_INSTALL_PREFIX}:"
#ls -la ${CMAKE_INSTALL_PREFIX}
#sudo -u jenkins touch ${CMAKE_INSTALL_PREFIX}/test.xxx
#echo "touch returned $?"

cd ${PROTON_BUILD_DIR}
make install
mv ${PROTON_BINDINGS_INSTALL_DIR}/python ${PROTON_BINDINGS_INSTALL_DIR}/python3
