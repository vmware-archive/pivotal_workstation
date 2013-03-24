# Acknowledgements: Some configuration source from
# https://github.com/Casecommons/casecommons_workstation

include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::ack"
include_recipe "pivotal_workstation::git"
include_recipe "pivotal_workstation::tmux"

execute "install macvim and use its vim as system vim" do
  command "brew install macvim --override-system-vim"
  user WS_USER
  not_if "brew list | grep '^macvim$'"
end

execute "link macvim into place" do
  # Not using `brew linkapps` because that links to ~/Applications, not
  # /Applications.  If you decide linkapps is better, be sure to modify the
  # "verify that command-t is correctly compiled" task.
  command "ln -s /usr/local/Cellar/macvim/*/MacVim.app /Applications/MacVim.app"
  user WS_USER
  not_if { File.symlink?("/Applications/MacVim.app") }
end

execute "test to see if macvim link worked" do
  command "test -L /Applications/MacVim.app"
end

ruby_block "ensure pivotal_workstation can manage #{node["vim_home"]}" do
  missing = "test ! -d #{node["vim_home"]}"
  present = "cd #{node["vim_home"]}"
  owned_by_pw = "test -d .git && (git remote -v show | grep -q #{node["vim_config_git"]})"
  not_if "#{missing} || (#{present} && #{owned_by_pw})"
  block { raise "Rename or delete #{node["vim_home"]} if you want to use this recipe" }
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
    not_if { File.symlink?("#{node["vim_home"]}/#{vimrc}") }
  end
end

execute "compile command-t" do
  # This matches the ruby that homebrew currently uses to `brew install macvim`
  # See --with-ruby-command in https://github.com/mxcl/homebrew/blob/master/Library/Formula/macvim.rb
  command "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby extconf.rb && make clean && make"
  cwd "#{node["vim_home"]}/bundle/command-t/ruby/command-t"
  user WS_USER
  only_if "test -d #{node["vim_home"]}/bundle/command-t/ruby/command-t"
end

execute "verify that command-t is correctly compiled for macvim" do
  command <<-SH
    findlibruby () { otool -l $1 | grep libruby; }
    CMDT_RUBY=`findlibruby #{node["vim_home"]}/bundle/command-t/ruby/command-t/ext.bundle`
    MACVIM_RUBY=`findlibruby /Applications/MacVim.app/Contents/MacOS/Vim`
    test -n "$MACVIM_RUBY" -a "$MACVIM_RUBY" = "$CMDT_RUBY"
  SH
end

file "#{WS_HOME}/.vimrc.local" do
  action :touch
  owner WS_USER
  not_if { File.exists?("#{WS_HOME}/.vimrc.local") }
end

pivotal_workstation_bash_it_custom_plugin "vim-alias_vi_to_minimal_vim.bash"
pivotal_workstation_bash_it_custom_plugin "vim-source_tmux_config.bash"
