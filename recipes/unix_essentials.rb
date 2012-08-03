include_recipe "pivotal_workstation::homebrew"
include_recipe "pivotal_workstation::ack"
include_recipe "pivotal_workstation::tmux"
if node["kernel"]["release"] == "12.0.0"
  include_recipe "pivotal_workstation::xquartz"
end

brew_install "watch"
brew_install "ssh-copy-id"
brew_install "pstree"
brew_install "tree"
brew_install "wget"
