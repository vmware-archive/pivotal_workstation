if node["platform"] == "ubuntu"
    package "findutils"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "findutils"
end
