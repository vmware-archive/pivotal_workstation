Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

dmg_package "Google Chrome Canary" do
  dmg_name "GoogleChromeCanary"
  source "https://storage.googleapis.com/chrome-canary/GoogleChromeCanary.dmg"
  action :install
  owner WS_USER
end
