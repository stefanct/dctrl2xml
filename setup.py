#!/usr/bin/python

from distutils.core import setup

args = {
    'name': 'dctrl2xml',
    'version': '0.7',
    'description': 'convert Debian control data to XML',
    'author': 'Frank S. Thomas',
    'author_email': 'fst@debian.org',
    'scripts': ['dctrl2xml'],
    'license': 'GPL-3+'
}

if __name__ == '__main__':
    setup(**args)
