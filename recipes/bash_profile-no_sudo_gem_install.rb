include_recipe "pivotal_workstation::bash_profile"

run_unless_marker_file_exists("bash_profile-no_sudo_gem_install") do
  bash_profile_include("no_sudo_gem_install")
end