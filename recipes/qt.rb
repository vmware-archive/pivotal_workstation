include_recipe "pivotal_workstation::homebrew"

run_unless_marker_file_exists("qt") do
  brew_install "qt"
end
