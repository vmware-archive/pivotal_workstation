if node["platform"] == "ubuntu"
    package "bash"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "bash"
end
