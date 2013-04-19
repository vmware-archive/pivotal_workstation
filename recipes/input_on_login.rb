Chef::Log.warn 'Please use https://github.com/pivotal-sprout/sprout instead'

execute "defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -boolean true"
