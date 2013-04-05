dmg_package "Evernote" do
  volumes_dir "Evernote"
  source "http://evernote.com/download/get.php?file=EvernoteMac"
  checksum "5639b8f5f6b5202a1d7e6cffd8ca2a4c11fd0c41f339466272aa7672abb8fd47"
  accept_eula true
  action :install
  owner WS_USER
end
