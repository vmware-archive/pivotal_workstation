execute "Enable Assistive Devices" do
  command "echo 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled"
  user WS_USER
end

log_msg="'Enable Assistive Devices' has been turned on.\nThis makes your system less secure.  To disable,\nSystem Preferences -> Accessibility -> (uncheck) Enable Assistive Devices"
log(log_msg) { level :warn }
