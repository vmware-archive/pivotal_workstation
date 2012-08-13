# Acknowledgements: Some configuration source from
# https://github.com/Casecommons/casecommons_workstation

include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::ack"
include_recipe "pivotal_workstation::git"
include_recipe "pivotal_workstation::rvm"
include_recipe "pivotal_workstation::tmux"

brew_install "mercurial"

unless ( File.exists?("/usr/local/bin/vim") and File.exists?("/Applications/MacVim.app") )
  execute "uninstall-vim" do
    command "brew uninstall vim"
    only_if "brew list | grep '^vim$'"
  end

  execute "install-vim" do
    user WS_USER
    command "brew install https://raw.github.com/Homebrew/homebrew-dupes/c93e84ace76c58ae2386c439040110b57e510f04/vim.rb"
  end

  execute "brew-uninstall-macvim" do
    command "brew uninstall macvim"
    only_if "brew list | grep '^macvim$'"
  end

  execute "delete-macvim-application-link" do
    command "rm -rf /Applications/MacVim.app"
  end

  execute "brew install macvim with system ruby" do
    user WS_USER
    command "rvm use system; brew install macvim"
    not_if "brew list | grep '^macvim$'"
  end

  # There may be multiple macvims; try to find the latest one
  # & link that to /Applications
  ruby_block "Link MacVim to /Applications" do
    block do
      macvim_app=Dir["/usr/local/Cellar/macvim/*/MacVim.app"].last
      raise "no macvim found" unless macvim_app
      if File.exists?(macvim_app)
        system("ln -fs #{macvim_app} /Applications/")
      end
    end
  end

  ruby_block "test to see if MacVim link worked" do
    block do
      raise "/Applications/MacVim install failed" unless File.exists?("/Applications/MacVim.app")
    end
  end

  vim_dir = "#{WS_HOME}/.vim"

  execute "remove pre existing config" do
    command "rm -rf #{vim_dir}"
  end

  git node["vim_home"] do
    repository node["vim_config_git"]
    branch "master"
    revision node["vim_hash"] || "HEAD"
    action :sync
    user WS_USER
    enable_submodules true
  end

  execute "verify-checkout-happened" do
    command "test -e #{vim_dir}"
  end

  %w{vimrc gvimrc}.each do |vimrc|
    link "#{WS_HOME}/.#{vimrc}" do
      to "#{node["vim_home"]}/#{vimrc}"
      owner WS_USER
    end
  end

  execute "compile command-t" do
    only_if "test -d #{vim_dir}/bundle/command-t/ruby/command-t"
    cwd "#{node["vim_home"]}/bundle/command-t/ruby/command-t"
    command "rvm use system; ruby extconf.rb && make clean && make"
    user WS_USER
  end

  execute "verify-that-command-t-is-correctly-compiled-for-vim" do
    command %{test "`otool -l #{node["vim_home"]}/bundle/command-t/ruby/command-t/ext.bundle | grep libruby`" = "`otool -l /usr/local/bin/vim | grep libruby`"}
  end

  execute "verify-that-command-t-is-correctly-compiled-for-mvim" do
    command %{test "`otool -l #{node["vim_home"]}/bundle/command-t/ruby/command-t/ext.bundle | grep libruby`" = "`otool -l /Applications/MacVim.app/Contents/MacOS/Vim | grep libruby`"}
  end

  file "/Users/#{WS_USER}/.vimrc.local" do
    action :touch
    owner WS_USER
  end
end

pivotal_workstation_bash_profile_include "vi_is_minimal_vim"
pivotal_workstation_bash_profile_include "vim_tmux"
