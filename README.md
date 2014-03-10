### Description ###

This is a Chef cookbook to setup an emscripten build environment.

What happens under the hood:

* makes sure that git, python and node.js is installed (through standard cookbooks)
* installs a JRE (default is the package 'default-jre')
* creates a ~/.emscripten file
* creates a ~/emscripten-sdk directory 
* installs standard clang-3.3 package to bootstrap the emscript-fastcomp LLVM backend
* setup emscripten-fastcomp as described here: https://github.com/kripken/emscripten/wiki/LLVM-Backend
* git clone the emscripten sdk to ~/emscripten-sdk/emscripten
* add EMSCRIPTEN environment variable and path to .bash_profile

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

* `node['emscripten']['user'] = 'vagrant'`: user for file permissions and determining home dir
* `node['emscripten']['group'] = 'vagrant'`: group for file permissions
* `node['emscripten']['rootpath'] = '/home/vagrant/emscripten-sdk'`: where to put the files
* `node'emscripten']['url'] = 'git://github.com/kripken/emscripten.git'`: where to get the emscripten SDK
* `default['emscripten']['fastcomp_url'] = 'git://github.com/kripken/emscripten-fastcomp.git'`: where to find the emscripten-fastcomp repository
* `default['emscripten']['fastcomp_clang_url'] = 'git://github.com/kripken/emscripten-fastcomp-clang.git'`: where to find the emscripten-fastcomp-clang respository
* `node['emscripten']['branch'] = 'master'`: what git branch to checkout (alternative: 'incoming')
* `node['emscripten']['python'] = '/usr/bin/python'`: which python executable emscripten uses (goes into .emscripten file)
* `node['emscripten']['nodejs'] = '/usr/local/bin/node'`: where to find node.js (goes into .emscripten file)
* `node['emscripten']['jre'] = 'default-jre'`: which JRE to use (package name)
* `node['emscripten']['clang'] = 'clang-3.3'`: package name of default clang used to compile emscripten-fastcomp-clang

### Author ####
Author:: Andre Weissflog (floooh@gmail.com)
