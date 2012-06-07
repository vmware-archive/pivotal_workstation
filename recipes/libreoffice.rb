node.default["libreoffice"]["source"] = "http://download.documentfoundation.org/libreoffice/stable/3.5.4/mac/x86/LibO_3.5.4_MacOS_x86_install_en-US.dmg"
node.default["libreoffice"]["checksum"] = "b4302f30f6aafe384f13673aaba05ff85c1b4617f997c22e1079df48c6172fee"

pivotal_workstation_package "LibreOffice" do
  volumes_dir "LibreOffice"
  source node["libreoffice"]["source"]
  checksum node["libreoffice"]["checksum"]
  action :install
end
