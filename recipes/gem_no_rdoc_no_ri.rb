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
