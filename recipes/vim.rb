::VIM_HOME = "#{WS_HOME}/.vim"
include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::ack"
include_recipe "pivotal_workstation::git"

brew_install "macvim"

execute "clone the .vim directory" do
  user WS_USER
  command "git clone https://github.com/pivotal/vim-config.git #{VIM_HOME}"
  not_if "cd #{VIM_HOME} && git remote -v | grep pivotal/vim-config"
end

execute "ensure we're on the approved hash" do
  user WS_USER
  command "cd #{VIM_HOME} && git checkout 960967514858e889dfc1"
end

execute "get the submodules" do
  user WS_USER
  command "cd #{VIM_HOME} && git submodule update --init"
end

link "#{WS_HOME}/.vimrc" do
  to "#{VIM_HOME}/vimrc"
  owner WS_USER
end

brew_install "ctags"

execute "compile command-t" do
  cwd "#{VIM_HOME}/bundle/command-t/ruby/command-t"
  command "ruby extconf.rb && make"
  user WS_USER
end
