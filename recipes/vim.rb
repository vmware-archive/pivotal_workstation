# Acknowledgements: Some configuration source from
# https://github.com/Casecommons/casecommons_workstation

include_recipe "pivotal_workstation::homebrew"

execute "install macvim and use its vim as system vim" do
  command "brew install macvim --override-system-vim"
  user WS_USER
  not_if "brew list | grep '^macvim$'"
end

execute "link macvim into place" do
  # Not using `brew linkapps` because that links to ~/Applications, not
  # /Applications.  If you decide linkapps is better, be sure to modify the
  # "verify that command-t is correctly compiled" task in the vim_config recipe.
  command "ln -s /usr/local/Cellar/macvim/*/MacVim.app /Applications/MacVim.app"
  user WS_USER
  not_if { File.symlink?("/Applications/MacVim.app") }
end

execute "test to see if macvim link worked" do
  command "test -L /Applications/MacVim.app"
end

pivotal_workstation_bash_it_custom_plugin "vim-alias_vi_to_minimal_vim.bash"
