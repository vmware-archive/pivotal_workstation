pivotal_workstation_package Skype do
  source "http://download.skype.com/macosx/Skype_5.8.0.1027.dmg"
  checksum "64ec1beaca76f648e7a5ba3bb1084afab735cbe6d6b17f9e2f52e22e14fcc596"
  user WS_USER
  action :install
end
