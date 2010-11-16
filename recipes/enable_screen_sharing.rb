execute "Enabling Screen Sharing for All Users" do
  command "/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -restart -agent -privs -all"
end