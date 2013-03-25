include_recipe "pivotal_workstation::addloginitem"

app_path="/Applications/KeyCastr.app"

unless File.exists?(app_path)
  dmg_package "KeyCastr" do
    dmg_name "KeyCastr"
    source "http://cheffiles.pivotallabs.com/keycastr_0.8.0.dmg"
    checksum "ecf59a2e46a8ca450c12f426a4d41000de1c3010a5c46fe12f23fdc647f3f1e7"
    owner WS_USER
    action :install
  end

  # start up on login
  execute "Start KeyCastr #{app_path} on login" do
    command "su #{WS_USER} -c \"addloginitem #{app_path}\""
  end
end
