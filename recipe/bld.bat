setlocal EnableDelayedExpansion

:: use local build folder
mkdir build
cd build

:: configure
cmake .. ^
	-G "%CMAKE_GENERATOR%" ^
	-DCMAKE_BUILD_TYPE:STRING=Release ^
	-DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
	-DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%"\bin ^
	-DWITH_GSSAPI:PATH="%LIBRARY_PREFIX%" ^
	-DWITH_SASL=no ^
	-DENABLE_SWIG_JAVA=false ^
	-DENABLE_SWIG_MATLAB=false ^
	-DENABLE_SWIG_OCTAVE=false ^
	-DENABLE_SWIG_PYTHON2=no ^
	-DENABLE_SWIG_PYTHON3=yes ^
	-DPYTHON_EXECUTABLE:PATH="%PYTHON%"
if errorlevel 1 exit 1

:: build
cmake --build . --config Release
if errorlevel 1 exit 1

:: install
cmake --build . --config Release --target install
if errorlevel 1 exit 1
