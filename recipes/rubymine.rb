include_recipe "pivotal_workstation::java"

dmg_package "RubyMine" do
  source "http://download.jetbrains.com/ruby/RubyMine-4.5.4.dmg"
  checksum "1983d4417c6b2817bd6534f8804c2366fbd074a17dbc5a98cd85161abe255714"
  action :install
  owner WS_USER
end
