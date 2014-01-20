#
#   Cookbook Name: emscripten
#   Attributes: default
#

# user name and root path for which to install all emscripten related files (must be in user dir!)
default['emscripten']['user'] = 'vagrant'
default['emscripten']['group'] = 'vagrant'
default['emscripten']['rootpath'] = '/usr/local/src/emscripten-sdk'

# git URL and branch name from which to fetch the emscripten SDK
default['emscripten']['url']    = 'git://github.com/kripken/emscripten.git'
default['emscripten']['branch'] = 'master'

# where does emscripten find these executables:
default['emscripten']['python'] = '/usr/bin/python'
default['emscripten']['nodejs'] = '/usr/local/bin/node'

# package name that provides the Jave Runtime Environment
default['emscripten']['jre'] = 'default-jre'

# what clang-version to use
default['emscripten']['clang']['version'] = '3.2'

# the architecture for the clang tarball
default['emscripten']['clang']['arch'] = 'x86_64'

# the system name for the clang tarball
default['emscripten']['clang']['system'] = 'linux-ubuntu-12.04'

# the download url
# full url will be "[url_prefix]/[version]/clang+llvm-[version]-[arch]-[system]"
default['emscripten']['clang']['url_prefix'] = 'http://llvm.org/releases'
