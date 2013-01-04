pivotal_workstation_defaults "Disable the warning when changing a file extension" do
  domain 'com.apple.finder'
  key 'FXEnableExtensionChangeWarning'
  boolean false
end
