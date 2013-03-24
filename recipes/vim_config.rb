# Acknowledgements: Some configuration source from
# https://github.com/Casecommons/casecommons_workstation

include_recipe "pivotal_workstation::vim"
include_recipe "pivotal_workstation::ack"
include_recipe "pivotal_workstation::git"
include_recipe "pivotal_workstation::tmux"

ruby_block "ensure pivotal_workstation can manage #{node["vim_home"]}" do
  block do
    missing = "test ! -d #{node["vim_home"]}"
    present = "cd #{node["vim_home"]}"
    owned_by_pw = "test -d .git && (git remote -v show | grep -q #{node["vim_config_git"]})"

    unless system("#{missing} || (#{present} && #{owned_by_pw})")
      raise "Rename or delete #{node["vim_home"]} if you want to use this recipe"
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
    not_if { File.symlink?("#{node["vim_home"]}/#{vimrc}") }
  end
end

cmdt_dir = "#{node["vim_home"]}/bundle/command-t/ruby/command-t"

execute "compile command-t" do
  # This matches the ruby that homebrew currently uses to `brew install macvim`
  # See --with-ruby-command in https://github.com/mxcl/homebrew/blob/master/Library/Formula/macvim.rb
  command "/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby extconf.rb && make clean && make"
  cwd cmdt_dir
  user WS_USER
  only_if "test -d #{cmdt_dir}"
end

execute "verify that command-t is correctly compiled for macvim" do
  command <<-SH
    findlibruby () { otool -l $1 | grep libruby; }
    CMDT_RUBY=`findlibruby #{cmdt_dir}/ext.bundle`
    MACVIM_RUBY=`findlibruby /Applications/MacVim.app/Contents/MacOS/Vim`
    test -n "$MACVIM_RUBY" -a "$MACVIM_RUBY" = "$CMDT_RUBY"
  SH
  only_if "test -d #{cmdt_dir}"
end

file "#{WS_HOME}/.vimrc.local" do
  action :touch
  owner WS_USER
  not_if { File.exists?("#{WS_HOME}/.vimrc.local") }
end

pivotal_workstation_bash_it_custom_plugin "vim-source_tmux_config.bash"
