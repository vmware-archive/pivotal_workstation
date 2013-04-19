Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

pivotal_workstation_defaults "turn on focus-follows-mouse for terminal" do
  domain 'com.apple.Terminal'
  key 'FocusFollowsMouse'
  string 'yes'
end
