Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

pivotal_workstation_defaults "Disable natural scrolling" do
  domain "/Users/#{WS_USER}/Library/Preferences/.GlobalPreferences"
  key "com.apple.swipescrolldirection"
  boolean false
end
