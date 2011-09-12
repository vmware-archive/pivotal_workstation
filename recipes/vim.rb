include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::ack"
include_recipe "pivotal_workstation::git"

brew_install "macvim"

#link "/Applications/MacVim.app" do
#  to "#{node["vim_app"]}"
#  owner WS_USER
#end

# There may be multiple macvims; try to find the latest one
# & link that to /Applications
ruby_block "Link MacVim to /Applications" do
  block do
    macvim_app=Dir["/usr/local/Cellar/macvim/*/MacVim.app"].last
    if File.exists?(macvim_app)
      system("ln -s #{macvim_app} /Applications/")
    end
  end
end

execute "move existing vim_home out of the way if necessary" do
  user WS_USER
  command "mv #{node["vim_home"]} #{WS_HOME}/.vim-old"
  only_if {
    File.exists?(node["vim_home"]) && !system("cd #{node["vim_home"]} && git remote -v | grep pivotal/vim-config")
  }
end

execute "clone the .vim directory" do
  user WS_USER
  command "git clone https://github.com/pivotal/vim-config.git #{node["vim_home"]}"
  not_if "cd #{node["vim_home"]} && git remote -v | grep pivotal/vim-config"
end

execute "ensure we're on the approved hash" do
  user WS_USER
  command "cd #{node["vim_home"]} && git checkout #{node["vim_hash"]}"
end

execute "get the submodules" do
  user WS_USER
  command "cd #{node["vim_home"]} && git submodule update --init"
end

link "#{WS_HOME}/.vimrc" do
  to "#{node["vim_home"]}/vimrc"
  owner WS_USER
end

brew_install "ctags"

execute "compile command-t" do
  cwd "#{node["vim_home"]}/bundle/command-t/ruby/command-t"
  command "ruby extconf.rb && make"
  user WS_USER
end

ruby_block "test to see if MacVim link worked" do
  block do
    raise "/Applications/MacVim install failed" unless File.exists?("/Applications/MacVim.app/Contents")
  end
end

bash_profile_include("vi_is_minimal_vim")
