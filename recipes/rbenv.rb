include_recipe "pivotal_workstation::bash_profile"
include_recipe "pivotal_workstation::git"

::RBENV_HOME = "#{WS_HOME}/.rbenv"
::RBENV_COMMAND = "/usr/local/bin/rbenv"


brew_install("rbenv")
brew_install("ruby-build")

bash_profile_include("rbenv")

node["rbenv"]["rubies"].each do |ruby_version_string, env_override|
  rbenv_ruby_install(ruby_version_string,env_override)
end

if node["rbenv"]["default_ruby"]
  execute "making #{node["rbenv"]["default_ruby"]} with rbenv the default" do
    command "rbenv global #{node["rbenv"]["default_ruby"]}"
    user WS_USER
  end
end
