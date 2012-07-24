# Requires logout to take effect

key_repeat_rate_lower_is_faster = 2

pivotal_workstation_defaults "set key repeat rate" do
  domain "/Users/#{WS_USER}/Library/Preferences/.GlobalPreferences"
  key "KeyRepeat"
  integer key_repeat_rate_lower_is_faster
end

initial_repeat_delay_lower_is_shorter = 15

pivotal_workstation_defaults "set key repeat rate" do
  domain "/Users/#{WS_USER}/Library/Preferences/.GlobalPreferences"
  key "InitialKeyRepeat"
  integer initial_repeat_delay_lower_is_shorter
end
