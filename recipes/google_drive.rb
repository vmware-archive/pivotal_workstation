dmg_package "Google Drive" do
  volumes_dir "Install Google Drive"
  source "http://dl.google.com/drive/installgoogledrive.dmg"
  checksum "7ab1add46f9617ec79ba291abd8f7bce4e22c172f660690b1d05457eb62a4445"
  owner WS_USER
  action :install
end
