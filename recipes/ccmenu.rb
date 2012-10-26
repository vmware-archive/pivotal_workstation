include_recipe "pivotal_workstation::addloginitem"

app_path="/Applications/CCMenu.app"

unless File.exists?(app_path)
  pivotal_workstation_package "CCMenu" do
    volumes_dir "CCMenu 1.3"
    source "http://surfnet.dl.sourceforge.net/project/ccmenu/CCMenu/1.3/ccmenu-1.3-b.dmg"
    checksum "9afef887022002b0f074eb7db25349da53aea5d5a64d8415b756c676db9ad1de"
    owner WS_USER
    action :install
  end

  execute "Start CCMenu on login" do
    command "su #{WS_USER} -c \"addloginitem #{app_path}\""
  end
end