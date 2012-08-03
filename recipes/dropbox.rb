pivotal_workstation_package "Dropbox" do
  volumes_dir "Dropbox Installer"
  source "http://dl-web.dropbox.com/u/17/b/Dropbox%201.4.12.dmg"
  checksum "367f18673cc27ab9266d70765e5c33f9cfd59f91028d18bd1188de52c9422cf3"
  action :install
end
