#!/usr/bin/python
# $Id$

from distutils.core import setup

args = {
    'name': 'dctrl2xml',
    'version': '0.1',
    'description': '',
    'author': 'Frank S. Thomas',
    'author_email': 'frank@thomas-alfeld.de',
    'license': 'GNU GPL',
    'scripts': (
	'dctrl2xml'
    )
}

if __name__ == '__main__':
    setup(**args)
