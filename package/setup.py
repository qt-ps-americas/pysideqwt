from setuptools import setup
import os
from glob import iglob

# By default, QWT is built as a framework on macOS;
# A framwork in terms of filesystem is a regular folder;
# We can not include a directory in "package_data".
def frameworkFiles(framework):
    paths = []
    for dirpath, dirnames, filenames in os.walk(framework):
        for filename in filenames:
            path = os.path.join("..", dirpath, filename)
            if os.path.islink(path):
                continue
            paths.append(path)
    return paths

qwtFrameworkFiles = sum([ frameworkFiles(framework) for framework in iglob('pysideqwt/*.framework') ], [])

setup(name='pysideqwt',
    version = '1.0',
    description = 'Python binding for QWT',
    url = 'https://git.qt.io/consulting-usa/pysideqwt',
    author = 'Oleg Yadrov',
    author_email = 'oleg.yadrov@qt.io',
    license = 'LGPL',
    packages = ['pysideqwt'],
    package_dir = {'pysideqwt': 'pysideqwt'},
    package_data = {'pysideqwt': ['libqwtaddons.*', 'pysideqwt.*', 'qwt.*', 'qwtmathml.*'] + qwtFrameworkFiles},
    include_package_data = True,
    zip_safe=False
)
