setlocal EnableDelayedExpansion

:: use local build folder
mkdir build
cd build

:: choose between python2 and python3
if %PY3K% equ 1 (
	set _PYTHON_BUILD_OPTS="-DENABLE_SWIG_PYTHON2=no -DENABLE_SWIG_PYTHON3=yes -DPYTHON3_EXECUTABLE=${PYTHON}"
) else (
	set _PYTHON_BUILD_OPTS="-DENABLE_SWIG_PYTHON3=no -DENABLE_SWIG_PYTHON2=yes -DPYTHON2_EXECUTABLE=${PYTHON}"
)

:: configure
cmake .. \
	-G "%CMAKE_GENERATOR%" ^
	-DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
	-DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%"\bin ^
	-DWITH_GSSAPI:PATH="%LIBRARY_PREFIX%" ^
	-DWITH_SASL=no ^
	-DENABLE_SWIG_JAVA=false ^
	-DENABLE_SWIG_MATLAB=false ^
	-DENABLE_SWIG_OCTAVE=false ^
	%_PYTHON_BUILD_OPTS% ^
	-DPYTHON_NUMPY_INCLUDE_PATH:PATH="%SP_DIR%"\numpy\core\include ^
	-DPYTHON_MODULE_INSTALL_DIR:PATH="%SP_DIR%" ^
	-DPYTHON_EXTMODULE_INSTALL_DIR:PATH="%SP_DIR%" ^
        -DCMAKE_BUILD_TYPE:STRING=Release ^
if errorlevel 1 exit 1

:: build
cmake --build . --config Release
if errorlevel 1 exit 1

:: install
cmake --build . --config Release --target install
if errorlevel 1 exit 1
