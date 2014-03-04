# encoding: UTF-8
#
#   Cookbook Name: emscripten
#   Attributes: default
#

# user name and root path for which to install all emscripten related files
# we put this stuff locally into the user directory by default
default['emscripten']['user'] = 'vagrant'
default['emscripten']['group'] = 'vagrant'
default['emscripten']['rootpath'] = '/home/vagrant/emscripten-sdk'

# git URL and branch name from which to fetch the emscripten SDK
default['emscripten']['url']    = 'git://github.com/kripken/emscripten.git'
default['emscripten']['branch'] = 'master'

# where does emscripten find these executables:
default['emscripten']['python'] = '/usr/bin/python'
default['emscripten']['nodejs'] = '/usr/local/bin/node'

# package name that provides the Jave Runtime Environment
default['emscripten']['jre'] = 'default-jre'
