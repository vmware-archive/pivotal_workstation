::BASH_INCLUDES_DIRNAME = ".bash_profile_includes"
::BASH_INCLUDES_SUBDIR = ::File.expand_path("#{WS_HOME}/#{BASH_INCLUDES_DIRNAME}")

action :create do
  directory BASH_INCLUDES_SUBDIR do
    owner WS_USER
  end

  template "#{WS_HOME}/.bash_profile" do
    source "bash_profile.erb"
    cookbook 'pivotal_workstation'
    owner WS_USER
  end

  template "#{BASH_INCLUDES_SUBDIR}/#{new_resource.name}.sh" do
    source "bash_profile-#{new_resource.name}.sh.erb"
    owner WS_USER
    mode "0755"
  end
end