# unattended install doesn't usually work; expects your account name in /tmp/samanage
# http://support.samanage.com/entries/262691-deploy-on-mac-osx
dmg_package "SAManage-MAC-Agent" do
  source "http://cdn.samanage.com/download/Mac+Agent/SAManage-Agent-for-Mac.dmg"
  checksum "db13716a646903a753b0c50d0589f6514a6b7bcfd2b94793ed340a1967053ff9"
  action :install
  type "pkg"
  package_id "www.samanage.com.samanagemacagent.samanage-agent.pkg"
end
