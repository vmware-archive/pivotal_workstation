node.default["libreoffice"]["source"] = "http://download.documentfoundation.org/libreoffice/stable/3.6.0/mac/x86/LibO_3.6.0_MacOS_x86_install_en-US.dmg"
node.default["libreoffice"]["checksum"] = "bba8ab6e100aa77489f8d601c592d8e243687947b2b9418f12aa7eb6106fbbbb"

pivotal_workstation_package "LibreOffice" do
  volumes_dir "LibreOffice"
  source node["libreoffice"]["source"]
  checksum node["libreoffice"]["checksum"]
  action :install
end
