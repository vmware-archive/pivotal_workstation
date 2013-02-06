dmg_package "Dropbox" do
  volumes_dir "Dropbox Installer"
  source node["dropbox"]["source"]
  checksum node["dropbox"]["checksum"]
  action :install
  owner WS_USER
  destination node["dropbox"]["destination"]
end
