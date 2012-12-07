if node["platform"] == "ubuntu"
    package "wget"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "wget"
end
