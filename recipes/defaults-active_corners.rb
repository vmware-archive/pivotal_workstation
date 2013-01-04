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
  :tr => :dashboard,
  :br => :noop,
  :bl => :noop
}

corners.each do |corner, value|
  pivotal_workstation_defaults "Active Corner: #{corner} right #{value}" do
    domain 'com.apple.dock'
    key "wvous-#{corner}-corner"
    integer active_corner_value_to_int[value]
  end

  pivotal_workstation_defaults "Active Corner: #{corner} modifier" do
    domain 'com.apple.dock'
    key "wvous-#{corner}-modifier"
    integer 0
  end
end

execute "relaunch dock" do
  command "killall Dock"
end
