if node["platform"] == "ubuntu"
    package "siege"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "siege"
end
