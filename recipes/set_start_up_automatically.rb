start_after_restore="true"
plist_key=":Custom\\ Profile:AC\\ Power:Automatic\\ Restart\\ On\\ Power\\ Loss"
plist_file="/Library/Preferences/SystemConfiguration/com.apple.PowerManagement.plist"

# We must delete & re-create the key to accommodate Apple 10.8.2 weirdness:
# On an un-configured system, the key "Automatic Restart on Power Loss"
# is type int.  But once it has been configured (via System Preferences)
# it becomes type bool.  PlistBuddy won't let us change key of type int
# to a key of type bool, but it will allow us to delete and int key & create
# a bool key, which is what we do.
execute "Delete #{plist_key} from #{plist_file}" do
  command "/usr/libexec/PlistBuddy -c 'Delete #{plist_key} ' #{plist_file}"
  ignore_failure true
end

execute "Add #{plist_key} to #{plist_file}" do
  command "/usr/libexec/PlistBuddy -c 'Add #{plist_key} bool #{start_after_restore}' #{plist_file}"
end

execute "Restart powerd" do
  command "killall powerd"
end
