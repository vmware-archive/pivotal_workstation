intellij_version = "12.1"
dmg_package "IntelliJ IDEA 12 CE" do
  source "http://download.jetbrains.com/idea/ideaIC-#{intellij_version}.dmg"
  checksum "94fe8fdb1af0340f9650d1f0bcad571b41e04a719ca345c477124654dd701379"
  owner WS_USER
  action :install
end
