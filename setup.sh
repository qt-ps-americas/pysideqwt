#!/bin/sh

set -eu

# build
rm -rf ./build
mkdir build
cd build
cmake -H.. -B. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release
make -j8
make install

# fix qwt.framework linking on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    install_name_tool -change qwt.framework/Versions/6/qwt @rpath/qwt.framework/Versions/6/qwt ../package/pysideqwt/pysideqwt.so
fi

# install
cd ../package
pip install . --upgrade --force-reinstall
