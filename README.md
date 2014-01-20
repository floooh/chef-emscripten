### Description ###

Setup an emscripten build environment.

What happens under the hood:

* makes sure that git, python and node.js is installed (through standard cookbooks)
* installs a JRE (default is the package 'default-jre')
* creates a .emscripten file in the user's home directory
* create a directory /usr/local/src/emscripten-sdk
* download and install llvm+clang 3.2 tarball to /usr/local/src/emscripten-sdk/clang
* git clone the emscripten sdk to /usr/local/src/emscripten-sdk/emscripten
* git checkout the wanted branch (default is 'master')
* create a /etc/profile.d/emscripten-sdk.sh with the EMSCRIPTEN environment variable, and PATH to the emscripten directory

### Requirements ###
#### Platform: ####

* Ubuntu/Debian

#### Dependencies ####

* apt
* git
* python
* nodejs
* ark

### Attributes ###
#### Default recipe attributes: ####

NOTE: you will most likely want to tweak the `node['emscripten']['clang']['system']` 
attribute for your Linux system, and make sure that a matching .tar.gz tarball exists
at http://llvm.org/releases/3.2

* `node['emscripten']['user'] = 'vagrant'`: user for file permissions and determining home dir
* `node['emscripten']['group'] = 'vagrant'`: group for file permissions
* `node['emscripten']['rootpath'] = '/usr/local/src/emscripten-sdk'`: where to put the files
* `node'emscripten']['url'] = 'git://github.com/kripken/emscripten.git'`: where to get the emscripten SDK
* `node['emscripten']['branch'] = 'master'`: what git branch to checkout (alternative: 'incoming')
* `node['emscripten']['python'] = '/usr/bin/python'`: which python executable emscripten uses (goes into .emscripten file)
* `node['emscripten']['nodejs'] = '/usr/local/bin/node'`: where to find node.js (goes into .emscripten file)
* `node['emscripten']['jre'] = 'default-jre'`: which JRE to use (package name)
* `node['emscripten']['clang']['version'] = '3.2'`: what clang version to use
* `node['emscripten']['clang']['arch'] = 'x86_64'`: CPU architecture for precompiled clang
* `node['emscripten']['clang']['system'] = 'linux-ubuntu-12.04'`: system identifier for the clang precompiled tarball
* `default['emscripten']['clang']['url_prefix'] = 'http://llvm.org/releases'`: where to find the clang tarballs

The full download URL for the clang tarball is built from _version_, _arch_, _system_ and _url_prefix_, the default is:

**http://llvm.org/releases/3.2/clang+llvm-3.2-x86_64-linux-ubuntu-12.04.tar.gz**

### Author ####
Author:: Andre Weissflog (floooh@gmail.com)
