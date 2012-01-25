include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::ack"
include_recipe "pivotal_workstation::git"

# https://github.com/mxcl/homebrew/pull/8394
# default macvim doesn't compile yet with xcode 4.2
brew_install("macvim", :brew_args => "--HEAD")

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
    File.exists?(node["vim_home"]) && !system("cd #{node["vim_home"]} && git remote -v | grep pivotal/vim-config") && !File.exists?("#{WS_HOME}/.vim-old")
  }
end

git "#{node["vim_home"]}" do
  only_if { system("test ! -d #{node["vim_home"]}") }
  repository "git@github.com:casecommons/vim-config.git"
  branch "master"
  revision node["vim_hash"] || "HEAD"
  action :checkout
  user WS_USER
  enable_submodules true
end

git "#{node["vim_home"]}" do
  only_if {
    system("test ! -d #{node["vim_home"]} || cd #{node["vim_home"]} && git remote -v | grep pivotal/vim-config")
  }
  repository "git@github.com:casecommons/vim-config.git"
  branch "master"
  revision node["vim_hash"] || "HEAD"
  action :sync
  user WS_USER
  enable_submodules true
end

link "#{WS_HOME}/.vimrc" do
  to "#{node["vim_home"]}/vimrc"
  owner WS_USER
end

brew_install "ctags"

execute "compile command-t" do
  only_if "test -d #{node["vim_home"]}/bundle/command-t/ruby/command-t"
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
