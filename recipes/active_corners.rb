active_corner_value_to_int = {
  desktop:               4,
  dashboard:             7,
  mission_control:       2,
  application_windows:   3,
  launchpad:            11,
  start_screen_saver:    5,
  disable_screen_saver:  6,
  put_display_to_sleep: 10,
  noop:                  0
}

corners = {
  :tl => :all_windows,
  :tr => :dashboard
  :br => :noop,
  :bl => :noop 
}

corners.each do |corner, value|
  execute "#{corner} right #{value}" do
    command "defaults write com.apple.dock wvous-#{corner}-corner -int #{active_corner_value_to_int[value]}"
    user WS_USER
  end
  execute "#{corner} modifier" do
    command "defaults write com.apple.dock wvous-#{corner}-modifier -int 0"
    user WS_USER
  end
end

execute "relaunch dock" do
  command "killall Dock"
end