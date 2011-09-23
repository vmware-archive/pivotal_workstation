brew_install "node"

node_version = "1.0.30"

directory Chef::Config[:file_cache_path] do
  owner "root"
  group "admin"
  mode 0775
  action :create
  recursive true
  not_if { ::File.exists?(Chef::Config[:file_cache_path]) }
end

npm_git_location = "#{Chef::Config[:file_cache_path]}/npm"

git npm_git_location do
  repository "https://github.com/isaacs/npm.git"
  revision "v#{node_version}"
  action :sync
  user WS_USER
end

execute "compile rvm" do
  command "cd #{npm_git_location} && make clean && make install"
  user WS_USER
  not_if "npm -v | grep #{node_version}"
end