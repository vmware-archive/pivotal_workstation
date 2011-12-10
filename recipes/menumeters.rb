menu_meters_uri = "http://www.ragingmenace.com/software/download/MenuMeters.dmg"
menu_meters_dmg = Chef::Config[:file_cache_path] + "/MenuMeters.dmg"
menu_meters_mnt = "/Volumes/MenuMeters 1.5"
menu_meters_src = menu_meters_mnt + "/MenuMeters Installer.app/Contents/Resources/MenuMeters.prefPane"
menu_meters_destdir = ENV['HOME'] + "/Library/PreferencePanes/"
menu_meters_dst = menu_meters_destdir + "MenuMeters.prefPane"

unless File.exists?(menu_meters_dst)

  remote_file menu_meters_dmg do
    source menu_meters_uri
    mode "0644"
    action :create_if_missing
  end

  execute "mount MenuMeters dmg" do
    command "hdiutil attach #{menu_meters_dmg}"
    user WS_USER
  end

  # We're bypassing the installer.app because it requires user intervention.

  execute "Copy MenuMeters to ~/Library/PreferencePanes/" do
    command "cp -rf #{Regexp.escape(menu_meters_src)} #{Regexp.escape(menu_meters_destdir)}"
    user WS_USER
  end

  execute "unmount dmg" do
    command "hdiutil detach #{Regexp.escape(menu_meters_mnt)}"
    user WS_USER
  end

  execute "Turn on the meters" do
    command "defaults write com.apple.systemuiserver menuExtras -array-add \
      '~/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuMeterNet.menu' \
      '~/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuMeterDisk.menu' \
      '~/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuMeterCPU.menu' \
      '~/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuMeterMem.menu' \
      '~/Library/PreferencePanes/MenuMeters.prefPane/Contents/Resources/MenuCracker.menu' "
    user WS_USER
    # long path because this command runs as root, and we're in WS_USER's preferences, not root's
    not_if "defaults read ~#{WS_USER}/Library/Preferences/com.apple.systemuiserver menuExtras | grep 'MenuMeters.prefPane'"
  end

  # My preferences: more history graphs.  Delete this stanza if you want to go with the defaults.
  plist_path = File.expand_path('com.ragingmenace.MenuMeters.plist', File.join(WS_HOME, 'Library', 'Preferences'))
  template plist_path do
    source "com.ragingmenace.MenuMeters.plist.erb"
    owner WS_USER
  end

  execute "Restart SystemUIServer" do
    command 'killall -HUP SystemUIServer'
    user WS_USER
    # we don't care if it fails because it means
    # SystemUIServer wasn't running in the first place
    returns [0, 1]
  end

  ruby_block "test to see if MenuMeters was installed" do
    block do
      raise "MenuMeters install failed" unless File.exists?(menu_meters_dst)
    end
  end
end
