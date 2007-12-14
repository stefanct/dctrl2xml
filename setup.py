#!/usr/bin/python

from distutils.core import setup

args = {
    'name': 'dctrl2xml',
    'version': '0.7',
    'description': 'Debian package control file to XML converter',
    'author': 'Frank S. Thomas',
    'author_email': 'fst@debian.org',
    'license': 'GNU GPL',
    'scripts': (
        'scripts/dctrl2xml',
    )
}

if __name__ == '__main__':
    setup(**args)
