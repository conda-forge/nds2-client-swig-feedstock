#!/bin/bash

set -ex

mkdir -p _build
pushd _build

# configure
cmake \
	${SRC_DIR} \
	${CMAKE_ARGS} \
	-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo \
	-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen:BOOL=yes \
	-DENABLE_SWIG_JAVA:BOOL=no \
	-DENABLE_SWIG_MATLAB:BOOL=no \
	-DENABLE_SWIG_OCTAVE:BOOL=no \
	-DENABLE_SWIG_PYTHON2:BOOL=no \
	-DENABLE_SWIG_PYTHON3:BOOL=no \
;

# build
cmake --build . --parallel ${CPU_COUNT} --verbose

# test
ctest --parallel ${CPU_COUNT} --extra-verbose --output-on-failure

# install
cmake --build . --parallel ${CPU_COUNT} --verbose --target install
