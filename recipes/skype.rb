Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

dmg_package "Skype" do
  source "http://download.skype.com/macosx/Skype_6.0.0.2968.dmg"
  checksum "7f53dd799b7b99c70f6b62fde0cb74c4"
  owner WS_USER
  action :install
end
