Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

dmg_package "Sequel Pro" do
  volumes_dir "Sequel Pro 1.0"
  owner WS_USER
  source "http://sequel-pro.googlecode.com/files/sequel-pro-1.0-RC1.dmg"
  checksum "1cf4824897782239c0283d8cacd838121b94abd1f4e0ac386ca5839ed32b81b9"
  action :install
end
