if node["platform"] != "mac_os_x"
  package "git"
else
  brew "git"
end