# May not work if System Preferences is open while this is running
file "/private/var/db/.AccessibilityAPIEnabled" do
  action :create_if_missing
  content "a"
  mode "0444"
end

log_msg="'Enable Assistive Devices' has been turned on. This makes your system less secure
(especially with regards to keylogging). To disable, do the following:
System Preferences -> Accessibility -> (uncheck) Enable Assistive Devices"
log(log_msg) { level :warn }
