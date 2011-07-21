unless File.exists?("/Applications/" + node["rubymine_basename"])

  remote_file "/tmp/rubymine.dmg" do
    source node["rubymine_download_uri"]
    mode "0644" 
  end
  
  execute "mount rubymine dmg" do
    command "hdid /tmp/rubymine.dmg"
    user WS_USER
  end

  execute "copy rubymine to /Applications" do
    command "cp -rf #{Regexp.escape(node["rubymine_dmg_mnt"]+ "/" + node["rubymine_basename"])} /Applications/"
    user WS_USER
  end

  execute "unmount dmg" do
    command "hdiutil detach #{Regexp.escape(node["rubymine_dmg_mnt"])}"
    user WS_USER
  end

  ruby_block "test to see if RubyMine was installed" do
    block do
      raise "RubyMine install failed" unless File.exists?("/Applications/" + node["rubymine_basename"])
    end
  end
end
