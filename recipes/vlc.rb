vlc_version = '2.0.5'

dmg_package "VLC" do
  dmg_name "vlc-#{vlc_version}"
  volumes_dir "vlc-#{vlc_version}"
  source "http://download.videolan.org/vlc/2.0.5/macosx/vlc-#{vlc_version}.dmg"
  checksum "64257a95902314248128e52b2d90e13e0475e57ad3661000ab2226c23a7395bf"
  action :install
  owner WS_USER
end
