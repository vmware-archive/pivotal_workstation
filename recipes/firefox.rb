Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

dmg_package "Firefox" do
  source "http://download.mozilla.org/?product=firefox-20.0&os=osx&lang=en-US"
  checksum "4848df9d4ce810bea0fc27ed4766bbfffe6afac184c601b07931da86b028720c"
  action :install
  owner WS_USER
end
