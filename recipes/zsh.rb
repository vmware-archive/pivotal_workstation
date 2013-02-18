if node["platform"] != "mac_os_x"
  package "zsh"
else
  brew_install "zsh"
end

