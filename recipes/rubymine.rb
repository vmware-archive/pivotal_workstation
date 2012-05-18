include_recipe "pivotal_workstation::java"

rubymine_version  = "#{node['rubymine']['major']}.#{node['rubymine']['minor']}.#{node['rubymine']['micro']}"

pivotal_workstation_package "RubyMine" do
  source "http://download.jetbrains.com/ruby/RubyMine-#{rubymine_version}.dmg"
  action :install
  checksum "1e5974b07e2cf20ac6156cdb8c1439b2dfde1926233f390f18def01b1d144d4f"
end
