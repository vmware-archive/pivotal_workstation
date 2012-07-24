pivotal_workstation_defaults "ask for password when screen is locked" do
  domain 'com.apple.screensaver'
  key 'askForPassword'
  integer 1
end

pivotal_workstation_defaults "wait 60 seconds between screensaver & lock" do
  domain 'com.apple.screensaver'
  key 'askForPasswordDelay'
  float 60
end

plist_dir = ENV['HOME'] + "/Library/Preferences/ByHost"
Dir["#{plist_dir}/com.apple.screensaver.*.plist"].each do |file|
  pivotal_workstation_defaults "set screensaver timeout" do
    domain file.chomp('plist')
    key 'idleTime'
    integer 600
  end
end

execute "set display, disk and computer sleep times" do
  command "pmset -a displaysleep 20 disksleep 15 sleep 0"
end
