# encoding: UTF-8
#
# Cookbook Name:: emscripten
# Recipe:: default
#
# Copyright (C) 2014 Andre Weissflog
#
include_recipe 'apt'
include_recipe 'git'
include_recipe 'python'
include_recipe 'nodejs'
include_recipe 'ark'

user = node['emscripten']['user']
group = node['emscripten']['user']
repo = node['emscripten']['url']
repo_fastcomp = node['emscripten']['fastcomp_url']
repo_fastcomp_clang = node['emscripten']['fastcomp_clang_url']

branch = node['emscripten']['branch']
rootpath = node['emscripten']['rootpath']
home = "/home/#{user}"

# make sure a JRE is installed
package node['emscripten']['jre']

# make sure a clang is installed, we need to compile clang with clang
package node['emscripten']['clang']

# setup the .emscripten file
template "#{home}/.emscripten" do
  source 'emscripten.erb'
  owner user
  group group
  mode '0644'
end

# make sure the sdk root directory exists
directory rootpath do
  owner user
  group group
  action :create
end

# get the fastcomp-LLVM repository
git "#{rootpath}/emscripten-fastcomp" do
  repository repo_fastcomp
  revision branch
  user user
  group group
  action :sync
end

# get the fastcomp-clang repository
git "#{rootpath}/emscripten-fastcomp/tools/clang" do
  repository repo_fastcomp_clang
  revision branch
  user user
  group group
  action :sync
end

# clone emscripten
git "#{rootpath}/emscripten" do
  repository repo
  revision branch
  user user
  group group
  action :sync
end

# build clang with clang
bash 'build_clang' do
  cwd "#{rootpath}/emscripten-fastcomp"
  user user
  group group
  code <<-EOH
    mkdir build
    cd build
    CC=/usr/bin/clang CXX=/usr/bin/clang++ ../configure --enable-optimized --disable-assertions --enable-targets=host,js
    make -j2
  EOH
end

# add EMSCRIPTEN env var and PATH to .bash_profile
bash 'update_profile' do
  cwd home
  user user
  group group
  code <<-EOH
    echo "export EMSCRIPTEN=#{rootpath}/emscripten" >>.bash_profile
    echo "export PATH=$PATH:#{rootpath}/emscripten" >>.bash_profile
  EOH
  not_if 'test -e .bash_profile && grep -q EMSCRIPTEN .bash_profile'
end
