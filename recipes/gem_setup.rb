pivotal_workstation_bash_it_custom_plugin "gem_setup-warn_on_sudo.bash"

file "/etc/gemrc" do
  owner "root"
  group "wheel"
  mode "0644"
  action :create
  content "install: --no-rdoc --no-ri\nupdate: --no-rdoc --no-ri\n"
end

link "#{WS_HOME}/.gemrc" do
  to "/etc/gemrc"
  owner WS_USER
end
