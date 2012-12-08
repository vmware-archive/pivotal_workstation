intellij_version = "10.5.2"
dmg_package "IntelliJ IDEA 10" do
  source "http://download.jetbrains.com/idea/ideaIU-#{intellij_version}.dmg"
  checksum "667c7227cccc011666492150320601fb7517ed9e9f3b935dcee1cc337bdadae9"
  owner WS_USER
  action :install
end
