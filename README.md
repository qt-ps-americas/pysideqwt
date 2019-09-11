## Pysideqwt - Python bindings for the Qwt Qt-based plotting library

### Dependencies

* Qt 5.12+ (tested with Qt 5.12.4)
  You can use the version installable from your qt.io account at:
      https://account.qt.io/downloads
  Or you can use one of the offline installers located at:
      https://download.qt.io/official_releases/qt/5.12/5.12.4/qt-opensource-windows-x86-5.12.4.exe

  In order for Qt to be found properly, you need to do one of the following:
    * Add <Qt Dir>/bin to your path so qmake can be found.
    * On Windows, use Qt version 5.12.4, installed to the default location of
      C:\Qt\5.12.4.
    * On Windows, edit setup.bat, modifying cmake command line option -DQt5_DIR=
      to point to the location of the Qt5 cmake module files inside your Qt
      installation like so:
        -DQt5_DIR=<Path to Qt dir>\<Qt version #>\msvc2017_64\lib\cmake\Qt5

* PySide2 installed. Please try to match the Qt version and PySide2 version.
  See: https://wiki.qt.io/Qt_for_Python/GettingStarted
  * For Windows, please build PySide2 from sources, following the instructions
    in README.pyside2.md.
    If you do not, you may find issues with Visual Studio headers complaining
    that your CLANG version is too old (VS2017 headers require CLang v7+)

* shiboken2-generator installed.  If you built PySide2 from source, you should have this. If you used pip install PySide2, it only installs shiboken2 and Pyside2, not the shiboken2-generator. You can find wheels for the generator at http://download.qt.io/snapshots/ci/pyside/QtVersion#/latest/pyside2/. Download the version appropriate for your OS and run pip install on it.  

* Qwt 6.2
    * Qwt 6.2:
        * Get Qwt 6.2 by checking the code out using this subversion command line:
          $ svn checkout svn://svn.code.sf.net/p/qwt/code/branches/qwt-6.2
        * Windows only: Modify `src/qwt_series_store.h` to remove `QWT_EXPORT`
          from the `QwtSeriesStore` class definition in order to build properly.
          This may be fixed at the time you try this, so do check first to see
          if it builds without this change.

    * Build as normal per Qwt instructions at: http://qwt.sourceforge.net/qwtinstall.html
    * Install to standard location - for Windows this is `C:\Qwt-6.2.0-svn` -- this way pysideqwt will know how to find it.

### Building for Windows

* Add `C:\Program Files\Git\cmd` and `C:\Program Files\Git\usr\bin` to your system environment PATH variables.  (Note: Should remove dependency on unix-like pushd and rmdir tools, and use windows-native versions)
* Make sure Python 3 is in your system environment PATH variable.
* For a faster build, put nmake replacement jom in your path
* Start a Visual Studio 2017 x64 command line prompt
* Run setup.bat - this will do the build for you and install pysideqwt into the `site-packages` directory of the Python installation in your path.

### Building for Linux or Mac

* Open a terminal
* Run setup.sh -- this will do the build for you and install pysideqwt into the `site-packages` directory of the Python installation in your path.

### Using Pysideqwt in your python applications

* On Windows, make sure that the <Qwt Dir>/lib directory is in the path, so that the qwt.dll can be found.  If you encounter the error "ImportError: DLL load failed: The specified module could not be found.", it is likely because qwt.dll could not be found.

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
