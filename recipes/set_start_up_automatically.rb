start_after_restore="true"

execute "Start up automatically after a power failure" do
  command "/usr/libexec/PlistBuddy -c 'Set :Custom\\ Profile:AC\\ Power:Automatic\\ Restart\\ On\\ Power\\ Loss #{start_after_restore}' /Library/Preferences/SystemConfiguration/com.apple.PowerManagement.plist"
end

execute "Restart powerd" do
  command "killall powerd"
end
