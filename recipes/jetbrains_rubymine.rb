run_unless_marker_file_exists("jetbrains_rubymine") do
  execute "download rubymine to temp dir" do
    # pass the '-L' because jetbrains uses a 302
    command "curl -L -o /tmp/jetbrains_rubymine.dmg #{node["rubymine_download_location"]}"
    user WS_USER
  end

  execute "mount rubymine dmg" do
    command "hdid /tmp/jetbrains_rubymine.dmg"
    user WS_USER
  end

  execute "copy chrome to /Applications" do
    command 'cp -rf /Volumes/RubyMine\\ 3.1.1/RubyMine\\ 3.1.1.app /Applications/'
  end

  execute "unmount dmg" do
    command "hdiutil detach  /Volumes/RubyMine\\ 3.1.1/"
    user WS_USER
  end
end
