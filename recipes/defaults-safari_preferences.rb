pivotal_workstation_defaults "set safari to show status bar" do
  domain 'com.apple.safari'
  key 'ShowStatusBar'
  boolean true
end

pivotal_workstation_defaults "delete to navigate back" do
  domain 'com.apple.safari'
  key 'com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled'
  boolean true
end
