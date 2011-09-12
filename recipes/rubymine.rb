include_recipe "pivotal_workstation::java"

rubymine_version="3.2.4"
pivotal_workstation_package "Rubymine #{rubymine_version}" do
  source "http://download.jetbrains.com/ruby/RubyMine-#{rubymine_version}.dmg"
  action :install
  checksum "5b670894397ae5dcb692bb2b2a7e3b01cedf2e50978879ea4fe1efaa348cbb9c"
end
