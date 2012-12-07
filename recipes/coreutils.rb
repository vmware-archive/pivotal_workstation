if node["platform"] == "ubuntu"
    package "coreutils"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "coreutils"
end
