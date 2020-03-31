#!/bin/bash
#
# Build the common SWIG Interface libraries for the NDS2Client
#
# This script needs: ${c_compiler}, ${cxx_compiler}
#

set -ex

mkdir -p build
pushd build

cmake ${SRC_DIR} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo \
  -DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=yes \
  -DENABLE_SWIG_JAVA=no \
  -DENABLE_SWIG_MATLAB=no \
  -DENABLE_SWIG_OCTAVE=no \
  -DENABLE_SWIG_PYTHON2=no \
  -DENABLE_SWIG_PYTHON3=no

cmake --build . -- -j${CPU_COUNT}

ctest --extra-verbose --output-on-failure

cmake --build . --target install
