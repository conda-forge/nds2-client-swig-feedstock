:: use local build folder
set "_builddir=_build_java"
mkdir "%_builddir%"
cd "%_builddir%"

:: configure
cmake "%SRC_DIR%" ^
	-G "NMake Makefiles" ^
	-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo ^
	-DCMAKE_DISABLE_FIND_PACKAGE_Doxygen:BOOL=yes ^
	-DCMAKE_INSTALL_PREFIX:PATH="%PREFIX%" ^
	-DCMAKE_PREFIX_PATH:PATH="%LIBRARY_PREFIX%" ^
	-Dnds2-client_DIR:PATH="%LIBRARY_BIN%" ^
	-DENABLE_SWIG_JAVA:BOOL=yes ^
	-DENABLE_SWIG_MATLAB:BOOL=no ^
	-DENABLE_SWIG_OCTAVE:BOOL=no ^
	-DENABLE_SWIG_PYTHON2:BOOL=no ^
	-DENABLE_SWIG_PYTHON3:BOOL=no
if errorlevel 1 exit 1

:: build
cmake --build java --parallel "%CPU_COUNT%" --verbose
if errorlevel 1 exit 1

:: install
cmake --build java --parallel "%CPU_COUNT%" --verbose --target install
if errorlevel 1 exit 1

:: test
ctest --parallel "%CPU_COUNT%" --extra-verbose --output-on-failure
if errorlevel 1 exit 1
