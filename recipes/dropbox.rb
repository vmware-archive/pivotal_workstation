pivotal_workstation_package "Dropbox" do
  volumes_dir "Dropbox Installer"
  source "http://www.dropbox.com/download?plat=mac"
  checksum "a721c6e7fa9ae0d07f220901764ac65190d9299c7a0b62cd8a6822a27365e275"
  action :install
end
