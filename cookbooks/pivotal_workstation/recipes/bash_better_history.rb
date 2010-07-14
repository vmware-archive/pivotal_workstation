include_recipe "pivotal_workstation::bash_profile"

run_unless_marker_file_exists("bash_better_history") do
  template "#{BASH_INCLUDES_SUBDIR}/better_bash_history" do
    source "bash_profile_better_bash_history.erb"
    owner WS_USER
  end
end