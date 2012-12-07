include_recipe "pivotal_workstation::bash4"
if node["platform"] == "ubuntu"
    package "bash-completion"
else
    include_recipe "pivotal_workstation::homebrew"
    brew_install "bash-completion"
end
