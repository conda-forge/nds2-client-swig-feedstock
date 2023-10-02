#!/bin/bash
#
# Build and install the Python bindings for the NDS2Client
#

set -ex
mkdir -p _build${PY_VER}
cd _build${PY_VER}

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
	-DENABLE_SWIG_PYTHON3:BOOL=yes \
	-DPYTHON3_VERSION:STRING=${PY_VER} \
	-DSWIG_EXECUTABLE:PATH="${BUILD_PREFIX}/bin/swig" \
;

# build
cmake --build python --parallel ${CPU_COUNT} --verbose

# install
cmake --build python --parallel ${CPU_COUNT} --verbose --target install

# test
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
export TEST_VERBOSE_LEVEL=100
ctest --parallel ${CPU_COUNT} --extra-verbose --output-on-failure
fi

# remove unnecessary testing files
rm -rvf ${PREFIX}/libexec/nds2-client
