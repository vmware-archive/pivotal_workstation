file "/etc/gemrc" do
  owner "root"
  group "wheel"
  mode "0644"
  action :create
  content "install: --no-rdoc --no-ri\nupdate: --no-rdoc --no-ri\n"
end

unless File.exists?("#{WS_HOME}/.gemrc")
  execute "link .gemrc to /etc/gemrc" do
    command "ln -s /etc/gemrc #{WS_HOME}/.gemrc"
    user WS_USER
  end
end
