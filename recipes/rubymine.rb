include_recipe "pivotal_workstation::java"

dmg_package "RubyMine" do
  source "http://download.jetbrains.com/ruby/RubyMine-5.0.2.dmg"
  checksum "4c186bbd54e976d2a83595bcc77a57304159ba7e40d6fe2e5690cb074b4c65ae"
  action :install
  owner WS_USER
end
