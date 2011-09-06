unless File.exists?("/Applications/CCMenu.app")

  remote_file "/tmp/ccmenu.dmg" do
    source node["ccmenu_download_uri"]
    mode "0644"
  end

  execute "mount CCMenu dmg" do
    command "hdid /tmp/ccmenu.dmg"
    user WS_USER
  end

  execute "copy CCMenu to /Applications" do
    command "rsync -a #{Regexp.escape(node["ccmenu_dmg_mnt"]+ "/CCMenu.app")} /Applications/"
    user WS_USER
  end

  execute "unmount dmg" do
    command "hdiutil detach #{Regexp.escape(node["ccmenu_dmg_mnt"])}"
    user WS_USER
  end

  ruby_block "test to see if CCMenu was installed" do
    block do
      raise "CCMenu install failed" unless File.exists?("/Applications/CCMenu.app")
    end
  end
end
