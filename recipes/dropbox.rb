dmg_package "Dropbox" do
  volumes_dir "Dropbox Installer"
  source "https://www.dropbox.com/download?plat=mac"
  checksum "d74666cdb67ac7c82aedfaf8654bfc77c65fc9596d2a346ab08ec5c5cb4f735a"
  action :install
  owner WS_USER
end
