Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

dmg_package "Viscosity" do
  source "http://www.sparklabs.com/downloads/Viscosity.dmg"
  action :install
  owner WS_USER
end
