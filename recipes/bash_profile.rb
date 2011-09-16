::BASH_INCLUDES_DIRNAME = ".bash_profile_includes"
::BASH_INCLUDES_SUBDIR = File.expand_path("#{WS_HOME}/#{BASH_INCLUDES_DIRNAME}")

directory BASH_INCLUDES_SUBDIR do
  owner WS_USER
end

template "#{WS_HOME}/.bash_profile" do
  source "bash_profile.erb"
  owner WS_USER
end