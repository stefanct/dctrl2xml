#!/usr/bin/python
# $Id$

from distutils.core import setup

args = {
    'name': 'dctrl2xml',
    'version': '0.4',
    'description': 'Debian package control file to XML converter',
    'author': 'Frank S. Thomas',
    'author_email': 'frank@thomas-alfeld.de',
    'url': 'http://www.thomas-alfeld.de/frank/download/debian/dctrl2xml/',
    'license': 'GNU GPL',
    'scripts': (
        'scripts/dctrl2xml',
    )
}

if __name__ == '__main__':
    setup(**args)
