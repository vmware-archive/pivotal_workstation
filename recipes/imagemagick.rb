include_recipe "pivotal_workstation::homebrew"

run_unless_marker_file_exists("imagemagick") do
  brew_install "imagemagick"
end


