# Find Qwt
# ~~~~~~~~
# Copyright (c) 2010, Tim Sutton <tim at linfiniti.com>
# Copyright (c) 2018 Keith Kyzivat <keith.kyzivat at qt dot io>
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
# Updates by Keith Kyzivat to support qwtmathml extension library.
#
# Once run this will define:
#
# QWT_FOUND       = system has QWT lib
# QWTMATHML_FOUND       = system has QWT mathml lib
# QWT_LIBRARY     = full path to the QWT library or framework
# QWTMATHML_LIBRARY     = full path to the QWT mathml library or framework
# QWT_INCLUDE_DIR = where to find headers
# QWTMATHML_INCLUDE_DIR = where to find qwt mathml headers
#
# For Mac:
# QWT_FRAMEWORK = full path to the qwt framework directory
# QWTMATHML_FRAMEWORK = full path to the qwtmathml framework directory


set(QWT_LIBRARY_NAMES qwt-qt5 qwt6-qt5 qwt qwt6 qwt.framework qwt6.framework)
set(QWTMATHML_LIBRARY_NAMES qwtmathml-qt5 qwtmathml6-qt5 qwtmathml qwtmathml6 qwtmathml.framework, qwtmathml6.framework)
#set(QWT_PATHS
#    "C:/Qwt-6.2.0-svn"
#    /usr/local/qwt-6.2.0-svn
#    "C:/Qwt-6.1.3"
#    /usr/local/qwt-6.1.3
#    /usr/lib
#    /usr/local/lib
#    /usr/local/lib/qt5
#    "$ENV{LIB_DIR}/lib"
#    "$ENV{LIB}"
#)

set(QWT_PATHS
    "C:/Qwt-6.2.0-svn"
    /usr/local/qwt-6.2.0-svn
    /usr/local
    /usr
    "$ENV{LIB}"
)

find_library(QWT_LIBRARY
  NAMES ${QWT_LIBRARY_NAMES}
  PATHS ${QWT_PATHS}
  PATH_SUFFIXES lib lib/qt5
)
message("QWT_LIBRARY ${QWT_LIBRARY}")

find_library(QWTMATHML_LIBRARY
  NAMES ${QWTMATHML_LIBRARY_NAMES}
  PATHS ${QWT_PATHS}
  PATH_SUFFIXES lib lib/qt5
)
message("QWTMATHML_LIBRARY ${QWTMATHML_LIBRARY}")

set(_qwt_fw)
if(QWT_LIBRARY MATCHES "/qwt.*\\.framework")
  string(REGEX REPLACE "^(.*/qwt.*\\.framework).*$" "\\1" _qwt_fw "${QWT_LIBRARY}")
  set(QWT_FRAMEWORK ${_qwt_fw})
endif()

set(_qwtmathml_fw)
if(QWTMATHML_LIBRARY MATCHES "/qwtmathml.*\\.framework")
  string(REGEX REPLACE "^(.*/qwtmathml.*\\.framework).*$" "\\1" _qwtmathml_fw "${QWTMATHML_LIBRARY}")
  set(QWTMATHML_FRAMEWORK ${_qwtmathml_fw})
endif()

FIND_PATH(QWT_INCLUDE_DIR NAMES qwt.h PATHS
  "${_qwt_fw}/Headers"
  "C:/Qwt-6.2.0-svn/include"
  /usr/local/qwt-6.2.0-svn/include
  /usr/include
  /usr/local/include
  /usr/local/include/qt5
  "$ENV{LIB_DIR}/include"
  "$ENV{INCLUDE}"
  PATH_SUFFIXES qwt-qt5 qwt qwt6
)
message("QWT_INCLUDE_DIR: ${QWT_INCLUDE_DIR}")

FIND_PATH(QWTMATHML_INCLUDE_DIR NAMES qwt_mathml_text_engine.h PATHS
  "${_qwtmathml_fw}/Headers"
  "C:/Qwt-6.2.0-svn/include"
  /usr/local/qwt-6.2.0-svn/include
  /usr/include
  /usr/local/include
  /usr/local/include/qt5
  "$ENV{LIB_DIR}/include"
  "$ENV{INCLUDE}"
  PATH_SUFFIXES qwt-qt5 qwt qwt6
)

IF (QWT_INCLUDE_DIR AND QWT_LIBRARY)
  SET(QWT_FOUND TRUE)
  IF (QWTMATHML_INCLUDE_DIR AND QWTMATHML_LIBRARY)
    SET(QWTMATHML_FOUND TRUE)
  ENDIF (QWTMATHML_INCLUDE_DIR AND QWTMATHML_LIBRARY)
ENDIF (QWT_INCLUDE_DIR AND QWT_LIBRARY)


IF (QWT_FOUND)
  FILE(READ ${QWT_INCLUDE_DIR}/qwt_global.h qwt_header)
  STRING(REGEX REPLACE "^.*QWT_VERSION_STR +\"([^\"]+)\".*$" "\\1" QWT_VERSION_STR "${qwt_header}")
  IF (NOT QWT_FIND_QUIETLY)
    MESSAGE(STATUS "Found Qwt: ${QWT_LIBRARY} (${QWT_VERSION_STR})")
  ENDIF (NOT QWT_FIND_QUIETLY)

  IF (QWTMATHML_FOUND)
    IF (NOT QWT_FIND_QUIETLY)
      MESSAGE(STATUS "Found Qwt mathml: ${QWTMATHML_LIBRARY}")
    ENDIF (NOT QWT_FIND_QUIETLY)
  ELSE (QWTMATHML_FOUND)
    IF (QWTMATHML_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could not find Qwt mathml")
    ENDIF (QWTMATHML_FIND_REQUIRED)
  ENDIF (QWTMATHML_FOUND)
ELSE (QWT_FOUND)
  IF (QWT_FIND_REQUIRED)
    MESSAGE(FATAL_ERROR "Could not find Qwt")
  ENDIF (QWT_FIND_REQUIRED)
ENDIF (QWT_FOUND)
