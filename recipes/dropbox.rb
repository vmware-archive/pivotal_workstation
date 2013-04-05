dmg_package "Dropbox" do
  volumes_dir "Dropbox Installer"
  source "https://www.dropbox.com/download?plat=mac"
  checksum "1169d604ed3db8b15449753f7cf9c5af2b86afefcf598231d44dc29551c4a489"
  action :install
  owner WS_USER
end
