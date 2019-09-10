## Pysideqwt - Python bindings for the Qwt Qt-based plotting library

### Dependencies

* Qt 5.12+ (tested with Qt 5.12.0)
  You can use the version installable from your qt.io account at:
      https://account.qt.io/downloads
  Or you can use one of the offline installers located at:
      https://download.qt.io/official_releases/qt/5.12/5.12.0/qt-opensource-windows-x86-5.12.0.exe

  On windows, if you install Qt to a location other than the deafult (C:\Qt) or
  install a version other than 5.12.0, you will need to modify setup.bat,
  changing the -DQt5_DIR= argument to cmake to point to the location of the
  cmake modules inside of your Qt installation. it will take the form of:
      <Path to Qt dir>\<Qt version #>\msvc2017_64\lib\cmake\Qt5

* PySide2 installed. Please try to match the Qt version and PySide2 version.
  See: https://wiki.qt.io/Qt_for_Python/GettingStarted

* Qwt 6.2.x (as of 20180920, only available via SVN checkout, qwt-6.2 branch)
    * Check the code out using this subversion command line:
      $ svn checkout svn://svn.code.sf.net/p/qwt/code/branches/qwt-6.2

    * Windows only: Modify `src/qwt_series_store.h` to remove `QWT_EXPORT` from the `QwtSeriesStore` class definition in order to build properly.
      This may be fixed at the time you try this, so do check first to see if it builds without this change.

    * Build as normal per Qwt instructions at: http://qwt.sourceforge.net/qwtinstall.html

    * Install to standard location - for Windows this is `C:\Qwt-6.2.0-svn` -- this way pysideqwt will know how to find it.

### Building for Windows

* Add `C:\Program Files\Git\cmd` and `C:\Program Files\Git\usr\bin` to your system environment variables.  (Note: Should remove dependency on unix-like pushd and rmdir tools, and use windows-native versions)
* Start a Visual Studio 2017 x64 command line prompt
* Run setup.bat - this will do the build for you and install pysideqwt into the `site-packages` directory of the Python installation in your path.

### Building for Linux or Mac

* Open a terminal
* Run setup.sh -- this will do the build for you and install pysideqwt into the `site-packages` directory of the Python installation in your path.

### Using Pysideqwt in your python applications

Once installed, it can be found by your python code using:
~~~~
from pysideqwt.pysideqwt import *
~~~~

* To verify that the wrapper has been built properly, run one of the python scripts in the examples directory
~~~~
python examples/test_plot.py
~~~~
* or
~~~~
python examples/test_logarithmic_plot.py
~~~~