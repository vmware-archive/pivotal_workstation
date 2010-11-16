include_recipe "pivotal_workstation::bash_profile"

run_unless_marker_file_exists("bash_profile-better_history") do
  bash_profile_include("better_history")
end