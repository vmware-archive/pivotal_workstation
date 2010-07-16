include_recipe "pivotal_workstation::bash_profile"

run_unless_marker_file_exists("bash_profile_no_sudo_gem_install") do
  template "#{BASH_INCLUDES_SUBDIR}/no_sudo_gem_install" do
    source "bash_profile_no_sudo_gem_install.erb"
    owner WS_USER
    backup false
  end
end