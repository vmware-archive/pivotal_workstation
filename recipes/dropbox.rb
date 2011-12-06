pivotal_workstation_package "Dropbox" do
  volumes_dir "Dropbox Installer"
  source "http://www.dropbox.com/download?plat=mac"
  checksum "859b1cc1c4da488a8a367efa04992a8f8974528614e9ccfd54a4f40c68ba6d43"
  action :install
end
