pivotal_workstation_defaults "Turn on Input menu in login screen (dvorak vs qwerty)" do
  domain '/Library/Preferences/com.apple.loginwindow'
  key 'showInputMenu'
  boolean true
end
