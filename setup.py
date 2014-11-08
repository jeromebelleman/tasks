#!/usr/bin/env python

from distutils.core import setup

setup(name='tasks',
      version='1.0',
      scripts=['tasks'],
      data_files=[
                  ('/usr/share/tasks', ['vimrc']),
                 ],
     )
