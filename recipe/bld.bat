:: use local build folder
mkdir _build
cd _build

:: configure
cmake "%SRC_DIR%" ^
    -DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo ^
    -DCMAKE_DISABLE_FIND_PACKAGE_Doxygen:BOOL=yes ^
    -DCMAKE_DISABLE_FIND_PACKAGE_Java:BOOL=yes ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_PREFIX_PATH:PATH="%LIBRARY_BIN%" ^
    -DENABLE_SWIG_JAVA:BOOL=no ^
    -DENABLE_SWIG_MATLAB:BOOL=no ^
    -DENABLE_SWIG_OCTAVE:BOOL=no ^
    -DENABLE_SWIG_PYTHON2:BOOL=no ^
    -DENABLE_SWIG_PYTHON3:BOOL=no
if errorlevel 1 exit 1

cmake --build . --parallel %CPU_COUNT%
if errorlevel 1 exit 1

ctest --extra-verbose --output-on-failure
if errorlevel 1 exit 1

cmake --build . --parallel %CPU_COUNT% --target install
if errorlevel 1 exit 1
