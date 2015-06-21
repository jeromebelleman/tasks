#!/usr/bin/env python

from distutils.core import setup

setup(name='tasks',
      scripts=['tasks'],
      data_files=[
                  ('share/tasks', ['vimrc', 'template']),
                 ],
     )
