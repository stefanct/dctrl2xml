#!/usr/bin/python

from distutils.core import setup

args = {
    'name': 'dctrl2xml',
    'version': '0.14',
    'description': 'Debian control data to XML converter',
    'author': 'Frank S. Thomas',
    'author_email': 'fst@debian.org',
    'url': 'http://packages.debian.org/sid/dctrl2xml',
    'scripts': ['dctrl2xml'],
    'license': 'GPL-3+'
}

if __name__ == '__main__':
    setup(**args)
