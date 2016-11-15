#!/usr/bin/env python
# coding=utf-8

import os
from distutils.core import setup

setup(
    name='tasks',
    version='1.0',
    author='Jérôme Belleman',
    author_email='Jerome.Belleman@gmail.com',
    url='http://cern.ch/jbl',
    description='"Manage tasks"',
    long_description='"Manage tasks in projects, according to priority, using Vim."',
    scripts=['tasks'],
    data_files=[('share/tasks', ['vimrc', 'template']), ('share/man/man1', ['tasks.1'])],
)
