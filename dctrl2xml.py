#!/usr/bin/python
# $Id$
#
# packages2xml.py
# Copyright (C) 2005 by Frank S. Thomas <frank@thomas-alfeld.de>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License 
# along with this program; if not, write to the
# Free Software Foundation, Inc.,
# 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

import sys
import re
import gzip
import bz2

from optparse import OptionParser
from xml.dom import minidom, Document, Node
from xml.dom.ext import PrettyPrint

def main():
    opts = parse_options()
    packages = read_packages(opts.filename)

    doc  = minidom.parseString('<packages/>')
    root = doc.documentElement
    
    for pkg_text in packages:
        append_package_node(doc, root, pkg_text)

    PrettyPrint(doc)
    return
    
def append_package_node(doc, root, pkg_text):
    if pkg_text.strip() == '':
        return
        
    parse_package(pkg_text)
    
def parse_package(pkg_text):
    parsed_pkg = {}
    it = re.compile(r'([\w-]*): (.*)').finditer(pkg_text)
    for match in it:
        parsed_pkg[match.group(1)] = match.group(2)
    
    if parsed_pkg.has_key('Binary'):
        parsed_pkg['Type'] = 'source'
        parsed_pkg['Files'] = parse_package_source_files(pkg_text)
    else:
        parsed_pkg['Type'] = 'binary'
    
    # parse maintainer field
    if parsed_pkg.has_key('Maintainer'):
        match = re.compile(r'(.*) <(.*)>').search(parsed_pkg['Maintainer'])
        if match:
            parsed_pkg['Maintainer'] = {'Name': match.group(1),
                                        'Email': match.group(2)}
    # parse package relationships
    rel = ['Depends', 'Pre-Depends', 'Suggests', 'Recommends', 'Conflicts',
           'Provides', 'Replaces', 'Enhances', 'Build-Depends',
           'Build-Depends-Indep', 'Build-Conflicts']
    for field in parsed_pkg.iterkeys():
        if field in rel:
            parsed_pkg[field] = parse_package_relationship(parsed_pkg[field])
    
    return parsed_pkg
    
def parse_package_relationship(rel_text):
    print rel_text.split(', ')
    
def parse_package_source_files(pkg_text):
    files = {'DSC':{}, 'Diff':{}, 'Orig':{}}
    files_re = {'DSC': '.*.dsc', 'Diff': '.*.diff.gz',
                'Orig': '.*.orig.tar.gz'}
    
    it = re.compile(r' ([0-9a-f]{32}.*)').finditer(pkg_text)
    for file_line in it:
        if file_line.group(1): # line without leading space
            attrs = file_line.group(1).split(' ')
            for file_type, file_re in files_re.iteritems():                
                if re.search(file_re, attrs[2]):
                    files[file_type]['MD5sum'] = attrs[0]
                    files[file_type]['Size'] = attrs[1]
                    files[file_type]['Filename'] = attrs[2]
    return files
    
def read_packages(filename):
    if not filename:
        packages = sys.stdin.read()
    else:
        packages = read_packages_from_file(filename)

    packages = re.compile('^\n', re.M).split(packages)
    return packages
    
def read_packages_from_file(filename):
    extension = filename.split('.')[-1]

    if extension == 'gz':
        file_obj = gzip.GzipFile
    elif extension == 'bz2':
        file_obj = bz2.BZ2File
    else:
        file_obj = file

    try:
        content = file_obj(filename, 'r').read()
    except IOError, error:
        print error
        sys.exit(error.args[0]);
    
    return content
    
def parse_options():
    parser = OptionParser()
    parser.add_option('-f', '--file', dest='filename', default='',
                      metavar='FILE')
    (opts, args) = parser.parse_args()
    return opts
    
if __name__ == '__main__':
    main()
