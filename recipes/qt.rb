include_recipe "pivotal_workstation::homebrew"
if node["kernel"]["release"] == "12.0.0"
  include_recipe "pivotal_workstation::xquartz"
end

brew_install "qt"
