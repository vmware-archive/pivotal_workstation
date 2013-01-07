vlc_version = node["vlc_version"]
vlc_checksum = node["vlc_checksum"]

dmg_package "VLC" do
  dmg_name "vlc-#{vlc_version}"
  volumes_dir "vlc-#{vlc_version}"
  source "http://download.videolan.org/vlc/#{vlc_version}/macosx/vlc-#{vlc_version}.dmg"
  checksum vlc_checksum
  action :install
  owner WS_USER
end
