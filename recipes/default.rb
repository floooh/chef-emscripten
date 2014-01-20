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

user = "#{node['emscripten']['user']}"
group = "#{node['emscripten']['user']}"
repo = "#{node['emscripten']['url']}"
branch = "#{node['emscripten']['branch']}"
rootpath = "#{node['emscripten']['rootpath']}"
home = "/home/#{user}"

clang_version    = "#{node['emscripten']['clang']['version']}"
clang_arch       = "#{node['emscripten']['clang']['arch']}"
clang_system     = "#{node['emscripten']['clang']['system']}"
clang_url_prefix = "#{node['emscripten']['clang']['url_prefix']}"
clang_name       = "clang+llvm-#{clang_version}-#{clang_arch}-#{clang_system}"
clang_tar        = "#{clang_name}.tar.gz"
clang_url        = "#{clang_url_prefix}/#{clang_version}/#{clang_tar}"

# make sure a JRE is installed
package "#{node['emscripten']['jre']}"

# setup the .emscripten file
template "#{home}/.emscripten" do
    source "emscripten.erb"
    owner "#{user}"
    group "#{group}"
    mode "0644"
end

# make sure the sdk root directory exists
directory "#{rootpath}" do
    owner "root"
    group "root"
    mode "0755"
    action :create
end

# get clang binary tarball (FIXME: replace with official clang cookbook?)
ark "clang" do
    path "#{rootpath}"
    version "#{clang_version}"
    url "#{clang_url}"
    action :put
    owner "root"
    group "root"
end

# clone emscripten
git "#{rootpath}/emscripten" do 
    repository "#{repo}"
    revision "#{branch}"
    user "root"
    group "root"
    action :sync
end

# actually switch to the right branch (the git resource will setup some branch "deploy")
bash "checkout" do
    cwd "#{rootpath}/emscripten"
    code "git checkout #{branch}"
    user "root"
    group "root"
end

# set a persistent EMSCRIPTEN variable to point to the emscripten directory
file "/etc/profile.d/emscripten-sdk.sh" do
    owner "root"
    group "root"
    mode "0644"
    content <<-EOH
    export EMSCRIPTEN=#{rootpath}/emscripten
    export PATH=$PATH:#{rootpath}/emscripten
    EOH
end







