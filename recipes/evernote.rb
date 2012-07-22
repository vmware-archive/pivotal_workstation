pivotal_workstation_package "Evernote" do
  volumes_dir "Evernote"
  source "http://evernote.com/download/get.php?file=EvernoteMac"
  checksum "2af4e1169b384c52ce23d22f284d48d50621d3c8"
  accept_eula true
  action :install
end
