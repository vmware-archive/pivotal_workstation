pivotal_workstation_package "Evernote" do
  volumes_dir "Evernote"
  source "http://evernote.com/download/get.php?file=EvernoteMac"
  checksum "20bf4ac0ed5e0e3c80806a60b72c986f9407ccedcd5b763c88a0440ac11db9b6"
  accept_eula true
  action :install
end
