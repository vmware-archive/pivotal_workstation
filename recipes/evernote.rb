dmg_package "Evernote" do
  volumes_dir "Evernote"
  source "http://evernote.com/download/get.php?file=EvernoteMac"
  checksum "b3d68576332812e7fa7c3475bbee4674567eb4e3cca6a40ca19d44094c043b35"
  accept_eula true
  action :install
  owner WS_USER
end
