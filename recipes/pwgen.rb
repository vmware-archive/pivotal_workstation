if node["platform"] == "ubuntu"
    package "pwgen"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "pwgen"
end
