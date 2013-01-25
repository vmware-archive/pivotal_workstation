include_recipe "pivotal_workstation::homebrew"

if node["platform"] != "mac_os_x"
  package "git"
else
  brew_install "git"
end