Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

dmg_package "PhpStorm" do
  source "http://download.jetbrains.com/webide/PhpStorm-5.0.4.dmg"
  action :install
  owner WS_USER
end



