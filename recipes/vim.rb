include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::ack"
include_recipe "pivotal_workstation::git"
include_recipe "pivotal_workstation::rvm"

execute "brew install macvim with system ruby" do
  user WS_USER
  command "test -e #{WS_HOME}/.rvm/bin/rvm && (rvm use system); brew install macvim"
  not_if "brew list | grep '^macvim$'"
end

# There may be multiple macvims; try to find the latest one
# & link that to /Applications
ruby_block "Link MacVim to /Applications" do
  block do
    macvim_app=Dir["/usr/local/Cellar/macvim/*/MacVim.app"].last
    raise "no macvim found" unless macvim_app
    if File.exists?(macvim_app)
      system("ln -s #{macvim_app} /Applications/")
    end
  end
end

git node["vim_home"] do
  repository node["vim_config_git"]
  branch "master"
  revision node["vim_hash"] || "HEAD"
  action :sync
  user WS_USER
  enable_submodules true
end

%w{vimrc gvimrc}.each do |vimrc|
  link "#{WS_HOME}/.#{vimrc}" do
    to "#{node["vim_home"]}/#{vimrc}"
    owner WS_USER
  end
end

brew_install "ctags"

execute "compile command-t" do
  not_if "test -f #{node["vim_home"]}/bundle/command-t/ruby/command-t/compiled"
  cwd "#{node["vim_home"]}/bundle/command-t/ruby/command-t"
  command "test -e #{WS_HOME}/.rvm/bin/rvm && (rvm use system); ruby extconf.rb && make && touch compiled"
  user WS_USER
end

ruby_block "test to see if MacVim link worked" do
  block do
    raise "/Applications/MacVim install failed" unless File.exists?("/Applications/MacVim.app")
  end
end

pivotal_workstation_bash_profile_include "vi_is_minimal_vim"
