brew_install "node"

node_version = "1.1.0-2"

npm_git_location = "#{Chef::Config[:file_cache_path]}/npm"

directory npm_git_location do
  owner WS_USER
  action :create
  recursive true
end

git npm_git_location do
  repository "https://github.com/isaacs/npm.git"
  revision "v#{node_version}"
  action :sync
  user WS_USER
end

execute "compile npm" do
  command "cd #{npm_git_location} && make install"
  user WS_USER
  not_if "npm -v | grep #{node_version}"
end
