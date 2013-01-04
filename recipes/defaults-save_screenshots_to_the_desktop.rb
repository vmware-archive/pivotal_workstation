pivotal_workstation_defaults "Save screenshots to the desktop" do
  domain 'com.apple.screencapture'
  key 'location'
  string "#{WS_HOME}/Desktop"
end
