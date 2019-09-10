from os import name as osname, environ, pathsep, path
import shiboken2

if osname == 'nt':
    environ["PATH"] += pathsep + path.realpath(path.dirname(shiboken2.__file__))
