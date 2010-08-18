::BASH_INCLUDES_DIRNAME = ".bash_profile_includes"
::BASH_INCLUDES_SUBDIR = File.expand_path("#{WS_HOME}/.bash_profile_includes")

directory BASH_INCLUDES_SUBDIR do
  owner WS_USER
end

template "#{WS_HOME}/.bash_profile" do
  owner WS_USER
  source "bash_profile.erb"
end