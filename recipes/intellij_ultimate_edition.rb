intellij_version = "12.1"
dmg_package "IntelliJ IDEA 12" do
  source "http://download.jetbrains.com/idea/ideaIU-#{intellij_version}.dmg"
  checksum "31c9e860d42854df22a520bfc9c1e18d54df80fd3817298428df8b9b4ccdefca"
  owner WS_USER
  action :install
end
