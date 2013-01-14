dmg_package "Dropbox" do
  volumes_dir "Dropbox Installer"
  source "https://www.dropbox.com/download?plat=mac"
  checksum "e80f8974b1759f85f98c43c5ba8784f400ff9da507cf73077c2366c15bb04e33"
  action :install
  owner WS_USER
end
