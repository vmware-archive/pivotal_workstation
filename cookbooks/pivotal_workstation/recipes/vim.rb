include_recipe "pivotal_workstation::ack"
include_recipe "pivotal_workstation::vim_install"

remote_directory VIM_HOME do
  source "vim"
end

link "~/.vimrc" do
  to "~/.vim/vimrc"
end

execute "compile command-t" do
  cwd "#{VIM_HOME}/bundle/command-t/ruby/command-t"
  command "ruby extconf.rb && make"
end