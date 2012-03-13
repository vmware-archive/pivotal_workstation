unless File.exists?(node['mouse_locator_dst'])

  remote_file "#{Chef::Config[:file_cache_path]}/mouse_locator.dmg" do
    source node["mouse_locator_download_uri"]
    mode "0644"
    action :create_if_missing
  end

  execute "mount mouse_locator dmg" do
    command "hdid #{Chef::Config[:file_cache_path]}/mouse_locator.dmg"
    user WS_USER
  end

  # We're bypassing the installer.app because it requires intervention.
  # per the installer readme, the installer does the following:
  # (I put YES/NO in front of each step if we do it/don't do it).
  # - NO: Deactivate any previous version of Mouse Locator
  # - YES: Close the System Preferences, if open
  # - NO: Remove any previously installed Mouse Locator
  # - YES: Install a new version of Mouse Locator into:
  #     {HomeFolder}/Library/PreferencePanes/
  # - YES: Activate Mouse Locator, if previously active
  # - NO: Open the System Preferences, and display the Mouse Locator
  #   Preferences Pane

  execute "Close System Preferences" do
    command 'killall "System Preferences"'
    user WS_USER
    # we don't care if it fails because it means
    # System Prefs wasn't running in the first place
    returns [0, 1]
  end

  execute "Copy mouse_locator to ~/Library/PreferencePanes/" do
    command "cp -rf #{Regexp.escape(node["mouse_locator_src"])} #{Regexp.escape(node['mouse_locator_dst'])}"
    user WS_USER
  end

  execute "unmount dmg" do
    command "hdiutil detach #{Regexp.escape(node["mouse_locator_dmg_mnt"])}"
    user WS_USER
  end

  execute "Activate Mouse Locator" do
    command "open #{node["mouse_locator_app"]} &"
    user WS_USER
  end

  ruby_block "test to see if mouse_locator was installed" do
    block do
      raise "Mouse Locator install failed" unless File.exists?(node['mouse_locator_dst'])
    end
  end
end
