##  This is very experimental and unsupported.

run_unless_marker_file_exists("text_mate_1_5_9") do
  execute "download text mate to temp dir" do
    command "curl -o /tmp/textmate.dmg http://download.macromates.com/TextMate_1.5.9.dmg"
    user WS_USER
  end
  
  execute "mount text mate dmg" do
    command "hdid /tmp/textmate.dmg"
    user WS_USER
  end
  
  execute "copy text mate to /Applications" do
    command 'cp -rf /Volumes/TextMate\\ 1.5.9/TextMate.app /Applications/'
    user WS_USER
  end
  
  execute "unmount dmg" do
    command "hdiutil detach  /Volumes/TextMate\\ 1.5.9/"
    user WS_USER
  end

  execute "link textmate" do
    command "ln -s /Applications/TextMate.app/Contents/Resources/mate /usr/local/bin/mate"
    not_if "test -e /usr/local/bin/mate"
  end
end
