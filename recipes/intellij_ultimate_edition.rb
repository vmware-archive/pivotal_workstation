intellij_version = "10.5.2"
pivotal_workstation_package "IntelliJ IDEA 10" do
  source "http://download.jetbrains.com/idea/ideaIU-#{intellij_version}.dmg"
  action :install
  checksum "667c7227cccc011666492150320601fb7517ed9e9f3b935dcee1cc337bdadae9"
end
