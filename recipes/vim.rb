::VIM_HOME = "#{WS_HOME}/.vim"
include_recipe "pivotal_workstation::ack"

brew_install "macvim"

remote_directory VIM_HOME do
  source "vim"
  owner WS_USER
end

link "#{WS_HOME}/.vimrc" do
  to "#{VIM_HOME}/vimrc"
end

execute "compile command-t" do
  cwd "#{VIM_HOME}/bundle/command-t/ruby/command-t"
  command "ruby extconf.rb && make"
  user WS_USER
end
